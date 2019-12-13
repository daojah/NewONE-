#!/bin/bash
# PATH Vars
DST_PATH="../../../configs/production/rsynced"
# SSH Vars
SSH_KEY="../../../ansible/key/dasupport.key"
SSH_OPTS="-o StrictHostKeyChecking=no"
arr=("/etc/magdata/" "/opt/magdata/")
while read LINE;
do
    echo "-----BEGIN-----"
    HOST_NAME=`echo "$LINE" | awk '{print $1}'`
    HOST_IP=`echo "$LINE" | awk '{print $2}'`
    echo "hostname is $HOST_NAME"
    echo "IP is $HOST_IP"
    for R_SRC in "${arr[@]}"; do
        DST="$DST_PATH"/"$HOST_NAME""$R_SRC"
        # Check if R_SRC dir is exists on remote
        if ssh -i "$SSH_KEY" ${SSH_OPTS} dasupport@"$HOST_IP" [ -d $R_SRC ] < /dev/null; then
            # Check if DST dir is exists on local
            if  [ ! -d "$DST" ]; then
                # If does not exists on local then create it and rsync
                echo "$R_SRC EXISTS ONLY ON REMOTE server"
                echo "$DST will be created"
                mkdir -p "$DST"
                echo "RSYNC will be done"
                rsync -avz -e "ssh -i $SSH_KEY $SSH_OPTS" --delete --include='*/' --include='*.properties' --include='*.conf' --include='*.xml' --exclude='*' dasupport@"$HOST_IP":"$R_SRC" "$DST"
            else
                # If exists on local then rsync
                echo "$R_SRC EXISTS on REMOTE and LOCAL server"
                echo "RSYNC will be done"
                rsync -avz -e "ssh -i $SSH_KEY $SSH_OPTS" --delete --include='*/' --include='*.properties' --include='*.conf' --include='*.xml' --exclude='*' dasupport@"$HOST_IP":"$R_SRC" "$DST"
            fi
        else
            echo "$R_SRC DOES NOT EXIST on remote server"
        fi
    done
    echo "Done for $HOST_NAME"
    echo "---------------EDN---------------"

done <hosts_prod

