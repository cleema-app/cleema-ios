# Cleema iOS app

[![pipeline status](https://gitlab.kfi.io/cleema/cleema-ios/badges/main/pipeline.svg)](https://gitlab.kfi.io/cleema/cleema-ios/-/commits/main)
[![coverage report](https://gitlab.kfi.io/cleema/cleema-ios/badges/main/coverage.svg)](https://gitlab.kfi.io/cleema/cleema-ios/-/commits/main)

### Setting things up

Run the following commands in your Terminal:
```
bundle install
brew bundle
```

### Automatic SwiftFormat on pre commit
- Install git-format-staged:
```
npm install --save-dev git-format-staged
```
- Install the pre commit hook
```shell
echo "git-format-staged --formatter \"swiftformat stdin --stdinpath '{}'\" '*/*.swift'" > .git/hooks/pre-commit
chmod a+x .git/hooks/pre-commit
```

### Launch arguments for debugging
- set ```wipeUser``` to ```YES``` to remove the currently logged in user
