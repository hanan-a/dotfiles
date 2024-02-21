function _c_npm
end

function ni
    echo "Installing npm packages..."
    npm install
end

function nif
    echo "Force installing npm packages..."
    npm install --force
end

function ncheck
    echo "Lint & Test npm..."
    npm run lint && npm run test
end

function ns
    echo "npm start..."
    npm start
end
