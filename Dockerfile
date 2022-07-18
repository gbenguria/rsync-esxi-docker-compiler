FROM centos:centos7

RUN yum -y install \
epel-release \
git \
lz4-devel \
lz4-static \
libzstd \
libzstd-static \
openssl-static \
python3-pip \
python3-devel \
glibc-static \
popt-devel \
popt-static \
make \
automake \
xxhash-devel \
libzstd-devel \
gcc \
&& \
pip3 install cmarkgfm

RUN yum -y install \
wget \
&& \
cd / && \ 
wget https://download-ib01.fedoraproject.org/pub/epel/7/SRPMS/Packages/x/xxhash-0.8.1-1.el7.src.rpm && \
rpm -ivh xxhash-*.el7.src.rpm && \
cd ~/rpmbuild/SPECS && \
yum -y install \
doxygen \
rpm-build \
&& \
rpmbuild -bp xxhash.spec && \
cd ~/rpmbuild/BUILD/xxHash-*/ &&\
make install

 
ARG RSYNC_VERSION=v3.2.4
RUN cd / && \
git clone https://github.com/WayneD/rsync.git && \
cd rsync && \
git checkout $RSYNC_VERSION

RUN yum -y install \
epel-release \
git \
lz4-devel \
lz4-static \
libzstd \
libzstd-static \
openssl-static \
python3-pip \
python3-devel \
glibc-static \
popt-devel \
popt-static \
make \
automake \
xxhash-devel \
libzstd-devel \
gcc 
 
WORKDIR /rsync

RUN cd /rsync && \
LIBS="-ldl" ./configure && \
make -B CFLAGS="-static" 

RUN echo should show  not a dynamic executable && \
ldd rsync || \
true
