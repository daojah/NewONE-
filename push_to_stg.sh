#!/bin/bash
# PATH Vars
SRC_PATH="../../../configs/staging/rsynced"
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
    for R_DST in "${arr[@]}"; do
        SRC="$SRC_PATH"/"$HOST_NAME""$R_DST"
        # Check if R_DST dir is exists on remote
        if ssh -i "$SSH_KEY" ${SSH_OPTS} dasupport@"$HOST_IP" [ -d $R_DST ] < /dev/null; then
            echo "$R_DST EXISTS ON REMOTE server"
            echo "RSYNC will be done"
#            echo "rsync -avz -e "ssh -i $SSH_KEY $SSH_OPTS" --rsync-path='sudo rsync' "$SRC" dasupport@"$HOST_IP":"$R_DST""
            rsync -avz -og --chown=root:root -p --chmod=F644 --chmod=D755 -e "ssh -i $SSH_KEY $SSH_OPTS" --rsync-path='sudo rsync' "$SRC" dasupport@"$HOST_IP":"$R_DST"
        else
            echo "$R_DST DOES NOT EXIST on remote server"
        fi
    done
    echo "Done for $HOST_NAME"
    echo "---------------EDN---------------"
done <hosts_stg