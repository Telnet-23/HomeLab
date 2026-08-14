# Build Process - All Nodes

- Install Raspberry Pi imager on another PC
- Insert the MicroSD into the PC and run the imager. Install Raspberry OS (Other) and select 64-bit lite.
- Once it's built, insert the MicroSD into the PI and power it on. Give it about 5mins.
- Unplug the PI and remove the MicroSD. Plug it back into your other computer. 
- Navigate to `bootfs` drive and open `cmdline.txt`
- Scroll to the end where it says 'rootwait' and paste `cgroup_memory=1 cgroup_enable=memory` then add the IP information like this `ip=192.168.0.240::gatewayip:netmask:hostname:eth0:off`. Save the file and close
- Now open `config.txt`. Scroll to the very bottom and add `arm_64bit=1`. Save it. 
- Open the CLI and cd to the removable drive then create a new file called 'ssh'.
- To create a user to ssh in with, run `vi userconfig.txt` and create a user with username:passwordhash. The below will create a 'pi' user with the password 'raspberry': 
```pi:$6$c70VpvPsVNCG0YR5$l5vWWLsLko9Kj65gcQ8qvMkuOoRkEagI90qi3F/Y7rm8eNYZHW8CY6BOIKwMH7a3YYzZYL90zf304cAHLFaZE0```

- Put the MicroSD back into the Pi and power it on (connect the ethernet port and ping it)
- SSH to the Pi with `ssh pi@ip` with the default password `raspberry`
- Switch user to root with ```sudo su -```
- Run the following to install ip tables and vi to build your manifests.
```
sudo apt install iptables vim -y
sudo iptables -F
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
```
- Delete the swap file and turn it off for good measure. Kubernetes does not play nice with swap file enabled.
```
sudo dphys-swapfile swapoff
sudo dphys-swapfile uninstall
sudo update-rc.d dphys-swapfile remove      
sudo swapoff -a
```
- Reboot the Pi.

# Install Kubernetes - Master/Control-Plane

- SSH into the node
  
- Switch user to root again with `sudo su -`
  
- Check the swap now shows 0B in the total field using `free -h`

- Run ```curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -s``` to install Kubernetes

- To get the token to add other nodes, run ```cat /var/lib/rancher/k3s/server/node-token```

# Adding Nodes
- Do everything form the 'Build Process - All Nodes' section on all the Pi(s).
- SSH into the other Pi(s) and run `sudo su -` to switch to root user
- Run ```curl -sfL https://get.k3s.io | K3S_TOKEN="YOUR_TOKEN" K3S_URL="https://[your master ip]:6443" K3S_NODE_NAME="servername" sh -```
