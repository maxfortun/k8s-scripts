#!/bin/bash -ex

pods=$(kubectl -n istio-system  get pod|grep istio-ingressgateway|awk '{print $1}')

ROOT=/tmp/$LOGNAME/${0%.*}.d
[ ! -e $ROOT ] || rm -rf $ROOT

for pod in $pods; do
	dir=$ROOT/$pod
	mkdir -p $dir
	for type in all listener cluster; do
		istioctl -n istio-system pc $type $pod -o json > $dir/$type
	done
done

