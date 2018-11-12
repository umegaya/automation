### how to login jenkins instance
```
chmod 400 ./hl_jenkins.pem # if permission is not 400
ssh -i ./hl_jenkins.pem ubuntu@54.208.24.144
ssh -i ./hl_jenkins.pem ubuntu@34.227.31.252 #prod 
```

### how to login jenkins
```
open https://54.208.24.144/jenkins (or second address for prod)
login with root/9d398224f80612a38fc4bfe96bc1c3cf
```

### setup operation (in case of build up from ground)
0. launch AWS instance (use ubuntu AMI)


1. login instance and setup docker ()


2. setup docker machine (after that all operation executed by jenkins user)
- pull github repository 
```
git clone https://github.com/JeffreyChee/monsterGO/

# setup this node
cd monsterGO/Server
make build_hq CONFIG=$(prod|stage|local)

# setup worker nodes for service
cd monsterGO/Server/tools/
./cluster/init.sh ./cluster/params_stage.sh (or use params_prod.sh according to your purpose)
./cluster/setup.sh ./cluster/params_stage.sh (or use params_prod.sh according to your purpose)
```

3. configure so that user autometically logins as jenkins user
- after that relogin this machine
```
vi ~/.bash_profile
```
```
sudo su -l jenkins
```

4. setup jenkins job
- run Server/tools/jenkins/scripts/deploy/prod.sh or stage.sh when proper branch pushed.
- install Post Build Task to catch build error and send it to slack
- stage.sh does deploy entire service
- prod.sh require service name (mgorbtl, mgoesys, mgofe) because no need to restart unnecessary service. usually only mgofe is enough
 - recommended way is if branch which name is prod/rbtl/{date} pushed, then deploy mgorbtl, and so on.


### EDIT
- unify everything run in docker container to simplify setup process  
