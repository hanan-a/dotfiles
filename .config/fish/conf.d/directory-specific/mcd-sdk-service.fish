# Directory-specific configuration for mcd-sdk-service
# This config is active when inside ~/wrk/mcd-sdk-service/ and its subdirectories

# Define the matching function
function __fish_dir_match_mcd-sdk-service --argument-names dir_path
    # Match if the directory path starts with ~/wrk/mcd-sdk-service/
    # Expand ~ to home directory for comparison
    set -l home_dir ~
    set -l target_dir "$home_dir/wrk/mcd-sdk-service"
    
    # Check if the directory path starts with the target directory
    string match -q "$target_dir/*" "$dir_path"
    or test "$dir_path" = "$target_dir"
end

# Check if this config should be loaded for the current directory
set -l current_dir $PWD
if __fish_dir_match_mcd-sdk-service "$current_dir"
    # Set the alias
    alias sp='npm run prod:stream'
end

# Define unload function for cleanup
function __fish_dir_unload_mcd-sdk-service
    # Remove the alias when leaving the directory
    # In Fish, aliases are functions, so we remove the function
    if functions -q sp
        functions -e sp
    end
end
