#FROM 383707766587.dkr.ecr.ap-southeast-2.amazonaws.com/kelsiem.com/kelsiemlogstash
FROM 383707766587.dkr.ecr.ap-southeast-2.amazonaws.com/kelsiem.com/kelsiemlinux

### TODO: Maybe we don't need a Logstash image above since bundle install appears to be doing something to install Logstash (not sure if it's the full Logstash or just the JRuby dependecies, not sure what is the minimum requirement), perhaps just start with normal Amazon Linux image


# Install JRuby on Amazon Linux
RUN \
    # Install prerequisites
    yum install -y gcc openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel ruby-devel gcc-c++ jq git && \
    # Import key
    curl -sSL https://rvm.io/mpapis.asc | gpg2 --import - && \
    # Install RVM
    curl -sSL https://get.rvm.io | bash -s stable --ruby && \
    # Set up RVM shell
    source /usr/local/rvm/scripts/rvm

RUN \
    /usr/local/rvm/scripts/rvm && \
    # Install jruby
    /usr/local/rvm/scripts/rvm install jruby && \
    # Confirm
    jruby -v


RUN mkdir -p /opt/okta_system_log
COPY /* /opt/okta_system_log/
WORKDIR /opt/okta_system_log
RUN ls -la /opt/okta_system_log


RUN bundle install