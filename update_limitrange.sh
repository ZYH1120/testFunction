echo -e  "cpu:\c"
read cpu


sed -i  " 8c  cpu: $cpu\m" limit.yaml
sed -i  " 10c   cpu: $cpu\m" limit.yaml
sed -i "s/cpu/      cpu/g" limit.yaml

sudo kubectl delete limitrange mylimits  -n openwhisk
sudo kubectl create -f  limit.yaml -n openwhisk

sh deleteContainer.sh
