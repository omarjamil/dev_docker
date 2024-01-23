# For dropping into a shell
# docker compose -f docker-compose.yml run app
docker compose up &
docker exec -it dev-omar.jamil /bin/bash

# For building the conainer
#docker compose -f docker-compose.yml build
