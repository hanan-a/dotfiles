function _c_git
end

function g --description "Alias for git"
    git
end

function gp --description "Alias for git pull"
    echo "Pulling..."
    git pull
end

function gP --description "Alias for git push"
    echo "Pushing..."
    git push
end

function wtclone --description "Clone for worktree"
    # Examples of call:
    # wtclone git@github.com:name/repo.git
    # => Clones to a /repo directory
    #
    # wfclone git@github.com:name/repo.git my-repo
    # => Clones to a /my-repo directory
    set url $argv[1]
    # set the base parameter as the basepath of the url
    set name (echo $url | sed -e 's/.*\/\([^\/]*\)\.git/\1/')
    echo "Cloning $url into $name"
    mkdir $name
    cd $name

    git clone --bare $url .bare
    echo "gitdir: .bare" > .git

    # Explicitly sets the remote origin fetch so we can fetch remote branches
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

    git fetch origin
end
