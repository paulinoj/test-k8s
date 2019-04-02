docker build -t paulinoj/multi-client:latest -t paulinoj/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paulinoj/multi-server:latest -t paulinoj/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paulinoj/multi-worker:latest -t paulinoj/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push paulinoj/multi-client:latest
docker push paulinoj/multi-server:latest
docker push paulinoj/multi-worker:latest

docker push paulinoj/multi-client:$SHA
docker push paulinoj/multi-server:$SHA
docker push paulinoj/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=paulinoj/multi-server:$SHA
kubectl set image deployments/client-deployment client=paulinoj/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=paulinoj/multi-worker:$SHA

