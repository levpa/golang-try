# Development Containers: Go

## All commits signed with 1Password

- [1Password Commit signing](https://vinialbano.com/how-to-sign-git-commits-with-1password/)

## Code lint, check, validate

```sh
# code format, check and linting
golangci-lint run --verbose

# checks and verify modules
go mod tidy && go mod verify

# run unit tests
go test ./
```

## Husky precommit

```sh
npx husky add .husky/pre-commit "golangci-lint run ./ && go test ./. && go mod tidy && go mod verify"
```
