function _c_shell
end

function cls --description 'Clear the terminal'
    clear
end

function la --description 'List all files'
    ls -al
end

function hosts --description 'Edit hosts file'
    cd ~/../../etc && nvim hosts
end

