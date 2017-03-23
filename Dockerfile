FROM centos:7

MAINTAINER barie3

#Install epel,remi
RUN yum install -y epel-release
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

#Install yum libs
RUN yum install -y tar gcc make wget curl openssh openssh-server openssh-clients sudo man zlib-devel openssl-devel cpio expat-devel gettext-devel curl-devel gcc-c++ zlib readline readline-devel openssl ncurses-devel bzip2 zsh libyaml-devel libffi-devel gdbm-devel perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker patch sqlite-devel gcc-c++ flex bison gperf freetype-devel fontconfig-devel libicu-devel libpng-devel libjpeg-devel libnotify unzip
RUN yum --enablerepo=epel,centos-sclo-rh -y install rh-ruby23-ruby-devel nodejs gcc make libxml2 libxml2-devel mariadb-devel zlib-devel libxslt-devel

#Install MySQL
RUN yum -y install http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
RUN yum -y install mysql-community-server mysql-community-devel.x86_64
RUN chkconfig mysqld on
RUN service mysqld start

#Install git
RUN yum install -y git

#Install rbenv
ADD install-rbenv.sh /usr/local/src/install-rbenv.sh
RUN chmod +x /usr/local/src/install-rbenv.sh
RUN /usr/local/src/install-rbenv.sh

#Install vim
RUN yum install -y vim-enhanced

#setup user
RUN useradd -m vary
RUN echo 'vary:password' | chpasswd
RUN echo 'vary ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/vary
RUN echo 'password' | chsh -s /bin/zsh vary

#setup locale
RUN localedef -f UTF-8 -i ja_JP ja_JP
RUN cp /usr/share/zoneinfo/Japan /etc/localtime
