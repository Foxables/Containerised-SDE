#!/bin/bash
echo "Running as $GIT_USERNAME<$GIT_USEREMAIL>"

git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_USEREMAIL"

if [ -z "$CONTAINER_NAME" ]
then
    CONTAINER_NAME="wrap"
fi

echo "Loaded, please run `docker exec -it $CONTAINER_NAME /bin/bash`"

while :; do sleep 1; done
