#!/bin/bash
#
# Must be run remotely on submitter boxes

SUBMITTER_REPO_URL=https://github.com/ONSdigital/eq-submitter
BRANCH=master

sudo apt-get update
sudo apt-get install python-pip -y
sudo apt-get install unzip -y
sudo apt-get install git -y

# Install 3.2.X so we can use ENV_* syntax in our startup script.
sudo pip install supervisor

wget https://github.com/ONSDigital/eq-submitter/archive/$BRANCH.tar.gz
tar -xvf $BRANCH.tar.gz
mv eq-submitter-$BRANCH eq-submitter
cd eq-submitter
pip install --user -r requirements.txt

# Setup init script and restart supervisor
sudo cp supervisor.sh /etc/init.d/supervisord
sudo chmod +x /etc/init.d/supervisord
sudo update-rc.d supervisord defaults

# Move our config for our program to the supervisord conf file.
sudo cp supervisord.conf /etc/supervisord.conf
sudo /etc/init.d/supervisord restart