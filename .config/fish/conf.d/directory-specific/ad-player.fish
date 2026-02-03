# Directory-specific configuration for ad-player
# This config is active when inside ~/wrk/ad-player/ and its subdirectories

# Define the matching function
function __fish_dir_match_ad-player --argument-names dir_path
    # Match if the directory path starts with ~/wrk/ad-player/
    # Expand ~ to home directory for comparison
    set -l home_dir ~
    set -l target_dir "$home_dir/wrk/ad-player"
    
    # Check if the directory path starts with the target directory
    string match -q "$target_dir/*" "$dir_path"
    or test "$dir_path" = "$target_dir"
end

# Check if this config should be loaded for the current directory
set -l current_dir $PWD
if test -n "$PWD"; and __fish_dir_match_ad-player "$current_dir"
    # Create aliases for https and ssl
    alias https='npm run start:https'
    alias ssl='npm run start:ssl'
    
    # Function that runs ssl, waits for it to be ready on port 443, stops it, then runs https
    function sslhttps
        echo "Starting SSL server..."
        
        # Start the SSL server in the background
        npm run start:ssl &
        set -l ssl_pid $last_pid
        
        # Wait for the server to be listening on port 443
        set -l max_wait 30
        set -l waited 0
        set -l server_ready false
        
        echo "Waiting for SSL server to start on port 443..."
        
        while test $waited -lt $max_wait
            sleep 1
            set waited (math $waited + 1)
            
            # Check if process is still running
            if not kill -0 $ssl_pid 2>/dev/null
                echo "Error: SSL server process ended unexpectedly"
                return 1
            end
            
            # Check if server is listening on port 443
            if command -v lsof >/dev/null
                if lsof -Pi :443 -sTCP:LISTEN >/dev/null 2>&1
                    set server_ready true
                    echo "SSL server is ready (listening on port 443)"
                    break
                end
            else if command -v netstat >/dev/null
                if netstat -an 2>/dev/null | grep -q "LISTEN.*:443"
                    set server_ready true
                    echo "SSL server is ready (listening on port 443)"
                    break
                end
            else
                # Fallback: wait a reasonable amount of time
                if test $waited -ge 5
                    echo "Assuming SSL server is ready (waited $waited seconds)"
                    set server_ready true
                    break
                end
            end
        end
        
        if test "$server_ready" = "false"
            echo "Error: Timeout waiting for SSL server to start on port 443 (waited $max_wait seconds)"
            kill $ssl_pid 2>/dev/null
            return 1
        end
        
        echo "Stopping SSL server..."
        # Try graceful shutdown first (SIGTERM)
        kill $ssl_pid 2>/dev/null
        sleep 2
        
        # Force kill if still running
        if kill -0 $ssl_pid 2>/dev/null
            echo "Force stopping SSL server..."
            kill -9 $ssl_pid 2>/dev/null
        end
        
        wait $ssl_pid 2>/dev/null
        
        # Give it a moment to fully stop
        sleep 1
        
        echo "Starting HTTPS server..."
        npm run start:https
    end
end

# Define unload function for cleanup
function __fish_dir_unload_ad-player
    # Remove the aliases and function when leaving the directory
    # In Fish, aliases are functions, so we remove the functions
    if functions -q https
        functions -e https
    end
    if functions -q ssl
        functions -e ssl
    end
    if functions -q sslhttps
        functions -e sslhttps
    end
end
