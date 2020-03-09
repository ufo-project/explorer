# UFO Blockchain explorer 

# Backend

Requirements:

* Ubuntu 18.04
* ufo explorer node from https://github.com/ufo-project/ufochain/releases

## Start ufo-exlplorer node (mainnet)

`./explorer-node --peer=mainnet-node01.ufo.link:20015`

## General Linux 

`sudo apt-get update`

`sudo apt-get install vim git wget nginx python3 python3-pip ufw python3-venv redis-server`

## Pull lastest blockchain explorer code from git

`git clone https://github.com/ufo-project/explorer.git` or
`git pull origin master` to update


## Create virtual environment (first time only)

`mkdir ~/venvs`

`python3 -m venv ~/venvs/blockex`

`source ~/venvs/blockex/bin/activate` to activate the environment

`cd explorer`

`pip3 install -r requirements.txt`

`pip3 install gunicorn`

## Initialize Django environment (first time only)

`python3 manage.py makemigrations`

`python3 manage.py migrate`

`python3 manage.py collectstatic`

`sudo ufw allow 8000` (for testing only, open 8000 port in the firewall)

`python3 manage.py runserver 0.0.0.0:8000 --noreload &` (for testing only, open 8000 port in the firewall)

## Run celery
 `bash run_celery.sh`

## Create gunicorn service

`vi /etc/systemd/system/gunicorn.service`

Paste following configurations:

    [Unit]
    Description=gunicorn service
    After=network.target
    
    [Service]
    User=root
    Group=www-data
    WorkingDirectory=/root/explorer
    ExecStart=/root/venvs/blockex/bin/gunicorn --access-logfile - --workers 3 --bind 127.0.0.1:8000 blockex.wsgi:application
    
    [Install]
    WantedBy=multi-user.target

`sudo systemctl enable gunicorn.service`

`sudo systemctl start gunicorn.service`

`sudo systemctl status gunicorn.service`

To reload gunicorn after config change

`sudo systemctl daemon-reload`

`sudo systemctl restart gunicorn`

## Configure nginx

       location / {
         proxy_pass http://127.0.0.1:8000;
         proxy_set_header Host $host;
         proxy_set_header X-Real-IP $remote_addr;
         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
       }
      
To test configurations run: `sudo nginx -t`

To reload nginx after config init or change `sudo systemctl restart nginx`

`ufw sudo ufw allow 'Nginx Full'`


# Frontend

## Install nvm 

`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash`

## Install npm and dependence

`nvm i 12`

`nvm use 12`

`npm i`

## Build and deploy

`cd frontend/blockexapp`

`bash deploy.sh`



