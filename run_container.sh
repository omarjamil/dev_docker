# For building the container

export UUID=$(id -u)
export UGID=$(id -g)

if [[ "$1" == "build" ]] 
then
  docker build -f dockerfile_pip -t dev-omar.jamil --build-arg USERNAME=$USER \
    --build-arg USER_UID=$UUID \
    --build-arg USER_GID=$UGID --no-cache . 
fi

if [[ "$1" == "run" ]]
then
  docker run -it --network=host --entrypoint bash --name dev -v /home/${USER}/Projects:/home/${USER}/Projects \
    -v /mnt/dev-data:/mnt/dev-data \
    -v $SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent \
    -u $USER dev-omar.jamil
fi

if [[ "$1" == "start" ]]
then
  docker start -ai dev
fi

if [[ "$1" == "term" ]]
then
  docker exec -ti dev bash
fi

# docker compose -f docker-compose.yml build --no-cache

# Run the container
# docker compose up 
# docker compose -f docker-compose.yml run app
#
# For dropping into a shell
# docker exec -it dev-omar.jamil /bin/bash

