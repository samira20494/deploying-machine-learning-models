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
docker login -u AWS -p eyJwYXlsb2FkIjoiWDRzMEZxcGZ1S3I5Wm83UXV4ajUxQThGT0h4dERMM2dnWEg5RmVWeGN2d0hFVnYxN3FNc2ZCSThCRDd0VnNrTkVnWjlrM3hSelBMNjZHY2hXcTVHM0kwa09xS1NiaVJ1OXZlYWg5cWNCbVZnbjllR0xJejlXc09XM3BZUEZhb1hhSHFHaEkveTdFSS9WRHJoamJSVVN1QlM5cjkwa1IrN1pvZjI3OGtlaFlrWVEzSER1SVpZb2hseUlTWWFaUEM1TVJRd1E4dnJBMlhmTjAwaEJMNUR2eEZsYVZESUpIdG1DbEFJcytKWHU1VHYzamZTczBIbU8ra0s3cDJCNTEwYW0yQi9NR1BvaEp4eWhhL3JpSmJheU5kcnNxdWViV2JSZ0dBa0lHcUJrc2NTdGsydHpuZlBoSGE3dkZxNndzNHgzSVZXaGNTTFM3aUkwQUJtVDM1SldDT3pETXJkS2xzWXlHUlpaam5Kcld5alVJeTJxcjZBSVpRZk5USE9vMG9XTkRFNThVRWg3b01LSnkzRER3elhBbk8rTnhrcnZxWllzR21MWUpaemltaCs0WWg4NndiM25uQUVPcEErTVVEVTBzRGdiWXdJSEFUMi9SVW10TTJmM1FtQXVzdytNNEFFZ0paM0pudXQ1TEJUQ3pWbUVZaVRoenZ2SjZCT1ZkeUxFV21QYVZ1eFd6MHNFUFlVbXJEMDJTZlpZV1U0OHI5QkFRdXFqZmE1K05JUWR1dVdpV01DS0pNYUtRYlZpNitGL0xiVm5XRHZKTUNLUUtIQkV2Tk5yLzNpQlNpQ1JKOUxhYlBUNWxVL2ROcmllLzBKeHVoR1VaUXFkVnFZeFNTTng3YkhreGxaOUkrelMzNzE5bStwWnUzbjlPNkM0TURMa2NoWmh1WXpTNXNReVIxc1R5Zk55ZjdRczc4VFQrQmJkdFZ5TTNIamRaNUlJcVdSejhBbHVuQ1dTWDgzN2srTGhHWFJ4dit3bzdRNFBGQ2gvWGFxZXNsdlpPT3BnYkticWcwL3BOSUtNT1hrQ2ZFQVNSOUZxaFFPcTE0cVhleXlHTzYyb2ZqV0NqLzFXUkVGYUVZdlZPWlRVbVdWUTZzdmpZZERzbmQ0MHcyT3BjZERYbnFsUEViV3NKZ3lzbGV4YjI0NzVrN0RpTVhxbHczVWtGcWgzQnUwaXJsc1lBUmorcnZBUC80OUh1bnFrSDdTalFzSm9uSXd3ODlrb1ZBdzVYRkdncmc5REdKaWZOazRiOE5Yam5MaUtuMGovS2FyRll3UUsxNXJ5cFNoZFpEY1hTVThRNGRCdEI0bjJhaUZMYjRBTTV4azRMekVtaFJ3TS9YTWNZZkRtdlM3aEFPQ3NCVTQ1QTZwWUR3MytRaCtxaWxMaXl4cHpGbmMvaXJMT2lHK3BpcFNUN2xjNkNTNjRCMmRyQU9KaFpZZGdyTXcra0xVL0dTL2lHbW4iLCJkYXRha2V5IjoiQVFFQkFIakI3L2lnd01nNE5Qd2F1cnhTSVl4NEhmbnh1R2MvNDhiRHd2d0RwTllXWmdBQUFINHdmQVlKS29aSWh2Y05BUWNHb0c4d2JRSUJBREJvQmdrcWhraUc5dzBCQndFd0hnWUpZSVpJQVdVREJBRXVNQkVFREFSMVh0b1lzK0EvN3YwakJnSUJFSUE3NGl4d1ZaUXV3WDJ1Y0JJeGVuSlI4RURYMWtpcFpLWDJCeFAzcWhWL0pmKzVjLzk0Yng0eE1xLys0cExCUEc0TGM3bjN2YVhTaVpZaXZSMD0iLCJ2ZXJzaW9uIjoiMiIsInR5cGUiOiJEQVRBX0tFWSIsImV4cGlyYXRpb24iOjE2MTQ0OTAyNTV9 https://464318963404.dkr.ecr.us-east-2.amazonaws.com ker login -u AWS -p eyJwYXlsb2FkIjoiWDRzMEZxcGZ1S3I5Wm83UXV4ajUxQThGT0h4dERMM2dnWEg5RmVWeGN2d0hFVnYxN3FNc2ZCSThCRDd0VnNrTkVnWjlrM3hSelBMNjZHY2hXcTVHM0kwa09xS1NiaVJ1OXZlYWg5cWNCbVZnbjllR0xJejlXc09XM3BZUEZhb1hhSHFHaEkveTdFSS9WRHJoamJSVVN1QlM5cjkwa1IrN1pvZjI3OGtlaFlrWVEzSER1SVpZb2hseUlTWWFaUEM1TVJRd1E4dnJBMlhmTjAwaEJMNUR2eEZsYVZESUpIdG1DbEFJcytKWHU1VHYzamZTczBIbU8ra0s3cDJCNTEwYW0yQi9NR1BvaEp4eWhhL3JpSmJheU5kcnNxdWViV2JSZ0dBa0lHcUJrc2NTdGsydHpuZlBoSGE3dkZxNndzNHgzSVZXaGNTTFM3aUkwQUJtVDM1SldDT3pETXJkS2xzWXlHUlpaam5Kcld5alVJeTJxcjZBSVpRZk5USE9vMG9XTkRFNThVRWg3b01LSnkzRER3elhBbk8rTnhrcnZxWllzR21MWUpaemltaCs0WWg4NndiM25uQUVPcEErTVVEVTBzRGdiWXdJSEFUMi9SVW10TTJmM1FtQXVzdytNNEFFZ0paM0pudXQ1TEJUQ3pWbUVZaVRoenZ2SjZCT1ZkeUxFV21QYVZ1eFd6MHNFUFlVbXJEMDJTZlpZV1U0OHI5QkFRdXFqZmE1K05JUWR1dVdpV01DS0pNYUtRYlZpNitGL0xiVm5XRHZKTUNLUUtIQkV2Tk5yLzNpQlNpQ1JKOUxhYlBUNWxVL2ROcmllLzBKeHVoR1VaUXFkVnFZeFNTTng3YkhreGxaOUkrelMzNzE5bStwWnUzbjlPNkM0TURMa2NoWmh1WXpTNXNReVIxc1R5Zk55ZjdRczc4VFQrQmJkdFZ5TTNIamRaNUlJcVdSejhBbHVuQ1dTWDgzN2srTGhHWFJ4dit3bzdRNFBGQ2gvWGFxZXNsdlpPT3BnYkticWcwL3BOSUtNT1hrQ2ZFQVNSOUZxaFFPcTE0cVhleXlHTzYyb2ZqV0NqLzFXUkVGYUVZdlZPWlRVbVdWUTZzdmpZZERzbmQ0MHcyT3BjZERYbnFsUEViV3NKZ3lzbGV4YjI0NzVrN0RpTVhxbHczVWtGcWgzQnUwaXJsc1lBUmorcnZBUC80OUh1bnFrSDdTalFzSm9uSXd3ODlrb1ZBdzVYRkdncmc5REdKaWZOazRiOE5Yam5MaUtuMGovS2FyRll3UUsxNXJ5cFNoZFpEY1hTVThRNGRCdEI0bjJhaUZMYjRBTTV4azRMekVtaFJ3TS9YTWNZZkRtdlM3aEFPQ3NCVTQ1QTZwWUR3MytRaCtxaWxMaXl4cHpGbmMvaXJMT2lHK3BpcFNUN2xjNkNTNjRCMmRyQU9KaFpZZGdyTXcra0xVL0dTL2lHbW4iLCJkYXRha2V5IjoiQVFFQkFIakI3L2lnd01nNE5Qd2F1cnhTSVl4NEhmbnh1R2MvNDhiRHd2d0RwTllXWmdBQUFINHdmQVlKS29aSWh2Y05BUWNHb0c4d2JRSUJBREJvQmdrcWhraUc5dzBCQndFd0hnWUpZSVpJQVdVREJBRXVNQkVFREFSMVh0b1lzK0EvN3YwakJnSUJFSUE3NGl4d1ZaUXV3WDJ1Y0JJeGVuSlI4RURYMWtpcFpLWDJCeFAzcWhWL0pmKzVjLzk0Yng0eE1xLys0cExCUEc0TGM3bjN2YVhTaVpZaXZSMD0iLCJ2ZXJzaW9uIjoiMiIsInR5cGUiOiJEQVRBX0tFWSIsImV4cGlyYXRpb24iOjE2MTQ0OTAyNTV9 https://464318963404.dkr.ecr.us-east-2.amazonaws.com

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
