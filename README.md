# Development Containers: Go

## All commits signed with 1Password

- [1Password Commit signing](https://vinialbano.com/how-to-sign-git-commits-with-1password/)

## Code lint, check, validate

```sh
# lint, format and check errors
make check

# build binary
make build
```

## Husky precommit

```sh
npx husky add .husky/pre-commit "golangci-lint run ./ && go test ./. && go mod tidy && go mod verify"
```
