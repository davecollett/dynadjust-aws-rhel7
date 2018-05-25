#!/bin/bash
##Needs to be built on machine with at least 64gb ram

##Change to DTS
## You need to run this bit by itself to ensure the credentials are entered correctly
sudo subscription-manager register
    #Enter Redhat credentials

##Now run this next section
sudo subscription-manager refresh
sudo subscription-manager attach --auto
sudo subscription-manager repos --enable rhel-7-server-devtools-rpms
#sudo subscription-manager repos --enable rhel-7-server-extras-rpms
#sudo subscription-manager repos --enable rhel-7-server-optional-rpms
#sudo subscription-manager repos --enable rhel-server-rhscl-7-rpms
sudo yum install -y devtoolset-7-gcc
sudo yum install -y devtoolset-7-gcc-c++
scl enable devtoolset-7 bash

##FROM HERE ON YOU CAN RUN IT HANDS-OFF...

##Install awscli
 curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
 sudo python get-pip.py
 sudo pip install awscli
 rm get-pip.py
 #aws configure
    #Enter AWS Credentials for S3 (only needed if downloading from protected S3 buckets)

##Install Dev Tools
 sudo yum groupinstall -y "Development Tools"

##Install Boost and Xerces
#sudo yum install -y boost
sudo yum install -y boost-devel
sudo yum install -y xerces-c
sudo yum install -y cmake

##Download and install WGET, XSD and Xerces-c-devel
sudo yum-config-manager --enable epel
sudo yum install -y wget
mkdir ~/temp
cd ~/temp

wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y epel-release-latest-7.noarch.rpm
sudo yum-config-manager --enable epel
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/x/xsd-4.0.0-14.el7.x86_64.rpm
sudo yum install -y xsd-4.0.0-14.el7.x86_64.rpm

wget https://rpmfind.net/linux/centos/7.4.1708/os/x86_64/Packages/xerces-c-devel-3.1.1-8.el7_2.x86_64.rpm
sudo yum install -y xerces-c-devel-3.1.1-8.el7_2.x86_64.rpm
#rm *.rpm

##Install MKL
sudo yum-config-manager --add-repo https://yum.repos.intel.com/setup/intelproducts.repo
sudo rpm --import https://yum.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo yum install -y intel-mkl-2018.1-038

##Create some folders
sudo mkdir -p /opt/dynanet/gcc/3_3_0/
mkdir ~/bin/
mkdir ~/dna_build/
cd ~/dna_build/

#Now copy in the source and get ready to build it!
