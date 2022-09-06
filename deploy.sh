docker build -t bbold72/multi-client:latest -t bbold72/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t bbold72/multi-server:latest -t bbold72/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t bbold72/multi-worker:latest -t bbold72/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push bbold72/multi-client:latest
docker push bbold72/multi-server:latest
docker push bbold72/multi-worker:latest

docker push bbold72/multi-client:$GIT_SHA
docker push bbold72/multi-server:$GIT_SHA
docker push bbold72/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bbold72/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=bbold72/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=bbold72/multi-worker:$GIT_SHA