#!/usr/bin/bash

app_name=mysql
sql_script=build-db.sql
db_root_pswrd=dev@123 # Should always be encrypted!
db_name=mydb

function deploy-k8s-resources(){
    echo "" && echo "==> Deploy Persistent Volume & persistent volume claim for ${app_name}" && echo ""
    kubectl apply -f ${app_name}-storage.yaml

    echo "" && echo "--Confirm pv and pvc deployments" && echo ""
    kubectl get persistentvolume && echo "" && kubectl get persistentvolumeclaim
    
    echo "" && echo "==> Deploy secret for ${app_name}" && echo ""
    kubectl apply -f ${app_name}-secret.yaml

    echo "" && echo "--Confirm secret deployments" && echo ""
    kubectl get secrets
    
    echo "" && echo "==> Deploy the DB and then expose it to the outside world as K8s service" && echo ""
    kubectl apply -f ${app_name}-deployment.yaml

    echo "" && echo "--Confirm ${app_name} db app deployment and service" && echo ""
    kubectl get deployments && kubectl get service
}

function build-db(){
    # End goal is to populate instance with the db
    
    # Get the pod name as a variable.
    echo "" && echo "==> Get the ${app_name} running pod" && echo ""
    pod_name=$(kubectl get pods | grep mysql | awk '{print $1}')
    echo "" && echo "Pod Name = ${pod_name}" && echo ""

    # Copy rebuild_db.sql script into the pod
    echo "" && echo "==> Copy rebuild_db.sql script into the pod : ${pod_name} " && echo ""
    kubectl cp ${sql_script} ${pod_name}:/${sql_script}

    echo "" && echo "==> Confirm script copied into pod : ${pod_name} " && echo ""
    kubectl exec -it ${pod_name} -- ls -l

    # Execute the script inside the pod:
    # Get into pod to tshoot? : $ kubectl exec --stdin --tty <pod name> -- /bin/bash
    echo "" && echo "==> Execute the script inside the pod : ${pod_name}" && echo ""
    kubectl exec -it ${pod_name} -- mysql -u root -p${db_root_pswrd} ${db_name} < /${sql_script}
}

deploy-k8s-resources
build-db


# Issues
# stuck on this error : ./build-mysql-app.sh: line 46: /build-db.sql: No such file or directory
# Chose to get into the pod and do it manually