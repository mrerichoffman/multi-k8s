docker build -t mrerichoffman/multi-client:latest -t mrerichoffman/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mrerichoffman/multi-server:latest -t mrerichoffman/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mrerichoffman/multi-worker:latest -t mrerichoffman/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mrerichoffman/multi-client:latest
docker push mrerichoffman/multi-server:latest
docker push mrerichoffman/multi-worker:latest

docker push mrerichoffman/multi-client:$SHA
docker push mrerichoffman/multi-server:$SHA
docker push mrerichoffman/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mrerichoffman/multi-server:$SHA
kubectl set image deployments/client-deployment client=mrerichoffman/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mrerichoffman/multi-worker:$SHA