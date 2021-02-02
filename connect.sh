#!/bin/bash

## Port forward everything
kubectl port-forward service/grafana 3000:80 &
GRAFANA_PID=$!

kubectl port-forward service/consul-ui 8500:80 &
CONSUL_PID=$!

hal deploy connect

echo $GRAFANA_PID > pid_file
echo $CONSUL_PID >> pid_file