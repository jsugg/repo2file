#!/usr/bin/env bash

# Define named constants for error codes
declare -r ERR_CODE=1
declare -r INTERRUPT_CODE=2
declare -r UNSUPPORTED_PLATFORM=3
declare -r UNKNOWN_PACKAGE_MANAGER=4
declare -r HOMEBREW_INSTALL_FAILED=5
declare -r CHOCOLATEY_INSTALL_FAILED=6
declare -r SCRIPT_DOWNLOAD_FAILED=7
declare -r NO_WRITE_PERMISSIONS=8

# Define script metadata
declare -r SCRIPT_NAME="repo2file"
declare -r SCRIPT_URL="https://raw.githubusercontent.com/jsugg/repo2file/main/src/$SCRIPT_NAME"
declare -r SCRIPT_CHECKSUM_URL="https://gist.githubusercontent.com/jsugg/56a75fe37a4c0a15786c10b63a5f1ccc/raw/0b754fa09b3672a446dabda291144552467f57e6/repo2file.sha256"
declare INSTALL_DIR=""
declare -r DEFAULT_INSTALL_DIR="$HOME/bin"
declare -r DEPENDENCIES=("curl" "sha256sum" "tree" "file" "git" "awk")

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Trap signals to call cleanup function
trap "cleanup; printf \"An error occurred.\n\"; exit $ERR_CODE" ERR
trap "cleanup; printf \"Script interrupted.\n\"; exit $INTERRUPT_CODE" INT TERM SIGHUP

# Cleanup function to handle script interruptions and errors
function cleanup() {
    local bin_dir="${INSTALL_DIR:-${DEFAULT_INSTALL_DIR}}"
    if [[ -d "${bin_dir}" && -f "${bin_dir}/${SCRIPT_NAME}" ]]; then
        rm -f "${bin_dir}/${SCRIPT_NAME}" "${bin_dir}/${SCRIPT_NAME}.sha256"
    fi
}

# Helper function to log messages with time stamps and colored output
function log() {
    printf "%b%b - %b%b\n" "$BLUE" "$(date '+%F %T')" "$1" "$NC"
}

# Helper function to get the current OS
function get_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            case $ID in
            debian | ubuntu) echo "Ubuntu/Debian" ;;
            fedora | rhel | centos) echo "RHEL-based" ;;
            arch) echo "Arch Linux" ;;
            opensuse-leap | sles | opensuse-tumbleweed) echo "openSUSE" ;;
            alpine) echo "Alpine Linux" ;;
            *) echo "Unknown Linux distribution" ;;
            esac
        else
            echo "Unknown Linux distribution"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macOS"
    elif [[ "$OSTYPE" == "cygwin"* || "$OSTYPE" == "msys"* ]]; then
        echo "Windows"
    else
        echo "Unsupported OS type: $OSTYPE"
    fi
}

# Helper function to get the package manager for the current platform
function discover_package_manager() {
    local os=''
    
    os=$(get_os)

    if [[ "$os" == "Ubuntu/Debian" ]]; then
        echo "apt-get"
    elif [[ "$os" == "RHEL-based" ]]; then
        if [ "${VERSION_ID::1}" -ge 8 ]; then
            echo "dnf"
        else
            echo "yum"
        fi
    elif [[ "$os" == "Arch Linux" ]]; then
        echo "pacman"
    elif [[ "$os" == "openSUSE" ]]; then
        echo "zypper"
    elif [[ "$os" == "Alpine Linux" ]]; then
        echo "apk"
    elif [[ "$os" == "macOS" ]]; then
        if command -v brew >/dev/null; then
            echo "brew"
        else
            echo "homebrew"
        fi
    elif [[ "$os" == "Windows" ]]; then
        if command -v choco >/dev/null; then
            echo "choco"
        else
            echo "chocolatey"
        fi
    else
        echo "unknown"
    fi
}

# Function to install dependencies
function verify_and_install_dependencies() {
    local missing_deps=()
    local package_manager=''
    
    package_manager=$(discover_package_manager)

    for dep in "${DEPENDENCIES[@]}"; do
        if [[ "$dep" == "sha256sum" ]] && [[ "$package_manager" == "brew" || "$package_manager" == "homebrew" ]]; then
            dep="shasum"
        fi
        command -v "$dep" >/dev/null || missing_deps+=("$dep")
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        case "$package_manager" in
        apt-get) sudo apt-get install -y "${missing_deps[@]}" ;;
        yum) sudo yum install -y "${missing_deps[@]}" ;;
        dnf) sudo dnf install -y "${missing_deps[@]}" ;;
        pacman) sudo pacman -S --noconfirm "${missing_deps[@]}" ;;
        zypper) sudo zypper install -y "${missing_deps[@]}" ;;
        apk) sudo apk add "${missing_deps[@]}" ;;
        brew) HOMEBREW_NO_AUTO_UPDATE=1 brew install "${missing_deps[@]}" ;;
        choco) choco install --yes "${missing_deps[@]}" ;;
        homebrew)
            if [[ "$os" == "macOS" ]]; then
                echo "Installing Homebrew..."
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                if [ $? -ne 0 ]; then
                    echo "Homebrew installation failed."
                    exit $HOMEBREW_INSTALL_FAILED
                fi
                package_manager="brew"
            fi
            brew install "${missing_deps[@]}"
            ;;
        chocolatey)
            if [[ "$os" == "Windows" ]]; then
                echo "Installing Chocolatey..."
                @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
                if [ $? -ne 0 ]; then
                    echo "Chocolatey installation failed."
                    exit $CHOCOLATEY_INSTALL_FAILED
                fi
            fi
            choco install --yes "${missing_deps[@]}"
            ;;
        *)
            echo "Unknown package manager: $package_manager"
            exit $UNKNOWN_PACKAGE_MANAGER
            ;;
        esac

        # Install dependencies after installing the package manager, if needed
        case "$package_manager" in
        brew) brew install "${missing_deps[@]}" ;;
        choco) choco install --yes "${missing_deps[@]}" ;;
        *)
            echo "Unknown package manager: $package_manager"
            exit $UNKNOWN_PACKAGE_MANAGER
            ;;
        esac
    fi
}

# Helper function for compatibility with both GNU and BSD/macOS sed
function sed_inplace() {
    local command=$1
    local file=$2

    # Check for macOS specifically to use BSD sed syntax
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo -e "$command" | sed -i "" -f- "$file"
    else
        sed -i "$command" "$file"
    fi
}

# Function to determine the appropriate shell configuration file
function find_appropriate_shell_config_file() {
    local current_shell=''
    
    current_shell=$(basename "$SHELL")

    case $current_shell in
    bash | sh | dash | ksh | mksh | posh)
        echo "$HOME/.bashrc"
        ;;
    zsh)
        echo "$HOME/.zshrc"
        ;;
    fish)
        echo "$HOME/.config/fish/config.fish"
        ;;
    tcsh | csh)
        echo "$HOME/.cshrc"
        ;;
    *)
        echo "$HOME/.profile"
        ;;
    esac
}

# Helper function to update the PATH environment variable in the shell configuration
function update_path_in_shell_config() {
    local install_dir=$1
    local shell_config_file=$2
    local path_lines=''
    local first_line=''
    local current_path_line=''
    local new_path=''

    # Fetch all lines containing 'export PATH='
    path_lines=$(grep -n '^export PATH=' "$shell_config_file")
    if [[ -z "$path_lines" ]]; then
        # If no export PATH line exists, simply add one
        echo "export PATH=\$PATH:$install_dir" >>"$shell_config_file"
        log "${GREEN}Added PATH in $shell_config_file.${NC}"
        return
    fi

    # Check if INSTALL_DIR is already in any PATH statement
    if echo "$path_lines" | grep -q "$install_dir"; then
        log "${GREEN}$install_dir is already in the PATH.${NC}"
        return
    fi

    # Update only the first 'export PATH' line if INSTALL_DIR is not found
    first_line=$(echo "$path_lines" | head -1 | cut -d: -f1)
    current_path_line=$(head -n "$first_line" "$shell_config_file" | tail -n 1)
    new_path="${current_path_line}:${install_dir}\""

    # Use the sed_inplace function to update
    sed_inplace "${first_line}s|.*/|$new_path|" "$shell_config_file"
    log "${GREEN}Updated PATH in $shell_config_file.${NC}"
}

# Helper function to find the user's bin folder
function user_bin_folder() {
    local os=''
    local bin_folder=''
    local shell_config=''

    os=$(get_os)

    case "$os" in
    "Ubuntu/Debian" | "RHEL-based" | "Arch Linux" | "openSUSE" | "Alpine Linux")
        bin_folder="$HOME/bin"
        ;;
    "macOS")
        bin_folder="/usr/local/bin"
        ;;
    "Windows")
        bin_folder="$USERPROFILE\\bin"
        ;;
    "Unknown Linux distribution" | "Unsupported OS type:"*)
        echo "Unsupported or unknown operating system."
        exit $UNSUPPORTED_PLATFORM
        ;;
    *)
        echo "Unexpected OS output from get_os function: $os"
        exit $ERR_CODE
        ;;
    esac

    if ! [ -d "$bin_folder" ]; then
        mkdir -p "$bin_folder"
    fi

    if ! [ -w "$bin_folder" ]; then
        echo "Error: $bin_folder is not writable by the user."
        exit $NO_WRITE_PERMISSIONS
    fi

    if ! echo "$PATH" | grep -q "(^|:)$bin_folder($|:)" && [[ "$os" != "Windows" ]]; then
        shell_config="$(find_appropriate_shell_config_file)"
        if [ -f "$shell_config" ]; then
            update_path_in_shell_config "$bin_folder" "$shell_config" >/dev/null 2>&1
            wait $!
        fi
    elif [[ "$os" == "Windows" ]] && ! ([ -n "${PATH}" ] && echo "${PATH}" | findstr /R "^;\%USERPROFILE\%\\AppData\\Local\\bin;$" >nul 2>&1); then
        reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "%%PATH%%;%bin_folder%" /f >nul 2>&1
    fi

    printf "%s" "$bin_folder"
}

# Helper function to get the shasum command
function get_shasum_cmd() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "shasum -a 256"
    else
        echo "sha256sum"
    fi
}

# Download, verify, and install the script
function install_script() {
    local retries=3
    local success=0

    INSTALL_DIR="$(user_bin_folder)"

    if [ -d "$INSTALL_DIR" ]; then
        log "${YELLOW}Downloading ${SCRIPT_NAME} to ${INSTALL_DIR}...${NC}"
        for ((i = 0; i < retries; i++)); do
            if curl -H "Cache-Control: no-cache" --silent -fLo "${INSTALL_DIR}/${SCRIPT_NAME}" "${SCRIPT_URL}" &&
                curl -H "Cache-Control: no-cache" --silent -fLo "${INSTALL_DIR}/${SCRIPT_NAME}.sha256" "${SCRIPT_CHECKSUM_URL}"; then

                log "${GREEN}Verifying download...${NC}"
                cd "${INSTALL_DIR}" || exit $ERR_CODE
                sed_inplace '$ s/[ \t]*$//' "${SCRIPT_NAME}.sha256"
                expected_checksum=$(awk '{print $1}' "${SCRIPT_NAME}.sha256")
                calculated_checksum=$($(get_shasum_cmd) "${SCRIPT_NAME}" | awk '{print $1}')
                if [[ "${expected_checksum}" == "${calculated_checksum}" ]]; then
                    chmod +x "${SCRIPT_NAME}"
                    success=1
                    break
                else
                    log "${RED}Checksum verification failed.${NC}"
                    log "${BLUE}Expected:   ${expected_checksum}${NC}"
                    log "${RED}Calculated: ${calculated_checksum}${NC}"
                    log "${YELLOW}Retrying download...${NC}"
                fi
            else
                log "${RED}Attempt $(($i + 1)) failed. Retrying in 3 seconds.${NC}"
                sleep 3
            fi
        done
    fi

    if [ $success -eq 0 ]; then
        log "${RED}Failed to download and install ${SCRIPT_NAME} after $retries attempts.${NC}"
        exit $SCRIPT_DOWNLOAD_FAILED
    fi
    log "${GREEN}Installation completed.${NC}"
}

# Entry point
function main() {
    verify_and_install_dependencies
    install_script
    echo "Run \`${SCRIPT_NAME} -h\` to see usage information."
}

# Execute the main function
main "$@"
