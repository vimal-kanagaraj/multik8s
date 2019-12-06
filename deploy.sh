docker build -t vimalkanagaraj/multi-client:latest -t vimalkanagaraj/multi-client:$GIT_SHA  -f ./client/Dockerfile ./client
docker build -t vimalkanagaraj/multi-server:latest -t vimalkanagaraj/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t vimalkanagaraj/multi-worker:latest -t vimalkanagaraj/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push vimalkanagaraj/multi=client:latest
docker push vimalkanagaraj/multi-server:latest
docker push vimalkanagaraj/multi-worker:latest

docker push vimalkanagaraj/multi=client:$GIT_SHA
docker push vimalkanagaraj/multi-server:$GIT_SHA
docker push vimalkanagaraj/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image depoyments/server-deployment server=vimalkanagaraj/multi-server:$GIT_SHA
kubectl set image depoyments/client-deployment client=vimalkanagaraj/multi-client:$GIT_SHA
kubectl set image depoyments/worker-deployment worker=vimalkanagaraj/multi-worker:$GIT_SHA

