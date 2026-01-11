# Function to load directory-specific configurations
# This function checks the current directory and loads/unloads configurations accordingly

function _load_directory_specific
    # Get the current working directory
    # When triggered by --on-variable PWD, $PWD is already set to the new directory
    set -l current_dir $PWD
    
    # Initialize the tracked directory if not set
    if not set -q __fish_last_directory
        set -g __fish_last_directory ""
        set -g __fish_loaded_directory_config ""
    end
    
    # Check if directory has changed (this check is still useful for initial load)
    if test "$current_dir" != "$__fish_last_directory"
        # Unload previous directory-specific config if it exists
        if test -n "$__fish_loaded_directory_config"
            # Call the unload function if it exists
            set -l basename (basename "$__fish_loaded_directory_config" .fish)
            set -l unload_func_name "__fish_dir_unload_$basename"
            if functions -q "$unload_func_name"
                eval "$unload_func_name"
            end
            set -g __fish_loaded_directory_config ""
        end
        
        # Look for matching directory-specific configs
        set -l config_dir "$__fish_config_dir/conf.d/directory-specific"
        
        if test -d "$config_dir"
            # Check each config file
            for config_file in $config_dir/*.fish
                if test -f "$config_file"
                    set -l basename (basename "$config_file" .fish)
                    set -l match_func_name "__fish_dir_match_$basename"
                    
                    # Source the file - it will define the matching function
                    # The file should wrap its functionality in a conditional check
                    # Wrap in error handling to prevent one bad file from breaking everything
                    if source "$config_file" 2>/dev/null
                        # Check if the matching function exists and if it matches
                        if functions -q "$match_func_name"
                            if eval "$match_func_name" "$current_dir" 2>/dev/null
                                # This config matches, mark it as loaded
                                set -g __fish_loaded_directory_config "$config_file"
                                break
                            end
                        end
                    end
                end
            end
        end
        
        # Update the tracked directory
        set -g __fish_last_directory "$current_dir"
    end
end
