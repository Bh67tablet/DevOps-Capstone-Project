# how to
1. add secret keys (Docker, AWS EC2 root/root/host/port)
2. add terraform user, role access key
3. edit terraform.tf file with update access key and secret key
4. run terraform init/apply
5. connect to new ec2 as root
6. git clone this repository
7. run install_kubernetes_docker.sh as root (root user password: root)
8. run github actions workflow: .github/workflows/ContinousIntegration.yml


# this 
HelloWorld Servlet example with corresponding Dockerfile

Use Maven Build first to create war file in Target folder.

mvn clean package

Artifact will be created in target folder.

docker build -t mavenbuild .

Once this is done u will be see image using docker image

Use below command to run the container

docker run -d -p 8080:8080 --name dockercontainer mavenbuild
