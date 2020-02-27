FROM opensuse/leap:latest

ENV LANG=en_US.UTF-8

RUN zypper --non-interactive install --replacefiles which hostname expect net-tools net-tools-deprecated iputils wget vim iproute2 unrar less tar gzip uuidd tcsh libaio insserv-compat libatomic1 libnuma1 sudo libltdl7 unzip sap*
#RUN zypper refresh && zypper --non-interactive up

# uuidd is needed for all SAP instance
RUN mkdir /run/uuidd && chown uuidd /var/run/uuidd && /usr/sbin/uuidd

#Fix the auto_content directory issue
RUN mkdir /hana /hana/shared /hana/shared/H4C /hana/shared/H4C/global /hana/shared/H4C/global/hdb /hana/shared/H4C/global/hdb/auto_content

# Copy expect script + the extracted SAP NW ABAP files to the container
COPY sapdownloads /tmp/sapdownloads/

WORKDIR /tmp/sapdownloads

RUN chmod +x hdblcm.sh hdblcmgui.sh

#adding the hostname resolution to the os
#RUN echo "$(hostname -I | awk '{print $1}')    $HOSTNAME" >> /etc/hosts

# Important ports to be exposed (TCP):
# HTTP
EXPOSE 8000
# HTTPS
EXPOSE 44300
# ABAP in Eclipse
EXPOSE 3300
# SAP GUI
EXPOSE 3200
# SAP Cloud Connector
# EXPOSE 8443
#SAP HANA
EXPOSE 3290
EXPOSE 3390
EXPOSE 51034
EXPOSE 51032

# Solution: run original hdblcm.sh after the image has been created
RUN echo "$(hostname -I | awk '{print $1}')     hckptn01" >> /etc/hosts | ./hdblcm.sh --action=install --configfile=/tmp/sapdownloads/h4c_config -b
#RUN ./hdblcm.sh --action=install --configfile=/tmp/sapdownloads/h4c_config -b