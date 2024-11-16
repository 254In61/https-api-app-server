## Overview

REF : https://medium.com/@midejoseph24/deploying-mysql-on-kubernetes-16758a42a746

This part of the project entails deploying a mysql instance which is hosted as a pod in the k8s cluster.

For this project I am using microk8s, the single-node cluster, by Canonical.

I found microk8s to be easy on the cpu and memory of my Ubuntu Linux PC(the-eagle).

## k8s cluster & kubectl

=> The assumption is, the microk8s cluster is already installed and the cli tools i,e kubectl/oc are set-up, ready for use.
=> Checkout ~/.kube/config to see details of the deployed k8s cluster.

## deploy mysql service on k8s cluster

STEP 1. Deploy storage.
   - Deploy Persistent Volume
   - Deploy persistent volume claim.
   - Defined in deploy-yml-file/mysql-storage.yaml

   $ kubectl apply -f deploy-yml-file/mysql-storage.yaml
       persistentvolume/mysql-pv-volume created
       persistentvolumeclaim/mysql-pv-claim created

   - PV is located under Cluster
   - PV claim is located under Config & Storage
   
   - Check the persistent volume: $ kubectl get persistentvolume
   - Check the persistent volume claims : $ kubectl get persistentvolumeclaim

STEP 2. Deploy secret.
   - This will be for root access. New accounts to be created once deployment is complete.
   - Defined in deploy-yml-file/mysql-secret.yaml 

     $ kubectl apply -f deploy-yml-file/mysql-secret.yaml 
       secret/mysql-secret created

   - Secret is located under Config and Storage
  
   - Check secret : $ kubectl get secrets

STEP 3. Deploy the DB and then expose it to the outside world as K8s service.
   - Deployment and the service creation defined in deploy-yml-file/mysql-deployment.yaml
   
     $ kubectl apply -f deploy-yml-file/mysql-deployment.yaml
       deployment.apps/mysql created
       service/mysql created
   - Check deployments : $ kubectl get deployments
   - Check service     : $ kubectl get service

## Confirmation & access MySQL instance

1. List pods
 $ kubectl get pod
   NAME                     READY   STATUS    RESTARTS      AGE
   mysql-85d5bb8d57-9ng7v   1/1     Running   0             47m
   nginx-7854ff8877-jdqjv   1/1     Running   1 (11h ago)   27h

2. Get a shell for the pod by executing the following command:
 $ kubectl exec --stdin --tty mysql-85d5bb8d57-9ng7v -- /bin/bash
   bash-4.4#

3. access the MySQL shell and type in the password created when building the secret using mysql-secret.yml.
** So, how does one store this password securely??**

bash-4.4# mysql -p
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.3.0 MySQL Community Server - GPL

Copyright (c) 2000, 2024, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
mysql> show databases;
mysql> use mydb;
mysql> show tables;
mysql> select * from countries;

## Build db

- Build the user credential and db from here
  - Can be done manually after getting into bash as above.
  - Or can be deployed using the rebuild_db.sql SQL script.
    1. Get the pods list : $ kubectl get pods -A
    2. Copy the script into the pod : kubectl cp scripts/build-db.sql <pod_name>:/build-db.sql
    3. Execute the script inside the pod:
       $ kubectl exec -it <pod_name> -- mysql -u <username> -p<password> <database_name> < /build-db.sql

  

## Remote access

- Since it is my own dev environment, I don't have Loadbalancers or a setup that assigns an external IP.
$ kubectl get svc
NAME         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
kubernetes   ClusterIP   10.152.183.1     <none>        443/TCP    123d
mysql        ClusterIP   10.152.183.178   <none>        3306/TCP   123d


- Microk8s cluster is installed on the-eagle(192.168.1.100).

- The-eagle is the application server and has access to the K8s cluster that hosts the myql app.

- Test access: 
  $ mysql -h <cluster Ip assigned to mysql> -P 3306 -u dev -p
  Example: mysql -h 10.152.183.178 -P 3306 -u dev -p