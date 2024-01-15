helm create webapp
ls -al webapp
#By default, you will get a lot of files inside this helm chart but we are going to delete those so that we don’t see error while deploying these.
rm -rf webapp/templates/*.yaml webapp/templates/NOTES.txt webapp/templates/tests webapp/values.yaml
ls -la
cat > webapp/templates/deployment.yaml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ais-ifm
  labels:
    app: ais
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ais
      tier: web
  template:
    metadata:
      labels:
       app: ais
       tier: web
    spec:
      containers:
      - name: ais
        image: bbh67/docker-image
        ports:
        - containerPort: 8090
EOF
cat > webapp/templates/service.yaml << EOF
apiVersion: v1
kind: Service
metadata:
 name: mysvc
spec:
 type: NodePort
 ports:
  - targetPort: 8080
    port: 8080
 selector:
  app: ais
EOF
helm install mydemo webapp
git add .
git commit -m "done helm"
git push origin master
