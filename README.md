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
# build and push Docker image to GitHub registry
make image_build && make image_push GHCR_TOKEN=__classic_token_with_write/read/delete-packages_access__

# inspect image labels on last tagged image
IMAGE_ID=$(docker images | grep -E 'v[0-9]+\.[0-9]+\.[0-9]+' | head -n 1 | awk '{print $3}')
echo -e "\nIMAGE_ID: $IMAGE_ID\n"
docker inspect $IMAGE_ID --format='{{json .Config.Labels}}' | jq
```

## Install precommit hook

```sh
make precommit # runs verify/test/check-build on each commit
```
