install_minikube:
	echo "Installing Minikube"
	curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
install_kubectl:
	echo "Installing Kubectl"
	sudo apt-get install -y apt-transport-https ca-certificates
	sudo mkdir -p /etc/apt/keyrings
	curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
	sudo chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
	echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
	sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
	sudo apt update
	sudo apt-get install -y kubectl
setup_minikube:
	install_minikube install_kubectl
start_minikube:
	minikube start

minikube_dashboard:
	minikube dashboard

install_helm:
	wget https://get.helm.sh/helm-v3.16.3-linux-amd64.tar.gz
	tar -zxvf helm-v3.16.3-linux-amd64.tar.gz
	sudo mv linux-amd64/helm /usr/local/bin/helm
	sudo rm -rf helm-v3.16.3-linux-amd64.tar.gz

get_spark_charts:
	 helm show values oci://registry-1.docker.io/bitnamicharts/spark > spark-values.yaml

install_chart_helm:
	helm install my-release oci://registry-1.docker.io/bitnamicharts/spark

upgrade_chart_helm:
	helm upgrade my-release oci://registry-1.docker.io/bitnamicharts/spark -f spark-values.yaml

delete_pods:
	kubectl delete pods --all
	helm uninstall my-spark

