function _c_npm
end

function ni --description "Install npm packages"
    echo "Installing npm packages..."
    npm install
end

function nif --description "Force install npm packages"
    echo "Force installing npm packages..."
    npm install --force
end

function ncheck --description "npm lint & test"
    echo "Lint & Test npm..."
    npm run lint && npm run test
end

function nformat --description "npm run format"
    echo "npm run format..."
    npm run format
end

function nC --description "npm run lint & test"
    ncheck
end

function ns --description "npm start"
    echo "npm start..."
    npm start
end

function nd --description "npm run dev"
  echo "npm run dev..."
  npm run dev
end

function scripts --description "List npm scripts - searches package.json in git root"
  # Check if in npm project
  goto_git_root
  if not test -f package.json
    echo "Not in an npm project"
    return 1
  end

  if type fx > /dev/null
    fx '.scripts' package.json
  else if type jq > /dev/null
    jq '.scripts' package.json
  else if type fzf > /dev/null
    npm run | fzf
  else if type bat > /dev/null
    bat package.json
  else
    cat package.json
  end
  prevd
  return 0
end
