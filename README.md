# hckptoncnt
HANA Cockpit on Docker Container

Build the docker image using this repo and create your own images to run in one go.

System Requirements
--------------------
Memory: 24GB Minimum
CPU: 4 Minimum
HDD: 80GB
Host OS: Any OS which can run docker engine
Docker server version 19.0+

Instructions
-----------------

1) Download the latest HANA cockpit installer from SAP support website. The file name will look like "SAPHANACOCKPIT11_11-70002299.SAR".

2) Install git (https://www.linode.com/docs/development/version-control/how-to-install-git-on-linux-mac-and-windows/) to your windows/mac desktop or any other Linux machine where docker engine is up and running. (For installing docker on your desktop or in server with community edition pls refer the link https://docs.docker.com/docker-for-windows/install/ & https://docs.docker.com/install/

3) Next clone this repository to a local directory with "git clone https://github.com/girid333/hckptoncnt.git" (without quotes)

4) A folder with name "hckptoncnt" will be created.

5) perform "cd hckptoncnt" now can see Dockerfile and a folder with name sapdownloads.

6) Extract the downloaded HANA cockpit .SAR file into sapdownloads folder (SAPCAR -xvf SAPHANACOCKPIT11_11-70002299.SAR -R .../hckptoncnt/sapdownloads)

7) From hckptoncnt folder execute "docker build -t hanackpt:2.0 ." (without quotes)

8) Wait untill build is over, then the image with "hanackpt:2.0" HANA cockpit installed is ready for use.

9) Next we can run a docker container using the image "docker run -p 8000:8000 -p 443:443 -p 3300-3399:3300-3399 -p 3200-3299:3200-3299 -p 51020-51040:51020-51040  -h hckptn01 --name hckptn1 -it hanackpt:2.0 /bin/bash"

10) Once container is up and running with above command it will login to container guest shell. From there switch to user h4cadm with "su - h4cadm"

11) Now start HANA database with command "HDB start" wait untill HANA gets started.

12) Once HANA is up we can use the launchpad with url that gets specifed during build.
