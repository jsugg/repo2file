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

---

## Output markdown file format example

---

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
