#!/bin/bash

# Set working directories relative to the script location
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
JAR_DIR="$PROJECT_ROOT/jar"
ARCHIVE_NAME="spark-3.5.5-bin-hadoop3.tgz"
ARCHIVE_PATH="$JAR_DIR/$ARCHIVE_NAME"
EXTRACT_DIR="$JAR_DIR/spark-3.5.5-bin-hadoop3"
JAR_PATH="$EXTRACT_DIR/examples/jars/spark-examples_2.12-3.5.5.jar"

NAMESPACE="spark"
DEST_PATH="/tmp"
CLASS_NAME="org.apache.spark.examples.SparkPi"
MASTER_URL="spark://spark-master-svc:7077"

# Step 1: Unpack Spark if necessary
if [ ! -d "$EXTRACT_DIR" ]; then
    echo "Unpacking Spark archive..."
    tar -xzf "$ARCHIVE_PATH" -C "$JAR_DIR"
else
    echo "Spark already unpacked at $EXTRACT_DIR"
fi

# Step 2: Find first Spark worker pod
WORKER_POD=$(kubectl get pods -n "$NAMESPACE" -l app.kubernetes.io/component=worker -o jsonpath='{.items[0].metadata.name}')

if [ -z "$WORKER_POD" ]; then
    echo "Error: No Spark worker pods found in namespace '$NAMESPACE'"
    exit 1
else
    echo "Using worker pod: $WORKER_POD"
fi

# Step 3: Copy example JAR
echo "Copying JAR to pod..."
kubectl cp "$JAR_PATH" "$NAMESPACE/$WORKER_POD:$DEST_PATH"

# Step 4: Run Spark job
echo "Running SparkPi example..."
kubectl exec -n "$NAMESPACE" -it "$WORKER_POD" -- spark-submit \
  --master "$MASTER_URL" \
  --class "$CLASS_NAME" \
  "$DEST_PATH/$(basename "$JAR_PATH")" 5
