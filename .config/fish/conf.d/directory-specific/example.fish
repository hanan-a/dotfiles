# Example directory-specific configuration
# This file demonstrates how to create directory-specific functionality
#
# Usage:
# 1. Copy this file and rename it to something descriptive
# 2. Update the __fish_dir_match_* function to match your target directory
# 3. Add your directory-specific functions, aliases, or variables below
# 4. Optionally define an unload function for cleanup

# Define the matching function
# This function should return 0 (true) if the directory matches, 1 (false) otherwise
# The function name must follow the pattern: __fish_dir_match_<filename>
function __fish_dir_match_example --argument-names dir_path
    # Example: Match if the directory path contains "example-project"
    # You can use various matching strategies:
    # - Exact match: test "$dir_path" = "/path/to/directory"
    # - Contains: string match -q "*example-project*" "$dir_path"
    # - Starts with: string match -q "/path/to/*" "$dir_path"
    # - Ends with: string match -q "*project" "$dir_path"
    # - Regex: string match -rq "pattern" "$dir_path"
    
    # This example matches any directory containing "example-project"
    string match -q "*example-project*" "$dir_path"
end

# Check if this config should be loaded for the current directory
# Only execute the functionality if we're in a matching directory
set -l current_dir (pwd)
if __fish_dir_match_example "$current_dir"
    # ============================================
    # Add your directory-specific functionality below
    # ============================================
    
    # Example: Define a custom function for this directory
    function my_example_function
        echo "This function is only available in example-project directories!"
    end
    
    # Example: Set directory-specific environment variables
    # set -gx PROJECT_ROOT (pwd)
    # set -gx CUSTOM_VAR "value"
    
    # Example: Add directory-specific paths
    # set -gx PATH $PATH (pwd)/bin
    
    # Example: Create aliases
    # alias myalias="some command"
    
    # Example: Source additional files
    # source (pwd)/.env.fish
end

# Optional: Define an unload function for cleanup
# This function is called when leaving the directory
# The function name must follow the pattern: __fish_dir_unload_<filename>
function __fish_dir_unload_example
    # Example cleanup actions:
    # - Remove functions: functions -e my_function
    # - Unset variables: set -e MY_VAR
    # - Remove from PATH: set -gx PATH (string match -v "/custom/path" $PATH)
    
    # This example removes a custom function if it exists
    if functions -q my_example_function
        functions -e my_example_function
    end
end-
