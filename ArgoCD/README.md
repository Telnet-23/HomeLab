ArgoCD manages all apps in my home cluster. The install script will create the namespace, install the app then check the deployment. You must run this first. 

There is a nodeport manifest to run which will then allow you to access the app on you LAN over port 8080.

Finally, there is a script you can run to obtain your admin password for ArgoCD. It will output it into a file to cat that file to obtain. The default username is 'admin'. 
