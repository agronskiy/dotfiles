## Cinnamon keybindings

Sounds like saving and loading them needs additional command:

Code: Select all

```bash
dconf load /org/cinnamon/desktop/keybindings/ < cinnamon.keys.txt
```

Dumping via
```bash
dconf dump /org/cinnamon/desktop/keybindings/ > cinnamon.keys.txt
```

## Fingerprint reader stops being offered at login

**Symptom.** The login screen (and `sudo`) stop offering fingerprint auth. `lsusb`
still shows the reader and its descriptors are perfectly healthy, but
`fprintd-list $USER` says *"No devices available"* and the D-Bus manager returns
an empty array:

```bash
dbus-send --system --print-reply --dest=net.reactivated.Fprint \
  /net/reactivated/Fprint/Manager net.reactivated.Fprint.Manager.GetDevices
```

**Cause.** The Synaptics sensor (`06cb:0123`) wedges in firmware. It keeps
answering the USB core's standard requests — which is why `lsusb` looks fine —
but stops answering libfprint's vendor probe, so libfprint drops it and fprintd
exposes zero devices. It is *not* a missing driver: `06cb:0123` is in the ID
table of the stock `libfprint-2-2`, and no `libfprint-2-tod1-*` package is
needed. The trigger is a bus power glitch on dock/charger attach/detach; the
tell is the reader having a *higher* USB device number than the internal camera
and Bluetooth, meaning it re-enumerated some time after boot.

**Fix.** A `USBDEVFS_RESET` on the device node. No root needed for the ioctl
itself — the node is `crw-rw-rw-`. Note that this re-initialises the device in
place: since the descriptors are unchanged the kernel keeps the same
`struct usb_device`, so the device number does *not* change and *no* udev
`add` event is emitted. A real cable glitch, by contrast, is a true
disconnect/reconnect and does emit `remove` + `add`.

`bin/fingerprint-fix` wraps this:

```bash
fingerprint-fix            # reset only if fprintd sees 0 devices (safe to spam)
fingerprint-fix --force    # reset unconditionally
fingerprint-fix --status   # report, change nothing
```

### Making it automatic — needs a manual install step

```bash
fingerprint-fix --install     # asks for sudo
```

This installs two root-owned files that are *not* handled by
`bin/symlink-everything`, so they must be (re)installed by hand on a new machine:

| Source | Installed to | Fires when |
|---|---|---|
| `linux/fingerprint-fix.service.in` | `/etc/systemd/system/fingerprint-fix.service` | resume from suspend/hibernate |
| `linux/99-fingerprint-fix.rules` | `/etc/udev/rules.d/99-fingerprint-fix.rules` | the reader (re-)appears on USB |

Both survive reboots: they are ordinary files under `/etc`, and `--install` runs
`systemctl enable`, which drops symlinks into `suspend.target.wants/` and the
three other sleep targets. Nothing needs re-running at login.

The udev rule is the one that actually covers the dock case, since detaching a
cable does not involve a suspend. Both call the same script, which is a no-op
when fprintd already sees the reader and rate-limits itself to one reset per
30s.

### Portability to another laptop

Neither the script nor the rule hardcodes `06cb:0123`. The reader is identified
by **vendor id + a vendor-specific (0xff) USB interface**, which is the shape
every laptop fingerprint sensor has, and which is what keeps the heuristic from
matching e.g. a Synaptics HID touchpad. The vendor list lives in
`FPRINT_USB_VENDORS` in `bin/fingerprint-fix` and is mirrored in the udev rule —
keep the two in sync when adding one.

The udev rule matches on vendor id alone and deliberately over-matches; the
script does the finer check, so a false positive there costs nothing.

If a machine needs something else, drop an override in
`/etc/fingerprint-fix.conf` (sourced by the script) rather than editing it:

```bash
# pin exact devices, bypassing the vendor heuristic
FPRINT_USB_IDS="27c6:5395"
# or just extend the vendor list
FPRINT_USB_VENDORS="06cb 27c6 1234"
```

Check what it resolves to with `fingerprint-fix --status`.

Undo with `fingerprint-fix --uninstall`.

### Debugging notes

- fprintd's own logs need journal access: `sudo usermod -aG adm $USER` (a plain
  `sudo` user is not in `adm` or `systemd-journal` and gets nothing from
  `journalctl -u fprintd`).
- To confirm the reader is a supported ID rather than guessing, grep the library
  for the vid/pid pair — the table stores product id first, then vendor id:
  ```bash
  python3 -c "
  import struct
  d=open('/usr/lib/x86_64-linux-gnu/libfprint-2.so.2','rb').read()
  print(d.find(struct.pack('<II',0x0123,0x06cb)))"
  ```
- If `open-fprintd` / `python3-validity` were ever tried, make sure they are
  purged (`dpkg -l | grep -i fprintd` showing `rc` means leftover configs);
  they fight with fprintd over the same D-Bus name.
