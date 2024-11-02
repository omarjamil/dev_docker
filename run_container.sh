# For building the containr

# export COLIMA_SSH_AUTH_SOCK=$(colima ssh eval 'echo $SSH_AUTH_SOCK')

if [[ "$1" == "build" ]] 
then
  docker build -f dockerfile -t dev-oj --build-arg USERNAME=$USER \
    --build-arg USER_UID=$(id -u) \
    --build-arg USER_GID=$(id -g) --no-cache . 
fi

if [[ "$1" == "run" ]]
then
  open -a XQuartz
  xhost +
  docker run -it -e DISPLAY=host.docker.internal:0 \
    --network=host --entrypoint bash --name dev-x \
    -v /Users/${USER}/Projects:/home/${USER}/Projects \
    -u $USER dev-oj
fi

if [[ "$1" == "run-nox" ]]
then
  docker run -it \
    --network=host --entrypoint bash --name dev \
    -v /Users/${USER}/Projects:/home/${USER}/Projects \
    -u $USER dev-oj
fi


#-v $COLIMA_SSH_AUTH_SOCK:$COLIMA_SSH_AUTH_SOCK -e SSH_AUTH_SOCK \
# -v ${SSH_AUTH_SOCK}:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent \
# -v $SSH_AUTH_SOCK:${SSH_AUTH_SOCK} -e SSH_AUTH_SOCK \
# -v /run/host-services/ssh-auth.sock:/run/host-services/ssh-auth.sock -e SSH_AUTH_SOCK=${SSH_AUTH_SOCK} \

if [[ "$1" == "start" ]]
then
  open -a XQuartz
  xhost +
  docker start -ai dev-x
fi

if [[ "$1" == "start-nox" ]]
then
  docker start -ai dev
fi


if [[ "$1" == "term" ]]
then
  docker exec -ti dev-x bash
fi

if [[ "$1" == "term-nox" ]]
then
  docker exec -ti dev bash
fi


# docker compose -f docker-compose.yml build --no-cache

# Run the container
# docker compose up 
# docker compose -f docker-compose.yml run app
#
# For dropping into a shell
# docker exec -it dev-oj /bin/bash

