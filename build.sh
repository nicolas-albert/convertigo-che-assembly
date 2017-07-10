#!/bin/bash
#
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#

# See: https://sipb.mit.edu/doc/safe-shell/
set -e
set -u

. ./build.include
init "$@"

MVN_REPO=${HOME}/.m2/repository

sudo mkdir -p ${MVN_REPO}
sudo chown -R $USER ${HOME}/.m2
echo "ls -la"
ls -la
echo "id"
id
docker run -it --rm \
       -v "$MVN_REPO:/home/user/.m2/repository" \
       -v "$PWD":/home/user/che-build           \
       -w /home/user/che-build                  \
	   --user=$(id -u) \
       codenvy/che-dev                          \
       id
echo "ls -la /home/user/"
docker run -it --rm \
       -v "$MVN_REPO:/home/user/.m2/repository" \
       -v "$PWD":/home/user/che-build           \
       -w /home/user/che-build                  \
	   --user=$(id -u) \
       codenvy/che-dev                          \
       ls -la /home/user/
echo "ls -la /home/user/.m2"
docker run -it --rm \
       -v "$MVN_REPO:/home/user/.m2/repository" \
       -v "$PWD":/home/user/che-build           \
       -w /home/user/che-build                  \
	   --user=$(id -u) \
       codenvy/che-dev                          \
       ls -la /home/user/.m2
docker run -it --rm \
       -v "$MVN_REPO:/home/user/.m2/repository" \
       -v "$PWD":/home/user/che-build           \
       -w /home/user/che-build                  \
	   --user=$(id -u) \
       codenvy/che-dev                          \
       mvn clean install
	   
ls -l ${HOME}/.m2
# Run dockerfiles build
./dockerfiles/cli/build.sh
./dockerfiles/init/build.sh
./dockerfiles/server/build.sh

# Push images
docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
docker push convertigo/convertigo-che-cli:nightly
docker push convertigo/convertigo-che-init:nightly
docker push convertigo/convertigo-che-server:nightly
