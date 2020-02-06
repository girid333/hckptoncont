FROM opensuse/leap:latest

ENV LANG=en_US.UTF-8

RUN zypper --non-interactive install --replacefiles which hostname expect net-tools iputils wget vim iproute2 unrar less tar gzip uuidd tcsh libaio insserv-compat libatomic1 libnuma1 sudo sap*
#RUN zypper refresh && zypper --non-interactive up

# uuidd is needed for all SAP instance
RUN mkdir /run/uuidd && chown uuidd /var/run/uuidd && /usr/sbin/uuidd

# Copy expect script + the extracted SAP NW ABAP files to the container
COPY sapdownloads /tmp/sapdownloads/

WORKDIR /tmp/sapdownloads

RUN chmod +x hdblcm.sh hdblcmgui.sh

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

# Unfortunatelly, we cannot run the automated installation directly here!
# Solution: run original hdblcm.sh after the image has been created
# RUN ./hdblcm.sh
