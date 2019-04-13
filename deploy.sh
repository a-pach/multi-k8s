docker build -t apach2019/multi-client:latest -t apach2019/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t apach2019/multi-server:latest -t apach2019/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t apach2019/multi-worker:latest -t apach2019/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push apach2019/multi-client:latest
docker push apach2019/multi-server:latest
docker push apach2019/multi-worker:latest

docker push apach2019/multi-client:$SHA
docker push apach2019/multi-server:$SHA
docker push apach2019/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=apach2019/multi-client:$SHA
kubectl set image deployments/server-deployment server=apach2019/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=apach2019/multi-worker:$SHA