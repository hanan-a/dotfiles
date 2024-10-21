function _c_git
end

function g --description "Alias for git"
    git $argv
end

function gf --description "Alias for git fetch" --wraps "git fetch"
    echo "Fetching..."
    git fetch
end

function gs --description "Alias for git status" --wraps "git status"
    echo "Git Status: "
    git status
end

function gp --description "Alias for git pull" --wraps "git pull"
    echo "Pulling..."
    git pull
end

function gdb --description "Delete the provided branch" --wraps "git branch -D"
  git branch -D $argv
end

function gblist --description "FZF List all branches"
    git branch -a | fzf --reverse
end

function gbl --description "List all branches"
    gblist
end

function gP --description "Alias for git push" --wraps "git push"
  echo "Pushing..."
  argparse f/force -- $argv
  set -q _flag_force
  set -l curr_branch (git branch --show-current)
  # If the current branch is main or master, abort the push with a message
  if test curr_branch = "main" -o curr_branch = "master" -a -z $_flag_force
    echo "You are trying to push to the main or master branch. Aborting... Please use a feature branch."
    return 1
  end

  git push
end

function wtlist --description "List all worktrees"
    git worktree list | fzf --reverse
end

function wtclone --description "Clone for worktree"
    # Examples of call:
    # wtclone git@github.com:name/repo.git
    # => Clones to a /repo directory
    #
    # wfclone git@github.com:name/repo.git my-repo
    # => Clones to a /my-repo directory
    set -l url $argv[1]
    # set the base parameter as the basepath of the url
    set -l name (echo $url | sed -e 's/.*\/\([^\/]*\)\.git/\1/')
    echo "Cloning $url into $name"
    mkdir $name
    cd $name

    git clone --bare $url .bare
    echo "gitdir: .bare" > .git

    # Explicitly sets the remote origin fetch so we can fetch remote branches
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

    git fetch origin
end


function goto_bare_root --description "Go to the bare repo root (where the .bare dir is)"
  # Go up the file tree until there is a .bare directory
  if is_bare_repo
    set current_dir (pwd)
    while [ "$current_dir" != "/" ]
      if [ -d "$current_dir/.bare" ]
        cd $current_dir
        # Clean up the variable
        set -e current_dir
        #echo "In bare repo root"
        return 0
      end
      set current_dir (dirname "$current_dir")
    end

    echo "Not a valid bare repo..."
    # Clean up the variable
    set -e current_dir
  return 1
  end
end

function is_bare_repo --description "Returns true if the Git repository is a bare repository"
  set -l output (eval git config --get core.bare)

  if test "$output" = "true"
    #echo "This is a bare repo."
    return 0
  else
    #echo "This is not a bare repo."
    return 1
  end
end

function is_git_repo
  # Go up the file tree until there is a .git directory
  set current_dir (pwd)
  while [ "$current_dir" != "/" ]
    if [ -d "$current_dir/.git" ]
      set -e current_dir
      return 0
    end
    set current_dir (dirname "$current_dir")
  end

  set -e current_dir
  return 1
end

function goto_git_root --description "Move to the Git workspace root directory"
  cd (git rev-parse --show-toplevel)
end

function groot --description "Move to the Git workspace root directory"
  if test is_git_repo
    #echo "Inside a git repo"
    if test is_bare_repo
     #echo "Git bare repo - going to root"
      goto_bare_root
      return $status
    else 
      #echo "Git repo - going to root"
      goto_git_root
      return $status
    end
  end

  echo "Cannot go to Git root since this isn't a Git repo"
  return 1
end

function wtadd --description "Add a worktree" --wraps "git worktree add"
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

  groot

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
    git worktree add --checkout $path $branch
  end

  cd $path
end

function wtremove --description "Remove a worktree" --wraps "git worktree remove"
  # Examples of call:
  # wtremove feat/branch 
  # => Removes the worktree at repo/feat/branch
  set branch $argv[1]
  set path $argv[2]
  if test -z $branch
    echo "Branch name is required"
    return
  end

  groot

  # Find the path for the existing worktree based on the branch name
  if test -z $path
    set path (git worktree list | grep $branch | awk '{print $1}')
  end

  echo "Removing worktree for branch $branch at $path..."
  git worktree remove $path
end

