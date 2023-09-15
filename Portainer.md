docker volume create portainer_data
docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ee:latest

### Default Templates
https://raw.githubusercontent.com/portainer/templates/master/templates-2.0.json

### Pi Hosted
https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/template/portainer-v2-arm64.json
https://raw.githubusercontent.com/novaspirit/pi-hosted/master/template/portainer-v2-amd64.json