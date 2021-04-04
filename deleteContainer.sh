a=($(sudo kubectl get pod -n openwhisk | grep "wskowdev-invoker-00" | awk '{print $1}'|tr '\n' " " ))
#echo ${a[0]}
for ind in ${a[@]}
do
 	sudo kubectl delete pod ${ind} -n openwhisk
done

sudo kubectl get pod -n openwhisk
