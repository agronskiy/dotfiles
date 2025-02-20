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
