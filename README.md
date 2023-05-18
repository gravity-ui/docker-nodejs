
# Docker nodejs

Ubuntu based docker image with nginx and nodejs.

## Usage example

Example for nodejs project with nginx and supervisor 

Add to your project `Dockerfile` file with content:

```dockerfile
FROM ghcr.io/gravity-ui/node-nginx:ubuntu20-nodejs18

RUN mkdir -p /opt/app

WORKDIR /opt/app

COPY package.json package-lock.json /opt/app/

RUN npm i -g npm@latest
RUN npm ci

COPY . .
COPY ./deploy/nginx /etc/nginx
COPY ./deploy/supervisor/ /etc/supervisor/conf.d

RUN npm run build && \
    rm -rf deploy tests /tmp/* /root/.npm && \
    chown app /opt/app/dist/run

EXPOSE 80

CMD ["/usr/bin/supervisord"]
```

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
