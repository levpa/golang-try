# Development Containers: Go

## All commits signed with 1Password

- [1Password Commit signing](https://vinialbano.com/how-to-sign-git-commits-with-1password/)

## DevContainers development

Ctrl + Shift + P: Dev Containers

- reopen in container
- rebuild container 
- rebuild container without cache


## Code lint, check, validate

```sh
# lint, format and check errors
make verify && make test && make check-build
```

## Docker

```sh
# build Docker image
make image

# inspect image labels
docker inspect <IMAGE_ID> --format='{{json .Config.Labels}}' | jq
```

## Install precommit hook

```sh
make precommit # runs verify/test/check-build on each commit
```
