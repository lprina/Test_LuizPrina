#!/bin/bash

# Script to start kubectl proxy in a new Terminal window (macOS)

echo "Starting Kubernetes proxy in a new Terminal window..."
osascript -e 'tell app "Terminal" to do script "kubectl proxy --address=0.0.0.0 --disable-filter=true"'
echo "Proxy started, to access the URL: http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"

