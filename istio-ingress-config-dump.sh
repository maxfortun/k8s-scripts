#!/bin/bash -x

pods=$(kubectl -n istio-system  get pod|grep istio-ingressgateway|awk '{print $1}')

for pod in $pods; do
	echo $pod
	file=$pod.json
   	rm -f $file
	stdin $pod -- curl 0:15000/config_dump > $file
done

