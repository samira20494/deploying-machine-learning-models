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
docker login -u AWS -p eyJwYXlsb2FkIjoiUzdiL241QlhEcmpIeUJjSFhYWW5JeTNNc25JOFFRcGVYMDFBK3lHemw3bTNNUFJIVWVMZ2w5cDFURDhvUERYWU54ODJxVEJzdVdTUDByTVc2b1c3dmw2ejAwS3VkY01iL3VucVlBS0lzdVFoNmJwVEczWDhKNmlZQkEvN3FjeFl1V0YzUS9zaEN5NDZqOUZTWlhZNGNoNU1MOCtHdW1BZzNGMFVOZzFkYlcyYVB1d2FDcU5CYmVuTmwwVTY1K2dxZW5DcjdBNTBrdDVGTGZYY1o1RnZYK1hUb25jalVzb2VoQ0JQUjFmK1RYL05GdUlNeXRzd0NzWEJ2eENtN2U4Q2I5dEgzVTljOGlEcTdUZFJHOFB3czBTRDZidCtueGxxajVUK0ZRa05zWHVRMmtQSXZHQlZwenB1RDI1eTN1UWN1aVlhRGFOTDlkNUZvVytWVmFVTi9mUlNSK0RzQWhpRVNVL08zS004ZUt0VjFSMnFTQzZYOXo0Q1ZsZ3VmSDBiZnlHd2VNbUlPc0tFODU3VDV3cDZUTUIrZ0NPblkzTExlejRTY1F6MytBankrVDlha2lUWUtUaksvVFpZTitvM3oyZG5QU3JNVFRBTW9rcS9yRzZYYnJUNTdPNVgzVTdPd0RveXJIcGdRcHNEdU1iM2t1VnZoaDlIUG5qRXROaXBvT1ZJNXljU3NBMXZ1bTZzT1NoY2RQS1JsZDhSNWZJMnFIM0swajBIQUdGUkt1OEJCODhjbnM3SEhra0NIeXVjTUJwYUdKejZqbU5FVTRLY2lOb0l1a0VnZXBObWExSjNXdnc0eGNxb2hPS2htV0E4bU5LVm1VYmlRWHdlRHNNZVVqazVXbitpV2hZUUloZjF2M2E0azRuV0JQS2RtTmVPRUIwMy8wUjFtNlVVOWF1a2FNcEpNNVV5OVgvT2h5bkt3SVowcmZCYzRlTzRBU0xUMUhTeEpUK2gzeVd6Z25JMndyQThLL3NGdmtSR3J1N0NqSDNRSzNTdVNTRFRHTXdlV2g1SndHV1RqbnIzbm01TEdjK3hnSHVqUHlRQXJ4U1BPNXB1M0kyQWtIRnJPeDNWY1lQTytkUXZMcHRsMWJVZDQxUHFXTHJIUXh1YlpHRXMrSDRzaUZHNms1blJ3UW5ZK2I4b1FpNXZpbFNsRlhwMHVESjdaMlZkSG9jblFDRjdHWHlFVnBtSS9oOGJSczJ0YmtCeDFzNlhUbUNwOWptdnFLVmlQbk51cTZJQTc1U2M5V0I3RGdYZ2g0VlJSbjRnNTQva25zY3JxWTZrekwzSHRycDZXMVdvTlkvQjF4aGR0V3o2YzBSejRtdVNXRnZ1REFTTVRNcit0cmR6MVFRbnZGUnUyK2JzdmFRZitOL2lLVjR5M2U5SjdvMkowL3AvRXVYSGVBamJhZEY1SkpmL01Qc2NqL2xyMzk4VGkySXdJUnk5SDhMelprN0IiLCJkYXRha2V5IjoiQVFFQkFIakI3L2lnd01nNE5Qd2F1cnhTSVl4NEhmbnh1R2MvNDhiRHd2d0RwTllXWmdBQUFINHdmQVlKS29aSWh2Y05BUWNHb0c4d2JRSUJBREJvQmdrcWhraUc5dzBCQndFd0hnWUpZSVpJQVdVREJBRXVNQkVFREVLSjZhT0VRNXk1eDZMRDZnSUJFSUE3RWVnZExVVUk3RzVFYlUxSUQxR05SOGlIckk2czB4L2IrejA0WDkrMXFrb3ZlUkZOTTFDR2lid0tPZUdPVmp1MXRxTG5ZRzBpYm40YzRrcz0iLCJ2ZXJzaW9uIjoiMiIsInR5cGUiOiJEQVRBX0tFWSIsImV4cGlyYXRpb24iOjE2MTQ1OTQwNDR9 https://464318963404.dkr.ecr.us-east-2.amazonaws.com

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