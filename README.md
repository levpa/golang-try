# Development Containers: Go

## All commits signed with 1Password

- [1Password Commit signing for Dev Containers on Windows](https://vinialbano.com/how-to-sign-git-commits-with-1password/)

## DevContainers development

Ctrl + Shift + P in VS Code: 

Dev Containers:
- reopen in container
- rebuild container 
- rebuild container without cache

## Code lint, check, validate

```sh
# Precommit checks: linting, format, dependencies/static check, e.t.c.
make verify && make test && make check-build
```

## Docker builds, labels, checks

```sh
# build and push Docker image to GitHub registry
make image_build && make image_push GHCR_TOKEN=<your_token> # classic token with write/read/delete packages access

# inspect image labels on last tagged image
IMAGE_ID=$(docker images | grep -E 'v[0-9]+\.[0-9]+\.[0-9]+' | head -n 1 | awk '{print $3}')
echo -e "\nIMAGE_ID: $IMAGE_ID\n"
docker inspect $IMAGE_ID --format='{{json .Config.Labels}}' | jq

# --- Example output ---
IMAGE_ID: 8e1c2af39ada

{
  "org.opencontainers.image.created": "2025-09-30T16:44:06Z",
  "org.opencontainers.image.description": "minimalistic GoLang image for backend development",
  "org.opencontainers.image.licenses": "MIT",
  "org.opencontainers.image.revision": "2b102ce",
  "org.opencontainers.image.source": "https://github.com/levpa/golang-try",
  "org.opencontainers.image.version": "v0.0.6"
}
```

## Install precommit hook (initial setup)

```sh
make precommit # runs verify/test/check-build on each commit
```
