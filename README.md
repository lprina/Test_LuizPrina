# Test_LuizPrina

**Steps for Setup**

**1 - Install Docker Desktop on your machine by following the steps on the links below:**

Windows: https://docs.docker.com/desktop/windows/install/

Mac: https://docs.docker.com/desktop/mac/install/

To check your Docker version, use the command:

```bash
docker --version
```


2 - Enable Kubernetes :

Docker Desktop includes a standalone Kubernetes server that runs on your local machine. 
Right before you enable it, you need to adjust
the resources a little bit from the initial default configuration. (Settings -> Resources)

![Docker settings screenshot](images/docker1.png)

To enable Kubernetes on Docker Desktop:

- Open Docker Desktop settings.
- Find the Kubernetes section.
- Check the box that says “Enable Kubernetes”.
- Check the 'kubeadm' option
- Click “Apply & Restart” to save the changes.

![Docker settings screenshot](images/docker2.png)


Click on Install button:

![Docker settings screenshot](images/docker3.png)

**3 - Getting kubectl installed on your PC:**

For macOS:
Homebrew: If you have Homebrew installed, you can simply run:

```bash
brew install kubectl
```

For Windows:
Chocolatey: If you use Chocolatey as your package manager, you can install 
kubetcl by running:

```bash
choco install kubernetes-cli
```
After the installation, you can verify the installation by running

```bash
kubectl version
```
**4 - Configure Kubernetes Context**
- Kubernetes uses contexts to access different clusters. Docker Desktop sets a context named docker-desktop.
- To switch to this context, use:

```bash
kubectl config use-context docker-desktop.
```
**5 - Getting Helm Chart installed on your PC**

For macOS:
Homebrew: If you have Homebrew installed, you can simply run:
```bash
brew install helm
```

For Windows:
Chocolatey: If you use Chocolatey as your package manager, you can install Helm by running:

```bash
choco install kubernetes-helm
```

**6 - Deploying Kubernetes Dashboard**

Kubernetes Dashboard provides a user-friendly web-based interface to manage your Kubernetes cluster. 
It allows you to view and manage your cluster resources and applications, and also provides basic troubleshooting capabilities. 
Here’s how you can deploy the Kubernetes Dashboard:

Step 6.1: Deploy the Dashboard

Run the Deployment Command: To deploy the Kubernetes Dashboard, use kubectl to deploy the yaml 
configuration:

```bash
kubectl apply -f ./yaml/recommended-dashboard.yaml
```

This command downloads and applies the recommended deployment configuration from the Kubernetes Dashboard’s GitHub repository. 
And what you’ll see should look like this.

![Dashboard settings screenshot](images/dashboard1.png)

Step 6.2: Access the Dashboard

Start the Proxy: The Kubernetes Dashboard is accessed via a proxy server. 
Start the proxy with the following command:



