docker build -t qassimov/multi-client:latest -t qassimov/multi-client:$SHA -f ../client/Dockerfile ../client
docker build -t qassimov/multi-server:latest -t qassimov/multi-server:$SHA -f ../server/Dockerfile ../server
docker build -t qassimov/multi-worker:latest -t qassimov/multi-worker:$SHA -f ../worker/Dockerfile ../worker

docker push qassimov/multi-client:latest
docker push qassimov/multi-client:$SHA

docker push qassimov/multi-server:latest
docker push qassimov/multi-server:$SHA

docker push qassimov/multi-worker:latest
docker push qassimov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=qassimov/multi-server:$SHA
kubectl set image deployments/client-deployment client=qassimov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=qassimov/multi-worker:$SHA
