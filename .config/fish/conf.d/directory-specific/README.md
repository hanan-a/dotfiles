# Directory-Specific Configurations

This directory contains Fish shell configurations that are automatically loaded when you enter specific directories.

## How It Works

1. The system monitors your current working directory
2. When you change directories, it checks all `.fish` files in this directory
3. Each file defines a matching function that determines if it should be loaded
4. If a match is found, the file is sourced and its functionality becomes available
5. When you leave the directory, an optional unload function is called for cleanup

## Creating a New Directory-Specific Config

1. Copy `example.fish` to a new file with a descriptive name (e.g., `myproject.fish`)
2. Update the matching function:
   - Rename `__fish_dir_match_example` to `__fish_dir_match_<yourfilename>`
   - Update the logic to match your target directory
3. Optionally update the unload function:
   - Rename `__fish_dir_unload_example` to `__fish_dir_unload_<yourfilename>`
   - Add cleanup logic if needed
4. Add your directory-specific functionality (functions, aliases, variables, etc.)

## Matching Strategies

You can use various matching strategies in your `__fish_dir_match_*` function:

- **Exact match**: `test "$dir_path" = "/exact/path"`
- **Contains**: `string match -q "*keyword*" "$dir_path"`
- **Starts with**: `string match -q "/path/to/*" "$dir_path"`
- **Ends with**: `string match -q "*project" "$dir_path"`
- **Regex**: `string match -rq "pattern" "$dir_path"`
- **Multiple conditions**: Combine with `and`/`or`

## Example Use Cases

- Load project-specific environment variables
- Set up project-specific aliases
- Activate virtual environments automatically
- Load project-specific functions
- Configure tools for specific projects
