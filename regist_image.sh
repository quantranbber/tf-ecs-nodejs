aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 946548608434.dkr.ecr.ap-southeast-1.amazonaws.com
docker tag nodejs-ecs:latest 946548608434.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-test:latest
docker push 946548608434.dkr.ecr.ap-southeast-1.amazonaws.com/nodejs-test:latest