#!/bin/bash

# 0. init git repository
git init

# 1. install node
brew install node

# 2. add conventional commit folders to .gitignore
echo "
## conventional commit related files
node_modules/ 
.husky/
commitlint.config.js
package-lock.json
package.json
">> .gitignore

# 3. install commitlint
npm install @commitlint/{cli,config-conventional} --save-dev

# 4. export commitlint/config-conventional
echo "                  
module.exports = {                               
    extends: ['@commitlint/config-conventional'],
};                       
" >> commitlint.config.js

# 5. install husky
npm install husky --save-dev

# 6. enable husky git hooks
npx husky install

# 7. make git commit can use git cz hook
npx husky add .husky/prepare-commit-msg "exec < /dev/tty && git cz --hook || true"

# 8. add commitlint in husky with commit-msg
npx husky add .husky/commit-msg 'npx --no-install commitlint --edit'
echo "$(cat .husky/commit-msg) \"\$1\"" > .husky/commit-msg

# 9. install commitizen
npm install commitizen --save-dev

# 10. install commitizen
commitizen init cz-conventional-changelog --save-dev --save-exact
