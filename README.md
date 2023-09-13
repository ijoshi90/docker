# docker
Dockerfile for allinone image

# Create a directory named allinone_image and place required files
mkdir allinone_image

In the directory allinone place the files Dockerfile and start_services.sh

# Docker Build
docker build -t allinone_image .

# Docker Run
docker run --platform linux/amd64 -p 8080:8080 –p 3000:3000 --name allinone_container --entrypoint=/bin/bash -it allinone_image

# Execute the script on first login to start all the services
start_services.sh

# Setup Jenkins
https://localhost:8080
Then follow on-screen instructions

# Setup Grafana
https://localhost:3000
Then follow on-screen instructions

# Docker exec (after building) - If session is closed
docker start allinone_container
docker exec –it allinone_container bash
