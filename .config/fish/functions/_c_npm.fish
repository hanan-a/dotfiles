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

function ns --description "npm start"
    echo "npm start..."
    npm start
end

function fscripts --description "FZF npm scripts"
    npm run | fzf
end

function nscripts --description "List npm scripts"
    jq '.scripts' package.json | jq -r 'keys[]'
end

