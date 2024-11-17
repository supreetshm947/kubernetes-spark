# 🚀 Kubernetes Spark Cluster with Helm

This project sets up a scalable Apache Spark cluster on Kubernetes using Helm. It includes configurations for Minikube and Kubernetes, as well as running Spark jobs.

---

## 🛠️ Setup Instructions

### 🔧 Install Minikube and Kubectl

Use the provided Makefile to install Minikube and Kubectl:

```bash
make install_minikube
make install_kubectl
```

### 🚦 Start Minikube

Start your Minikube cluster:

```bash
make start_minikube
```

You can also access the Minikube dashboard to monitor resources:

```bash
make minikube_dashboard
```

### 🛠️ Install Helm

Install Helm using the Makefile:

```bash
make install_helm
```

## 🔥 Deploy Spark Cluster

### 1. 🚀 Install Spark Helm Chart

Install the Spark Helm chart:

```bash
make install_chart_helm
```

### 2. ⚙️ Customize Spark Configurations

To customize the Spark cluster configuration, pass custom-values.yaml during the Helm install or upgrade (I created a NodePort service to expose the spark service outise the k8 cluster):

```bash
make upgrade_chart_helm
```

## 🧪 Testing the Spark Cluster

### 1. 🖥️ Access the Spark UI
- Use kubectl to port-forward the Spark master service to your local machine:

```bash
kubectl port-forward svc/my-release-spark-master-svc 8080:8080
```

- Access the Spark UI at http://localhost:8080.

### 2. 🏃 Run Example Spark Jobs
Use kubectl exec to run Spark jobs on the cluster:

```bash
/opt/bitnami/spark/bin/spark-submit \
--class org.apache.spark.examples.SparkPi \
--master spark://my-release-spark-master-svc:7077 \
examples/jars/spark-examples_2.12-3.5.3.jar  \
100
```

if everything is setup the right way, you should get below output:
```bash
Pi is roughly 3.1402867140286714
```
