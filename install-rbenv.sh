#!/bin/bash
#Install rbenv

ruby_version=2.4.0

if [ ! -d /usr/local/rbenv ];then
    cd /usr/local
    git clone https://github.com/sstephenson/rbenv.git rbenv

    mkdir -p rbenv/shims rbenv/versions rbenv/plugins
    cd rbenv/plugins
    git clone https://github.com/sstephenson/ruby-build.git   ruby-build
    cd ruby-build
    ./install.sh

    cd /usr/local

    # Setup rbenv for all user
    echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh
    echo 'PATH=${RBENV_ROOT}/bin:$PATH' >> /etc/profile.d/rbenv.sh
    echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
    source /etc/profile.d/rbenv.sh

    # Install ruby
    rbenv install $ruby_version
    rbenv rehash
    rbenv global $ruby_version  # default ruby version

    #rbenv(add user to rbenv group if you want to use rbenv)
    useradd rbenv
    chown -R rbenv:rbenv rbenv
    chmod -R 775 rbenv

    # install without ri,rdoc
    echo 'install: --no-ri --no-rdoc' >> /etc/.gemrc
    echo 'update: --no-ri --no-rdoc' >> /etc/.gemrc
    echo 'install: --no-ri --no-rdoc' >> /.gemrc
    echo 'update: --no-ri --no-rdoc' >> /.gemrc

    # install bundler
    gem install bundler json_pure
    gem update --system
    gem install spring pry
    gem pristine --all

    #install rails5
    gem install nokogiri -- --use-system-libraries
    gem install rails --no-ri --no-rdoc
    rbenv rehash
fi
