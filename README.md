# Deploying Machine Learning Models
For the documentation, visit the course on Udemy.

# resources for Flask:
Flask config docs: http://flask.pocoo.org/docs/1.0/config/
Flask application context docs: http://flask.pocoo.org/docs/1.0/appcontext/
Pytest fixtures: https://docs.pytest.org/en/latest/fixture.html
Pytest conftest files: https://docs.pytest.org/en/2.7.3/plugins.html?highlight=re

Flask testing docs: http://flask.pocoo.org/docs/1.0/testing/
Flask blueprints: http://flask.pocoo.org/docs/1.0/blueprints/

Marshmallow: https://marshmallow.readthedocs.io/en/2.x-line/ (note that we use the 2.x line in our application, not the latest 3.x line).


# resources for circle ci:
Section 8.3 Notes
Commands
In CircleCI set the following environment variables:
KAGGLE_USERNAME
KAGGLE_KEY
Links
Understanding YAML: https://yaml.org/start.html
Circle CI config reference: https://circleci.com/docs/2.0/configuration-reference/
Environment variables in Circle CI: https://circleci.com/docs/2.0/env-vars/
Kaggle CLI: https://github.com/Kaggle/kaggle-api
Creating your Kaggle API Key: https://www.kaggle.com/docs/api


# test deployment manually:
Commands
Make sure curl is installed (see below). Cd to the course repo scripts directory and
then run:

curl --header "Content-Type: application/json" --request POST --data @input_test.json https://deploy-ml-model-udemy.herokuapp.com/v1/predict/regression

Links
Download curl: https://curl.haxx.se/download.html
curl documentation: https://curl.haxx.se/docs/

# docker
Commands:
Docker Build (make sure you have set your PIP_EXTRA_INDEX_URL environment
variable):

Windows:
docker build --build-arg PIP_EXTRA_INDEX_URL=%PIP_EXTRA_INDEX_URL% -t deploy-ml-model-udemy:latest .

OS X / Linux:
1- docker build --build-arg PIP_EXTRA_INDEX_URL=${PIP_EXTRA_INDEX_URL} -t ml_api:latest .

View built images:
2- docker images

Run the docker image:
3- docker run --name ml_api -d -p 8000:5000 --rm ml_api:latest

View running containers:
docker ps

View container logs (get the container ID by running docker ps):
docker logs CONTAINER_ID --tail

Links
Docker build reference:
https://docs.docker.com/engine/reference/commandline/build/
Docker run reference:
https://docs.docker.com/engine/reference/run/
Docker logs reference:
https://docs.docker.com/engine/reference/commandline/container_logs/
