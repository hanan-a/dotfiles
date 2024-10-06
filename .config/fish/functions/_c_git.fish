function _c_git
end

function g --description "Alias for git"
    git $argv
end

function gf --description "Alias for git fetch"
    echo "Fetching..."
    git fetch
end

function gs --description "Alias for git status"
    echo "Git Status: "
    git status
end

function gp --description "Alias for git pull"
    echo "Pulling..."
    git pull
end

function gP --description "Alias for git push"
    echo "Pushing..."
    # If the current branch is main or master, abort the push with a message
    if test (git branch --show-current) = "main" -o (git branch --show-current) = "master"
        echo "You are trying to push to the main or master branch. Aborting... Please use a feature branch."
        return
    end

    git push
end

function wlist --description "List all worktrees"
    git worktree list | fzf --reverse
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

function __go_to_workspace_root --description "Move to the Git workspace root directory"
  cd (git rev-parse --show-toplevel)
end

function wtadd --description "Add a worktree"
  # Examples of call:
  # wtadd feat/branch 
  # => Adds a worktree to the repo/feat/branch  directory
  # If the branch is not found, it will be created
  set branch $argv[1]
  set path $argv[2]
  if test -z $branch
    echo "Branch name is required"
    return
  end

  __go_to_workspace_root

  if test -z $path
    echo "Path is set as branch name"
    set path ./$branch
  end

  echo "Adding worktree at $path..."

  # Check if branch exists
  if test -z (git branch --list $branch)
    echo "Creating worktree for new branch $branch at $path..."
    git worktree add -b $branch $path
  else
    echo "Creating worktree for existing branch $branch at $path..."
    git worktree add $path $branch
  end

  cd $path
end

function wtremove --description "Remove a worktree"
    # Examples of call:
    # wtremove feat/branch 
    # => Removes the worktree at repo/feat/branch
    set branch $argv[1]
    set path $argv[2]
    if test -z $branch
        echo "Branch name is required"
        return
    end

    # Find the path for the existing worktree based on the branch name
    if test -z $path
        set path (git worktree list | grep $branch | awk '{print $1}')
    end

    echo "Removing worktree for branch $branch at $path..."
    git worktree remove $path
end

function gblist --description "FZF List all branches"
    git branch -a | fzf --reverse
end
