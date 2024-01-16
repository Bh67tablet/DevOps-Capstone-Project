apt-get update && apt-get install -y curl apt-transport-https
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y containerd.io docker-ce
curl -s https://packages.cloud.google.com/apt/doc/yum-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >/etc/apt/sources.list.d/kubernetes.list
apt-get update
apt -y install kubeadm kubectl kubelet
#
# Execute below set of commands to Initialize Kubernetes Cluster:
#
sed -i 's|disabled_plugin|#disabled_plugin|g' /etc/containerd/config.toml 
service containerd restart
kubeadm init --ignore-preflight-errors=all
# Once Kubernetes Cluster is initialized you can proceed with below commands:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
kubectl get nodes
# We also need to install Helm utility using below set of commands:
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get-helm-3 > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
# Now we have to enable root password and root user authentication to proceed with SSH connectivity from GitHub actions pipeline. 
sed -i 's|PasswordAuthentication no|PasswordAuthentication yes|g' /etc/ssh/sshd_config
sed -i 's|#PermitRootLogin prohibit-password|PermitRootLogin yes|g' /etc/ssh/sshd_config
service sshd restart
# passwd root
sudo usermod --password $(echo root | openssl passwd -1 -stdin) root
