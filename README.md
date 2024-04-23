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

```curl -sSL https://raw.githubusercontent.com/jsugg/repo2file/main/install.sh | bash -s```

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