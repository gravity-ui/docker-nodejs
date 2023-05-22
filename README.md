
# Docker nodejs

Ubuntu based docker image with nginx and nodejs.

## Usage example

See example docker files in [examples folder](./examples).

## Push image to container registry

Images now are saved in [Github container registry](https://github.com/orgs/gravity-ui/packages/container/package/node-nginx).

To push new image to registry you need to do:

0. Install docker

1. Switch on main branch

`git checkout main`

2. Login

- Create [Personal Access Token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) with permissions `read:packages` and `write:packages`

- Save token to env variable:

```bash
export CR_PAT=<TOKEN>
```

- Login in registry:

```bash
echo $CR_PAT | docker login ghcr.io -u gravity-ui --password-stdin
```

3. Build new image

`docker build . --tag gravity-ui/node-nginx:latest`

4. Tag image

`docker image tag gravity-ui/node-nginx ghcr.io/gravity-ui/node-nginx:ubuntu20-nodejs18`

5. Push image

`docker image push ghcr.io/gravity-ui/node-nginx:ubuntu20-nodejs18`
