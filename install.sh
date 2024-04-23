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
declare -r SCRIPT_URL="https://github.com/jsugg/repo2file/blob/main/$SCRIPT_NAME"
declare -r SCRIPT_CHECKSUM_URL="https://gist.githubusercontent.com/jsugg/56a75fe37a4c0a15786c10b63a5f1ccc/raw/ba872193de73536b7c0e28f23d294938510bf66a/repo2file.sha256"
declare INSTALL_DIR=""
declare -r DEFAULT_INSTALL_DIR="$HOME/bin"
declare -r DEPENDENCIES=("curl" "sha256sum" "tree" "file" "git")

# Color definitions for pretty output
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
    printf "%b%b - %b%b\n" "$BLUE" "$(date +%Y-%m-%d %H:%M:%S)" "$1" "$NC"
}

# Helper function to get the current OS
function get_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            case $ID in
                debian|ubuntu) echo "Ubuntu/Debian" ;;
                fedora|rhel|centos) echo "RHEL-based" ;;
                arch) echo "Arch Linux" ;;
                opensuse-leap|sles|opensuse-tumbleweed) echo "openSUSE" ;;
                alpine) echo "Alpine Linux" ;;
                *) echo "Unknown Linux distribution" ;;
            esac
        else
            echo "Unknown Linux distribution"
        fi
    elif [[ "$OSTYPE" == "darwin" ]]; then
        echo "macOS"
    elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" ]]; then
        echo "Windows"
    else
        echo "Unsupported OS type: $OSTYPE"
    fi
}

# Helper function to get the package manager for the current platform
discover_package_manager() {
    local os=$(get_os)

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
            echo "missing"
        fi
    elif [[ "$os" == "Windows" ]]; then
        if command -v choco >/dev/null; then
            echo "choco"
        else
            echo "missing"
        fi
    else
        echo "unknown"
    fi
}

# Function to install dependencies
function install_dependencies() {
    local missing_deps=()
    local package_manager=$(discover_package_manager)

    for dep in "${DEPENDENCIES[@]}"; do
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
                missing)
                    if [[ "$os" == "macOS" ]]; then
                        echo "Installing Homebrew..."
                        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
                        if [ $? -ne 0 ]; then
                            echo "Homebrew installation failed."
                            exit $HOMEBREW_INSTALL_FAILED
                        fi
                        package_manager="brew"
                    elif [[ "$os" == "Windows" ]]; then
                        echo "Installing Chocolatey..."
                        @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
                        if [ $? -ne 0 ]; then
                            echo "Chocolatey installation failed."
                            exit $CHOCOLATEY_INSTALL_FAILED
                        fi
                        package_manager="choco"
                    fi
                    ;;
                *) echo "Unknown package manager: $package_manager"; exit $UNKNOWN_PACKAGE_MANAGER ;;
            esac

            # Install dependencies after installing the package manager, if needed
            case "$package_manager" in
                brew) brew install "${missing_deps[@]}" ;;
                choco) choco install --yes "${missing_deps[@]}" ;;
                *) echo "Unknown package manager: $package_manager"; exit $UNKNOWN_PACKAGE_MANAGER ;;
            esac
    fi
}

# Helper function to find the user's bin folder
user_bin_folder() {
  local os=$(get_os)
  local bin_folder=""
  local bin_folder=""

  case "$os" in
    "Ubuntu/Debian"|"RHEL-based"|"Arch Linux"|"openSUSE"|"Alpine Linux")
      bin_folder="$HOME/bin"
      ;;
    "macOS")
      bin_folder="/usr/local/bin"
      ;;
    "Windows")
      bin_folder="$USERPROFILE\\bin"
      ;;
    "Unknown Linux distribution"|"Unsupported OS type:"*)
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
    local current_shell=$(basename "$SHELL")
    local shell_config=""
    local path_update=""
    local fish_path_update=""

    case $current_shell in
      bash|sh|dash|ksh|mksh|posh)
        shell_config="$HOME/.bashrc"
        path_update="export PATH=\"\$PATH:$bin_folder\""
        ;;
      zsh)
        shell_config="$HOME/.zshrc"
        path_update="export PATH=\"\$PATH:$bin_folder\""
        ;;
      fish)
        shell_config="$HOME/.config/fish/config.fish"
        fish_path_update="set -gx PATH \$PATH $bin_folder"
        ;;
      tcsh|csh)
        shell_config="$HOME/.cshrc"
        path_update="setenv PATH \"\$PATH:$bin_folder\""
        ;;
      *)
        shell_config="$HOME/.profile"
        path_update="export PATH=\"\$PATH:$bin_folder\""
        ;;
    esac

    if [ -f "$shell_config" ]; then
      if grep -qFx "$path_update" "$shell_config"; then
        true
      elif grep -q 'fish_config' <<< "$shell_config"; then
        if grep -qFx "$fish_path_update" "$shell_config"; then
          true
        else
          sed -i.bak -e '$a\'"$fish_path_update"\" "$shell_config"
        fi
      else
        sed -i.bak -e '$a'"$path_update" "$shell_config"
      fi
    fi
  elif [[ "$os" == "Windows" ]] && ! ([ -n "${PATH}" ] && echo "${PATH}" | findstr /R "^;\%USERPROFILE\%\\AppData\\Local\\bin;$" >nul 2>&1); then
    reg add "HKCU\Environment" /v PATH /t REG_EXPAND_SZ /d "%%PATH%%;%bin_folder%" /f >nul 2>&1
  fi

  printf "%s" "$bin_folder"
}

# Helper function to get the shasum command
function get_shasum_cmd() {
    if [[ "$OSTYPE" == "darwin" ]]; then
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

    log "${YELLOW}Downloading ${SCRIPT_NAME} to ${INSTALL_DIR}...${NC}"
    for ((i=0; i<retries; i++)); do
        if curl -fLo "${INSTALL_DIR}/${SCRIPT_NAME}" "${SCRIPT_URL}" &&
           curl -fLo "${INSTALL_DIR}/${SCRIPT_NAME}.sha256" "${SCRIPT_CHECKSUM_URL}"; then

            log "${GREEN}Verifying download...${NC}"
            cd "${INSTALL_DIR}" && if $(get_shasum_cmd) -c "${SCRIPT_NAME}.sha256" >/dev/null 2>&1; then
                chmod +x "${SCRIPT_NAME}"
                success=1
                break
            else
                log "${RED}Checksum verification failed. Retrying download...${NC}"
            fi
        else
            log "${RED}Attempt $(($i + 1)) failed. Retrying in 3 seconds.${NC}"
            sleep 3
        fi
    done

    if [ $success -eq 0 ]; then
        log "${RED}Failed to download and install ${SCRIPT_NAME} after $retries attempts.${NC}"
        exit $SCRIPT_DOWNLOAD_FAILED
    fi
    log "${GREEN}Installation completed. Run '${YELLOW}${SCRIPT_NAME} -h${GREEN}' to see usage information.${NC}"
}

# Entry point
main() {
    install_dependencies
    install_script
}

# Execute the main function
main "$@"
