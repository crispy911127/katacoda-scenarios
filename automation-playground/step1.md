# Welcome!

`NB`. Please click the `IDE` and `Visualise Host` tabs before continuing to make sure they load up correctly, if you experience any weird behaviour please reload this tab or reenter the scenario.

The `IDE` is a built in version of Visual Studio Code, try it out!

The `Visualise Host` will show us what is deployed on the host, a good way to show what your scripts have deployed.

If you wish to use kubernetes for this, please run the below:

`launch.sh`{{execute}}

Wanna show off your CI/CD and automation skills? Should we start with Jenkins? Heres a freebie, run the below to terraform a container running jenkins:

`cd jenkins/; terraform init; terraform validate; sleep 2; terraform apply; cd`{{execute}}

Remember to confirm!

Click the `Jenkins` tab to access the web page for Jenkins, you will be asked for an inital admin password you can get it with this command:

`docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`{{execute}}
