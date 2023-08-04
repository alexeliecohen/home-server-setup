#!/usr/bin/env
source ".env.sh"
echo ${ENV_VARS["REDIS_HOST"]}
IS_SWARM_AVAILABLE=$(docker info --format '{{.Swarm.ControlAvailable}}')

 
if [[ $IS_SWARM_AVAILABLE == "false" ]]
then
	docker swarm init
fi

SECRETS_LIST=( $(docker secret ls --format={{.Name}}) )
#echo $SECRETS_LIST
for i in "${!ENV_VARS[@]}"
do
#	echo $i 
	if [[ ! " ${SECRETS_LIST[*]} " =~ " $i " ]]; then
		echo ${ENV_VARS[$i]} | docker secret create $i - 
	fi
 # echo "key  : $i"
  #echo "value: ${ENV_VARS[$i]}"
done

#SECRETS_LIST=( $(docker secret ls --format={{.Name}}) )
#if [[ " ${SECRETS_LIST[*]} " =~ " ${} " ]]; then

