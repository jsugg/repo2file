# Project Codebase
## Root directory
 `/Users/juanpedrosugg/dev/github/repo2file`
---
## Directory structure:
```
.
├── LICENSE
├── README.md
├── install.sh
├── repo2file.md
└── src
    └── repo2file

2 directories, 5 files
```

---
## File: LICENSE
```
MIT License

Copyright (c) 2024 Juan Pedro Sugg

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---
## File: README.md
See raw repo2file.md for markdown file contents
<!-- [FILE_START]
# repo2file

`repo2file` is a powerful command-line tool that processes files within a Git repository, intelligently identifying and including only text files. It appends their contents and the project's directory structure to a comprehensive markdown file.

This tool is particularly valuable for providing AI models with crucial context about your project's codebase. By generating thorough documentation that captures the structure and contents of your codebase, `repo2file` equips AI models with the necessary information to understand and reason about your project effectively.

Whether you're leveraging AI for code analysis, refactoring, or other development tasks, `repo2file` ensures that your AI models have access to a centralized, easily accessible reference for your codebase, enhancing their ability to deliver accurate and reliable results.

## Features

- **Filters Text Files**: The tool automatically identifies and includes only text files in the output, excluding binary files.
- **Exclude Patterns**: You can specify patterns to exclude specific files or directories from being processed.
- **Git Integration**: The tool seamlessly integrates with Git, allowing you to exclude files based on the project's `.gitignore` rules.
- **Progress Display**: A progress bar keeps you informed about the processing status.
- **Verbose Mode**: Get detailed logs and information during the execution.
- **Quiet Mode**: Suppress all output except errors.
- **Custom Output File**: Specify a custom filename for the generated markdown file.

## Installation

Simply copy the line below and paste it into your terminal:

```bash
curl -sSL https://raw.githubusercontent.com/jsugg/repo2file/main/install.sh | bash -s
```

## Usage

Navigate to your Git repository, and run the script with the desired options:

```bash
cd /path/to/your/repo
repo2file [options]
```

### Options

```
Usage: repo2file.sh [options]

This script processes the files within a Git repository, checking for text files and appending their contents and the project's directory structure to a markdown file.

Options:
  -h, --help           Show this help message and exit.
  -v, --verbose        Enable verbose mode. Prints detailed logs to standard output.
  -q, --quiet          Disable all output except errors.
  -p, --progress       Enable progress display, showing a progress bar during execution.
  -o, --output FILE    Specify the output markdown file where results should be written. Default is 'repo2file.md'.
  -e, --exclude PATTERN Exclude files or directories that match this pattern. Can be specified multiple times.
  -g, --gitignore      Apply .gitignore rules for excluding files.
```

### Supported Exclusion Patterns

| Pattern           | Description                                                      |
|-------------------|------------------------------------------------------------------|
| `*`               | Matches any file or directory name, without crossing directories.|
| `?`               | Matches any single character, excluding directory separators.   |
| `foo`             | Matches a specific file named `foo` in the root directory.       |
| `'foo?bar.ext'`     | Matches files like `fooXbar.ext` where `X` is any single character.|
| `'[abc]*.ext'`      | Matches any file starting with 'a', 'b', or 'c' and ending with `.ext`.|
| `'*.ext'`           | Matches any file ending in `.ext` in the current directory.      |
| `'**/dir'`             | Matches any directory named `dir` recursively.                               |
| `'**/*.ext'`        | Matches files ending in `.ext` anywhere in the directory tree.   |
| `'dir/'`            | Matches any files inside `dir/` directory at the root.           |
| `'dir/*.ext'`       | Matches files ending in `.ext` within the `dir/` directory only. |
| `'dir/**/'`         | Matches all files and directories inside `dir/` directory recursively.|
| `'dir/**/*.ext'`    | Matches files ending in `.ext` at any level inside the `dir/` directory.|
| `'dir/foo[abc].ext'`| Matches files like `dir/fooa.ext`, `dir/foob.ext`, and `dir/fooc.ext`.|

### Examples

- Run the script in the current directory with default settings:

  ```bash
  repo2file
  ```

- Run the script and output to `results.md`:

  ```bash
  repo2file --output results.md
  ```

- Run the script in verbose mode, show progress, and exclude files matching `*.tmp`:

  ```bash
  repo2file -v -p --exclude '*.tmp'
  ```

- Apply `.gitignore` rules when processing files:

  ```bash
  repo2file -g
  ```

- Run the script in verbose mode and apply `.gitignore` rules:

  ```bash
  repo2file -vg
  ```

- Run the script displaying progress and applying `.gitignore` rules:

  ```bash
  repo2file -pg
  ```

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the GitHub repository.

## License

This project is licensed under the [MIT License](LICENSE)

## Markdown file format

# Project Codebase
## Root directory
`/Users/jsugg/dev/github/repo2file`
---
## Directory structure:
```
.
├── LICENSE
├── README.md
├── install.sh
├── repo2file
├── repo2file.md
└── src
    └── repo2file

2 directories, 6 files
```

---
## File: LICENSE
```
MIT License

Copyright (c) 2024 Juan Pedro Sugg

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

...
```

---
## File: README.md
See raw repo2file.md for markdown file contents
---
## File: install.sh
```
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
declare -r SCRIPT_CHECKSUM_URL="https://gist.githubusercontent.com/jsugg/56a75fe37a4c0a15786c10b63a5f1ccc/raw/ba872193de73536b7c0e28f23d294938510bf66a/repo2file.sha256"
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

...
```

---
## File: src/repo2file
```
#!/usr/bin/env bash

# Error codes as named constants
declare -r ERR_CODE=1
declare -r INTERRUPT_CODE=2
declare -r DEP_MISSING_ERR_CODE=3
declare -r OUTPUT_FILE_ERR_CODE=4
declare -r GIT_REPO_ERR_CODE=5
declare -r FILE_ACCESS_ERR_CODE=6
declare -r EMPTY_DIR_ERR_CODE=7
declare -r DIR_CREATION_ERR_CODE=8

# Script metadata
declare -r SCRIPT_NAME=$(basename "$0")
declare -r WORKING_DIR=$(pwd)
declare -r TERM_COLUMNS=80
declare verbose=0 quiet=0 progress=0 use_gitignore=0
declare exclude_patterns=()
declare exclude_regex=""
declare temp_dir=""
declare output_file_name="repo2file.md"

# Set traps for different exit scenarios
trap 'graceful_exit $ERR_CODE' ERR
trap 'graceful_exit $INTERRUPT_CODE' INT TERM SIGHUP
trap 'graceful_exit $?' EXIT

# Clean up function
function cleanup() {
    # Ensure temp_dir is not unset or empty
    [[ -n "$temp_dir" && -d "$temp_dir" ]] && rm -rf "$temp_dir"
    set +f
}

...
```

---
[FILE_END] -->
---
## File: install.sh
```
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
declare -r SCRIPT_CHECKSUM_URL="https://gist.githubusercontent.com/jsugg/56a75fe37a4c0a15786c10b63a5f1ccc/raw/13ec7edd258fc2db592278f542cb1607fe231f16/repo2file.sha256"
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
            if curl --silent -fLo "${INSTALL_DIR}/${SCRIPT_NAME}" "${SCRIPT_URL}" &&
                curl --silent -fLo "${INSTALL_DIR}/${SCRIPT_NAME}.sha256" "${SCRIPT_CHECKSUM_URL}"; then

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
                    log "${RED}Checksum verification failed. Retrying download...${NC}"
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
    log "${GREEN}Installation completed. Run '${YELLOW}${SCRIPT_NAME} -h${GREEN}' to see usage information.${NC}"
}

# Entry point
function main() {
    verify_and_install_dependencies
    install_script
}

# Execute the main function
main "$@"
```

---
## File: src/repo2file
```
#!/usr/bin/env bash

# Error codes as named constants
declare -r ERR_CODE=1
declare -r INTERRUPT_CODE=2
declare -r DEP_MISSING_ERR_CODE=3
declare -r OUTPUT_FILE_ERR_CODE=4
declare -r GIT_REPO_ERR_CODE=5
declare -r FILE_ACCESS_ERR_CODE=6
declare -r EMPTY_DIR_ERR_CODE=7
declare -r DIR_CREATION_ERR_CODE=8

# Script metadata
declare -r SCRIPT_NAME=$(basename "$0")
declare -r WORKING_DIR=$(pwd)
declare -r TERM_COLUMNS=80
declare verbose=0 quiet=0 progress=0 use_gitignore=0
declare exclude_patterns=()
declare exclude_regex=""
declare temp_dir=""
declare output_file_name="repo2file.md"

# Set traps for different exit scenarios
trap 'graceful_exit $ERR_CODE' ERR
trap 'graceful_exit $INTERRUPT_CODE' INT TERM SIGHUP
trap 'graceful_exit $?' EXIT

# Clean up function
function cleanup() {
    # Ensure temp_dir is not unset or empty
    [[ -n "$temp_dir" && -d "$temp_dir" ]] && rm -rf "$temp_dir"
    set +f
}

# Function to perform cleanup and exit with the specified code
function graceful_exit() {
    local exit_code=$1

    cleanup

    case $exit_code in
    0)
        true
        ;;
    "$ERR_CODE")
        printf "An error occurred.\n"
        ;;
    "$INTERRUPT_CODE")
        printf "Script interrupted.\n"
        ;;
    "$DEP_MISSING_ERR_CODE")
        printf "Error: Dependency missing.\n"
        ;;
    "$OUTPUT_FILE_ERR_CODE")
        printf "Error: Output file error.\n"
        ;;
    "$GIT_REPO_ERR_CODE")
        printf "Error: Git repository error.\n"
        ;;
    "$FILE_ACCESS_ERR_CODE")
        printf "Error: File access error.\n"
        ;;
    "$EMPTY_DIR_ERR_CODE")
        printf "Error: Empty directory error.\n"
        ;;
    "$DIR_CREATION_ERR_CODE")
        printf "Error: Directory creation error.\n"
        ;;
    *)
        printf 'An unknown error occurred.\n'
        ;;
    esac

    exit "$exit_code"
}

# Dependency check function
function check_dependencies() {
    local dependencies=('git' 'file' 'tree')
    local missing_deps=()
    local install_cmd=""

    for dep in "${dependencies[@]}"; do
        command -v "$dep" >/dev/null || missing_deps+=("$dep")
    done

    if [ ${#missing_deps[@]} -ne 0 ]; then
        printf "Installing missing dependencies: %s\n" "${missing_deps[*]}"
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            # Detect Linux Distribution and set package manager
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                case $ID in
                debian | ubuntu) install_cmd=("sudo" "apt-get" "install" "-y") ;;
                fedora | rhel | centos)
                    if [ "${VERSION_ID::1}" -ge 8 ]; then
                        install_cmd=("sudo" "dnf" "install" "-y")
                    else
                        install_cmd=("sudo" "yum" "install" "-y")
                    fi
                    ;;
                arch) install_cmd=("sudo" "pacman" "-S" "--noconfirm") ;;
                opensuse-leap | sles | opensuse-tumbleweed) install_cmd=("sudo" "zypper" "install" "-y") ;;
                alpine) install_cmd=("sudo" "apk" "add") ;;
                *)
                    echo "Unsupported distribution: $ID"
                    exit $DEP_MISSING_ERR_CODE
                    ;;
                esac
            else
                echo "Cannot identify the Linux distribution."
                exit $DEP_MISSING_ERR_CODE
            fi
        elif [[ "$OSTYPE" == "darwin" ]]; then
            # MacOS
            if ! command -v brew >/dev/null; then
                /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            fi
            install_cmd=("brew" "install")
        elif [[ "$OSTYPE" == "linux-microsoft" ]]; then
            # Windows Subsystem for Linux
            install_cmd=("sudo" "apt-get" "install" "-y")
        else
            printf "Unsupported OS type: %s.\n" "$OSTYPE"
            exit $DEP_MISSING_ERR_CODE
        fi
        "${install_cmd[@]}" "${missing_deps[@]}"
    fi
}

# Function to check if the script is run from a git repository
function check_git_repository() {
    [ $verbose -eq 1 ] && printf -- "Checking git repository...\n"
    local git_dir=""

    git_dir=$(git rev-parse --git-dir 2>/dev/null)

    if [[ "$use_gitignore" -eq 1 && -z "$git_dir" ]]; then
        printf -- "This script should be run from a git repository when using --gitignore.\n"
        exit $GIT_REPO_ERR_CODE
    fi
}

# Convert glob patterns to regex
function glob_to_regex() {
    local pattern=$1
    local regex=""
    local i=0
    local len=${#pattern}
    local in_brackets=false

    for ((i = 0; i < len; i++)); do
        local c=${pattern:i:1}

        case "$c" in
        '[')
            in_brackets=true
            regex+="["
            ;;
        ']')
            if $in_brackets; then
                in_brackets=false
                regex+="]"
            else
                regex+="\\]"
            fi
            ;;
        '*')
            if $in_brackets; then
                regex+="*"
            else
                # Replace '**/' with '(.*/)?' to properly match any directory recursively
                if [ $i -gt 0 ] && [ "${pattern:i-1:1}" == '*' ] && [ "${pattern:i+1:1}" == '/' ]; then
                    regex+="(.*/)?"
                    (( i+=1 )) # Skip the '/' after '**'
                elif [ $i -eq 0 ] || [ "${pattern:i-1:1}" != '*' ]; then
                    regex+="[^/]*"
                fi
            fi
            ;;
        '?')
            if $in_brackets; then
                regex+="?"
            else
                regex+="."
            fi
            ;;
        '.')
            regex+="\\."
            ;;
        '/')
            regex+="\\/"
            ;;
        *)
            regex+="$c"
            ;;
        esac
    done

    
    if [[ "$pattern" == */ ]]; then
        # If the pattern ends with '/', match everything inside the directory recursively
        regex="^$regex.*"
    else
        # Ensure the pattern matches the whole string if it's a complete filename
        regex="^$regex$"
    fi

    printf -- "%s" "$regex"
}

# Function to compile the exclude regex
compile_exclusion_regex() {
    exclude_regex=""
    local regex_pattern=""
    for pattern in "${exclude_patterns[@]}"; do
        regex_pattern=$(glob_to_regex "$pattern")
        exclude_regex+="(^|/)$regex_pattern(\$|/)|"
        [ $verbose -eq 1 ] && printf "Compiled regex for pattern '%s': %s\n" "$pattern" "$regex_pattern"
    done
    exclude_regex="${exclude_regex%|}" # Remove trailing '|'
    [ $verbose -eq 1 ] && printf "Final compiled regex: %s\n" "$exclude_regex"
}

# Function to check if a file is text or binary
is_text_file() {
    local file="$1"
    if file -b --mime-type "$file" | grep -q 'text/'; then
        return 0 # It's text
    fi
    return 1 # It's binary or unknown
}

# Argument parsing
parse_args() {
    set -f
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
        -h | --help)
            display_help_message
            exit 0
            ;;
        -v | --verbose)
            quiet=0
            verbose=1
            ;;
        -q | --quiet)
            quiet=1
            verbose=0
            progress=0
            ;;
        -p | --progress)
            quiet=0
            progress=1
            ;;
        -o | --output)
            shift
            if [[ -z "$1" ]]; then
                printf -- "Error: Output file was not specified.\n"
                exit $OUTPUT_FILE_ERR_CODE
            fi
            output_file_name="$1"
            if [[ ! -w "$(dirname "$output_file_name")" ]]; then
                printf -- "Error: Output directory for output file is not writable or does not exist.\n"
                exit $OUTPUT_FILE_ERR_CODE
            fi
            ;;
        -e | --exclude)
            shift
            if [[ -z "$1" ]]; then
                printf -- "Error: Exclude pattern was not specified.\n"
                exit $OUTPUT_FILE_ERR_CODE
            fi
            exclude_patterns+=("$1")
            ;;
        -g | --gitignore)
            use_gitignore=1
            ;;
        -*)
            # Handle multiple flags combined
            local combined_flags="${1#-}"
            for ((i = 0; i < ${#combined_flags}; i++)); do
                case "${combined_flags:i:1}" in
                v) [[ $quiet -eq 0 ]] && verbose=1 ;;
                q)
                    quiet=1
                    verbose=0
                    progress=0
                    ;;
                g) use_gitignore=1 ;;
                p) [[ $quiet -eq 0 ]] && progress=1 ;;
                *)
                    printf "Unknown flag: -%s\n" "${combined_flags:i:1}"
                    exit 0
                    ;;
                esac
            done
            ;;
        *)
            printf "Unknown parameter.\n"
            display_help_message
            exit 0
            ;;
        esac
        shift
    done
    compile_exclusion_regex
    set +f
}

# Function to display the help message
display_help_message() {
    cat <<-EOF
		Usage: $SCRIPT_NAME [options]

		This script processes the files within a Git repository, checking for text files and appending their contents and the project's directory structure to a markdown file.

		Options:
		  -h, --help           Show this help message and exit.
		  -v, --verbose        Enable verbose mode. Prints detailed logs to standard output.
		  -q, --quiet          Disable all output except errors.
		  -p, --progress       Enable progress display, showing a progress bar during execution.
		  -o, --output FILE    Specify the output markdown file where results should be written. Default is 'repo2file.md'.
		  -e, --exclude PATTERN Exclude files or directories that match this pattern. Can be specified multiple times.
		  -g, --gitignore      Apply .gitignore rules for excluding files.

		Examples:
		  ./$SCRIPT_NAME                          # Runs the script in the current directory with default settings.
		  ./$SCRIPT_NAME --output results.md      # Runs the script and outputs to 'results.md'.
		  ./$SCRIPT_NAME -v -p --exclude '*.tmp'  # Runs the script in verbose mode, shows progress, and excludes files matching '*.tmp'.
		  ./$SCRIPT_NAME -g                       # Applies .gitignore rules when processing files.
  ./$SCRIPT_NAME -vg                      # Runs the script in verbose mode and applies .gitignore rules when processing files.
  ./$SCRIPT_NAME -pg                      # Runs the script displaying progress and applies .gitignore rules when processing files.

		EOF
}

# Function to check whether a command is available or not
function is_command_available() {
    command -v "$1" >/dev/null 2>&1
}

# Function to create a dir with mktemp
function create_dir_with_mktemp() {
    local dir_path="$1"
    local dir_base="repo2file_"
    local project=""
    
    project="$(basename "$(pwd)" | sed 's/ /_/g')"
    mktemp -d "${dir_path}${dir_base}-${project}"
}

# Function to create a dir with tempfile for older distributions
function create_dir_with_tempfile() {
    local dir_path="$1"
    local dir_base="repo2file_"
    local project=""
    local temp_dir=""

    project=$(basename "$(pwd)")
    temp_dir=$(tempfile -d "${dir_path}" "${dir_base}" "${project}")
    printf -- "%s" "$temp_dir"
}

# Function to create a dir with mkdir as fallback
function create_unique_dir_fallback_mkdir() {
    local dir_path="$1"
    local dir_base="repo2file_"
    local max_attempts=100
    local attempt=0
    local _temp_dir=""

    while [ "$attempt" -lt "$max_attempts" ]; do
        attempt=$((attempt + 1))
        _temp_dir="${dir_path}/${dir_base}$(date +%s%N)_$$"

        if mkdir "$_temp_dir" 2>/dev/null; then
            printf -- "%s" "$_temp_dir"
            return
        fi
    done

    printf -- "Failed to create a temporary directory after %s attempts." "$max_attempts"
    return $DIR_CREATION_ERR_CODE
}

# Robust function to create unique temporary directories
function create_unique_dir() {
    local dir_path="$1"

    if is_command_available "mktemp"; then
        create_dir_with_mktemp "$dir_path"
    elif is_command_available "tempfile"; then
        create_dir_with_tempfile "$dir_path"
    else
        create_unique_dir_fallback_mkdir "$dir_path"
    fi
}

# Function to replicate the project in a temporary directory
function replicate_in_temp_dir() {
    local file_list=("$@")
    local tmp="${TMPDIR}"

    # Create a temporary directory
    [ $verbose -eq 1 ] && printf "Creating temporary directory\n"
    temp_dir=$(create_unique_dir "$tmp")
    [ $verbose -eq 1 ] && printf "  %s\n" "$temp_dir"

    # Copy the files to the temporary directory
    [ $verbose -eq 1 ] && printf "Copying files:\n"
    for file in "${file_list[@]}"; do
        temp_file_dir="$temp_dir/$(dirname "$file")"
        mkdir -p "$temp_file_dir" || {
            printf "Error creating directory: %s\n" "$temp_file_dir"
            exit $DIR_CREATION_ERR_CODE
        }
        cp -a "$WORKING_DIR/$file" "$temp_file_dir/$(basename "$file")" || {
            printf "Error copying file: %s\n" "$file"
            exit $FILE_ACCESS_ERR_CODE
        }
        [ $verbose -eq 1 ] && printf "  %s\n" "$file"
    done

    [ $verbose -eq 1 ] && printf "Finished replicating project\n"
}

# Function to collect and filter files based on exclude patterns
function collect_files() {
    local files=()
    local cmd="git ls-files -z --cached -o"

    [[ $use_gitignore -eq 1 ]] && cmd+=" --exclude-standard --exclude-from=$(git rev-parse --git-dir)/info/exclude"

    # Collect the files
    while IFS= read -r -d '' file; do
        #if [[ ! "$file" =~ $exclude_regex && "$file" != "$output_file_name" && "$file" != "$SCRIPT_NAME" && "$file" != ".gitignore" && ! -d "$WORKING_DIR/$file" ]]; then
        if [[ ! "$file" =~ $exclude_regex && "$file" != "$output_file_name" && "$file" != "$SCRIPT_NAME" && "$file" != ".gitignore" ]]; then
            files+=("$file")
        fi
    done < <($cmd || true)
    git_exit_code=$?

    # Check if git ls-files command failed
    if [ $git_exit_code -ne 0 ]; then
        printf "Error: git ls-files command failed with exit code %d\n" $git_exit_code
        exit $git_exit_code
    fi

    # Filter the binary files
    local filtered_files=()
    for file in "${files[@]}"; do
        if is_text_file "$file"; then
            filtered_files+=("$file")
        fi
    done
    files=("${filtered_files[@]}")

    printf "%s " "${files[@]}"
}

# Function to append the header to the output file
function append_header() {
    [ $verbose -eq 1 ] && printf -- "Initializing %s\n" "$output_file_name"
    {
        printf -- "# Project Codebase\n"
        printf -- "## Root directory\n \`%s\`\n" "$(pwd)"
        printf -- "---\n"
    } >"$output_file_name"
}

# Function to append the project tree to the output file
function append_directory_structure() {
    [ $verbose -eq 1 ] && printf -- "Appending directory structure to %s\n" "$output_file_name"
    {
        printf -- "## Directory structure:\n"
        printf -- "\`\`\`\n"
        tree "."
        printf -- "\`\`\`\n\n"
        printf -- "---\n"
    } >>"$output_file_name"
}

# Function to append the file contents to the output file
function append_file_content() {
    local relative_file_path=$1
    local full_file_path="$temp_dir/$relative_file_path"

    # Check if the file exists and is readable
    [[ ! -f "$full_file_path" || ! -r "$full_file_path" ]] && printf -- "File %s cannot be read or does not exist.\n" "$full_file_path" && return

    # Append the file content to the output file
    printf "## File: %s\n" "$relative_file_path" >>"$output_file_name"
    if [[ "${relative_file_path##*.}" == "md" ]]; then
        {
            printf -- "See raw %s for markdown file contents\n<!-- [FILE_START]\n" "$output_file_name"
            cat "$full_file_path"
            printf -- "\n[FILE_END] -->\n"
        }  >> "$output_file_name"
    else
        {
            printf -- "\`\`\`\n"
            cat "$full_file_path"
            printf -- "\`\`\`\n\n"
        }  >> "$output_file_name"
    fi
    printf -- "---\n" >>"$output_file_name"
}

# Function to print a progress bar
progress_hash=$(printf '%*s' 200 '' | tr ' ' '#')

function display_progress_bar() {
    local current=$1
    local total=$2
    local cols=0

    # Adapt to the terminal width using tput if available, otherwise fall back to $COLUMNS
    if command -v tput >/dev/null; then
        cols=$(tput cols)
        cols=$((cols - 10))
    else
        cols=$TERM_COLUMNS
    fi
    local percent=$((current * 100 / total))
    local filled=$((cols * current / total))
    printf -- "\r%3d%% [%-${cols}s]" "$percent" "${progress_hash:0:filled}"
}

# Process files in the project directory to be appended to the output file
function process_files() {
    local temp_dir=$1
    shift
    local file_list=("$@")
    local total_files=${#file_list[@]}
    local processed_files=0
    local last_updated=-1

    [ $verbose -eq 1 ] && printf -- "Processing %d files...\n" "${#file_list[@]}"

    for file in "${file_list[@]}"; do
        local relative_file_path="${file#"${WORKING_DIR}/"}"

        [ $verbose -eq 1 ] && printf -- "\n     %s\n" "$relative_file_path"

        append_file_content "$relative_file_path"

        if [ $progress -eq 1 ]; then
            ((processed_files++))
            local new_percent=$((processed_files * 100 / total_files))
            if [ $progress -eq 1 ] && [ "$new_percent" -ne "$last_updated" ]; then
                display_progress_bar "$processed_files" "$total_files"
                last_updated=$new_percent
            fi
        fi
    done

    printf "\n"
}

# Entry point of the script
function main() {
    parse_args "$@"
    check_dependencies
    check_git_repository
    local file_list=($(collect_files))
    [[ ${#file_list[@]} -eq 0 ]] && {
        printf "Error: No files to process.\n"
        exit $EMPTY_DIR_ERR_CODE
    }

    # Print the collected file_list
    [ $verbose -eq 1 ] && printf "Collected file_list:\n"
    for file in "${file_list[@]}"; do
        [ $verbose -eq 1 ] && printf "  %s\n" "$file"
    done

    append_header
    append_directory_structure
    replicate_in_temp_dir "${file_list[@]}"
    process_files "$temp_dir" "${file_list[@]}"
    cleanup
    [[ $quiet -eq 0 ]] && printf -- "Operation completed. Output stored in %s\n\n" "$output_file_name"
}

main "$@"
```

---
