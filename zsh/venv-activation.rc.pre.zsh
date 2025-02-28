# Function to check if a directory is a virtual environment
_is_venv() {
    [[ -f "${1}/bin/activate" ]]
}

# Completion function for activate_venv
_activate_venv_complete() {
    local -a venvs
    local dir subdir venv_name

    # Check current directory
    if _is_venv "./"; then
        venvs+=(".")
    fi

    # Check immediate subdirectories and their subdirectories
    for dir in */ .*/ ; do
        if [[ ! -d "$dir" || "$dir" == "./" || "$dir" == "../" ]]; then
            continue
        fi
        if _is_venv "$dir"; then
            venvs+=("${dir%/}")
        else
            # Check if there are any subdirectories before attempting to iterate
            if [[ -n "$(find "$dir" -mindepth 1 -maxdepth 1 -type d -print -quit)" ]]; then
                while IFS= read -r subdir; do
                    if _is_venv "$subdir"; then
                        venv_name="${dir%/}/${subdir#$dir}"
                        venvs+=("${venv_name%/}")
                    fi
                done < <(find "$dir" -mindepth 1 -maxdepth 1 -type d)
            fi
        fi
    done

    _describe 'virtual environments' venvs
}

function __activate_venv() {
    # Check if the provided argument is a valid environment
    if _is_venv "$1"; then
        source "$1/bin/activate"
        echo "Activated virtual environment: $1"
        return 0
    fi

    echo "Error: '$1' is not a valid virtual environment."
    return 1
}

alias vact=__activate_venv
# Register the completion function
compdef _activate_venv_complete __activate_venv


