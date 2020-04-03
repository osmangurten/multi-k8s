docker build -t osmangurten/multi-client:latest -t osmangurten/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t osmangurten/multi-server:latest -t osmangurten/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t osmangurten/multi-worker:latest -t osmangurten/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push osmangurten/multi-client:latest
docker push osmangurten/multi-server:latest
docker push osmangurten/multi-worker:latest

docker push osmangurten/multi-client:$SHA
docker push osmangurten/multi-server:$SHA
docker push osmangurten/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=osmangurten/multi-client:$SHA
kubectl set image deployments/server-deployment server=osmangurten/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=osmangurten/multi-worker:$SHA