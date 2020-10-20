aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 440298517750.dkr.ecr.us-west-2.amazonaws.com

docker build -t ml-spacenet6 .

docker tag spacenet6:2-MaksimovKAdocker 440298517750.dkr.ecr.us-west-2.amazonaws.com/ml-spacenet6:2-MaksimovKAdocker
docker tag spacenet6:2-MaksimovKAdocker 440298517750.dkr.ecr.us-west-2.amazonaws.com/ml-spacenet6:latest

docker push 440298517750.dkr.ecr.us-west-2.amazonaws.com/ml-spacenet6:2-MaksimovKAdocker
docker push 440298517750.dkr.ecr.us-west-2.amazonaws.com/ml-spacenet6:latest