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
1- docker build --build-arg PIP_EXTRA_INDEX_URL=${PIP_EXTRA_INDEX_URL} -t ml-api-udemy:latest .

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


# Section 12.9 Notes - Upload to AWS ECR
Commands
- cd into the cloned course repo root directory then
- Ensure PIP_EXTRA_INDEX_URL is set (Gemfury URL)
- Ensure AWS_ACCOUNT_ID is set (can be found in the AWS ECR URL)

1)Build image locally (OS X / Linux):
docker build --build-arg PIP_EXTRA_INDEX_URL=${PIP_EXTRA_INDEX_URL} -t ml-api-udemy:latest .

2)Tag local docker image (OS X / Linux)
docker tag ml-api-udemy:latest ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-2.amazonaws.com/ml-api-udemy:latest

3)View Images and Tags:
docker images

4)Login to ECR:
aws ecr get-login-password  --region us-east-2

5)Copy and paste the result of this command into the below command :
docker login -u AWS -p eyJwYXlsb2FkIjoiZDZqTFhQOUdUVmVxUDJvTVI3cmN2ZmkzaEVic24vbC84bm9yN0V2MmtRdUtBTnIyN0xyT3JDOVlSWWxVVmhJbDlrQXEra21qUGt0bTdnY1VFUWdFK3FybVJnNStQRW0ya0srNnFabk9sV2ZUVEg3UHREMit5MEJGY3h3MzROMHA2VHQvU1YrRTRvMTByOFNxbkZ1UG1SNGhsNmpUWXA2RWdIbllNY2xYSXFZblNqbGFaUnFYQXM5KzhYRXRpY1lsM1JIT3hSdFNUK3AxaVU4RmdkSDdETzF0dGVxK2NnVE8zTld2VC9uOWRBbVQrZndFZGVnZWdQWFVzOE1qdXg1NWQ0ZkRVUjdkLzJvVE1LeTN6VUF4UUdUSVZqQ0NuR3AyczhxV2Q3YlIwYmFlWURtQjNmSjU2UkluYnFadlRRNmJNakd0MEJSZVlMSEZsZ0FCZEZlZGxJYUJtK0NuUnZPMHB0bVNSMFRLSnM4ZDlCODlqcmhlMHFrRlR5Z1VTSURZN0dNbVI5ODhKRExuK1hSNnIydFo0eGY5ZzFjK2lXRXhLSThVNisvUkZUM2hnTGU5VGdhcE83a3A2UmNQODkzYmNKNnp6YjVKeDA5VUhHUnVPUmJ4S2I1QU9KaTcwMmFwWW1CUVR4bWlNeGV2ay9EdWkya2VvTGlUU2hiYWpxM3diOW9FdmhnU1pweE1tajNxN2I4aWtmSEFEUnRPbkhKdGxLZmptelYzSWYvK3owRkV5ZGttWDNpSjJ4YW5lUDdhU0hFRUR4bkVDaVVLZHp0R2ZHMmZJY1MxYWN2THBGRXR3NFdteUVTTjNWYnpOaUdvMmVSTkxRWE9Pa1ppdkl5cGNsb3NqYlZPZ08yTVJwOTkveWVsTnl5cWQ3aUdGZklkRUIvMUVhczQwamFxR1NEU2prWWxERGpzT3R6WFlBQUptRjFxM3JSVk9iR3ZaMytUNThkR0RTU0ZSbG1KcUUwL3NkTzJUT1dGd1pldXU5RVZnaGlKUzJ2dllqMTB2WkpVbHVCNFlpOFZIbjVVRW9EUWJqckFIc3dBODIrZ2E0OW94RFZJZmNYdk84V09KR2RMOXFOak5LUHdxUTYrelFLaWJwZStPQmE1OUlFRFNCS2RTK3h2N3lLbkh2OHUwUEdXU3NsRVNzc1R2czNVUmZFV24rN21JMHdxZ0Q3WVYxdHYwUHhOeUN6Zk9HbytTMXhqZS9RK2JtdThGNnkwWExoZmhjTnpCd2pqaTNkSjAxTFpyUmVTL2xHU1d6WWVpWFNtVEtrK1UxV3lISGZYajFiamJEQmhTRGFQN3pYTUU0eTdkQmEvUHI0Zjd2Q1pndUkwdUNpNnFZZkhXMU9RUGZoWUZQM3JGZUFEQmMzWllKZ0JnMXJMbmQ0ZW9CSXFrM3FVSjhJQjNsbGFCaWdoOHNDM0l6WVVhMWhuSi8zNEdhRDRMK2NwQWFnYUNhUmwiLCJkYXRha2V5IjoiQVFFQkFIakI3L2lnd01nNE5Qd2F1cnhTSVl4NEhmbnh1R2MvNDhiRHd2d0RwTllXWmdBQUFINHdmQVlKS29aSWh2Y05BUWNHb0c4d2JRSUJBREJvQmdrcWhraUc5dzBCQndFd0hnWUpZSVpJQVdVREJBRXVNQkVFREJia1p0Sm5WMFVUSTF1UEJRSUJFSUE3dmtEbzF2NzlnbzJxS2RUZXBFSGRnMTF5RTFtY2lhOEgwVUUyMHEwR1BUYkdNN2V4azdoVmU5cUVsOXFES1VDMEFBcjh4QUVTU1N5ZGc0Zz0iLCJ2ZXJzaW9uIjoiMiIsInR5cGUiOiJEQVRBX0tFWSIsImV4cGlyYXRpb24iOjE2MTQ1OTU1MzB9 https://464318963404.dkr.ecr.us-east-2.amazonaws.com

you should see “login succeeded”

6) Push docker image to ECR (Windows)
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.us-east-2.amazonaws.com/ml-api-udemy:latest

7) to make sure it's pushed, check the registry for the application:
https://us-east-2.console.aws.amazon.com/ecr/repositories/private/464318963404/ml-api-udemy?region=us-east-2
   

Links
AWS ECR User Guide:
https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html
Create ECR entry with CLI:
https://docs.aws.amazon.com/cli/latest/reference/ecr/create-repository.html
More CLI commands:
https://docs.aws.amazon.com/AmazonECR/latest/userguide/ECR_AWSCLI.html#A
WSCLI_push_image


Update ECS Service:
aws ecs update-service --cluster ml-api-cluster --service custom-service --task-definition first-run-task-definition --force-new-deployment