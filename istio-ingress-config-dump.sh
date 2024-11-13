#!/bin/bash -x

pods=$(kubectl -n istio-system  get pod|grep istio-ingressgateway|awk '{print $1}')

ROOT=.
for pod in $pods; do
	dir=$ROOT/$pod
	[ ! -e $dir ] || rm -rf $dir
	mkdir -p $dir
	for type in listener all; do
		istioctl -n istio-system pc $type $pod -o json > $dir/$type
	done
done

