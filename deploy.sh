docker build -t akhilreddyt/multi-client:latest -t akhilreddyt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t akhilreddyt/multi-server:latest -t akhilreddyt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t akhilreddyt/multi-worker:latest -t akhilreddyt/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push akhilreddyt/multi-client:latest
docker push akhilreddyt/multi-server:latest
docker push akhilreddyt/multi-worker:latest
docker push akhilreddyt/multi-client:$SHA
docker push akhilreddyt/multi-server:$SHA
docker push akhilreddyt/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment server=akhilreddyt/multi-client:$SHA
kubectl set image deployments/server-deployment server=akhilreddyt/multi-server:$SHA
kubectl set image deployments/worker-deployment server=akhilreddyt/multi-worker:$SHA