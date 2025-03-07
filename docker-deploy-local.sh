IMAGE_NAME="vue-ui-project"
CONTAINER_NAME="vue-ui-project-container"

# Step 1, remove the previously build package-lock.json and node_modules
# so that they are created before docker build process.
rm package-lock.json
rm -rf node_modules

# Step 2, reinstall the dependencies.
npm install --include=optional --verbose

# Step 3, build the docker conatiner.
docker build -t ${IMAGE_NAME} .

# Step 4, check if container exists. If so, stop and remove it.
# Check if the container exists
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Container ${CONTAINER_NAME} exists."

    # Check if the container is running
    if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
        echo "Stopping container ${CONTAINER_NAME}..."
        docker stop ${CONTAINER_NAME}
    fi

    echo "Removing container ${CONTAINER_NAME}..."
    docker rm ${CONTAINER_NAME}
else
    echo "Container ${CONTAINER_NAME} does not exist."
fi

# Step 5, run new container. (Volume mount from working dir to /app in container)
docker run -p 5173:5173 -v $(pwd):/app -d --name ${CONTAINER_NAME} ${IMAGE_NAME}