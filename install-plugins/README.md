Motivation:
I had a Jenkins installed locally on Ubuntu 22 with a bunch of plugins installed.
After installing jenkins_docker, I looked for an option to import plugins list
from local Jenkins to jenkins_docker server.

With help of ChatGPT and Claudie,
I got a file plugins-list.txt with plugin names from CLI from my local Jenkins,
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:admin list-plugins | awk '{print $1 ":" $NF}' > plugins-list.txt
Then I created install-plugins.sh.
To run:
- clone repo
- cd install-plugins
- cp .env.example .env # and update 
- chmod 764 *.sh
- ./install-plugins.sh

No problem to reinstall already installed plugin,
as Jenkins cli install-plugin command peacefully skips already installed plugins.
