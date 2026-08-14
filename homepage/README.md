Homepage acts as a landing page for my cluster. All the apps I deploy will be accesssible via Homepage. The manifest included is compliled from thier offical install documentation found here: https://gethomepage.dev/installation/k8s/

Some tweeks have been made. Firstly it as been edited to allow allows from all IP's. Secondly, I have swapped out the cluster ip service for a Node Port so that I can access it from any device on my LAN over port 30122. 

Before you apply the maniscipt, please create the namespace with: kubectl create namespace homepage-system
