# Development Containers: Go

## DevContainers development

Ctrl + Shift + P in VS Code: 

Dev Containers:
- reopen in container
- rebuild container 
- rebuild container without cache

```sh
# Devcontainer config(docker image, VS Code features and extensions): 
./devcontainer/devcontainer.json

# Run devcontainer (WSL2), creates dev environment in container
Ctrl + Shift + P: Dev Containers: Open Container/Rebuild Container.

# files binding from WSL host(.ssh keys, creds, aliases should be configured):
.ssh/
├── allowed_signers
├── azure_rsa
├── config
├── github_ed25519
├── id_ed25519.pub
└── known_hosts
.gitconfig
```

## Main dev commands

```sh
# golang build with version, SHA and date: 'main' artifact in the root 
make build

# docker image build with Dockerfile
make image_build

# Commit add and signing with SSH keys:
# Precommit hook runs on each commit action as precommit hook: ./scripts/install-precommit-hook.sh
git sm "new signed commit"

git push

## bump version and push tags to remote (default -> patch version)

# !! runs build -> push pipeline to ghcr
# !! runs release pipeline to make release on github
make release # make release <patch/minor/major>
```

## Docker image labels debug:

```sh

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
some...