FROM datadog/centos-i386:5
MAINTAINER Remi Hakim @remh

RUN linux32 yum -y install \
    rpm-build \
    xz \
    curl \
    gpg \
    which \
    # Dependencies below are for rrdtool..
    intltool \
    gettext \
    cairo-devel \
    libxml2-devel \
    pango-devel \
    pango \
    libpng-devel \
    freetype \
    freetype-devel \
    libart_lgpl-devel \
    gcc \
    groff

# Set up an RVM with Ruby 2.2.2
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN linux32 yum -y install tar
RUN \curl -sSL https://get.rvm.io |  linux32 bash -s stable
RUN linux32 /bin/bash -l -c "rvm requirements"
RUN linux32 /bin/bash -l -c " rvm install 2.2.2"

RUN /bin/bash -l -c " gem install bundler --no-ri --no-rdoc"

# Install go (required by to build gohai)
RUN curl -o /tmp/go1.3.3.linux-386.tar.gz https://storage.googleapis.com/golang/go1.3.3.linux-386.tar.gz && \
    tar -C /usr/local -xzf /tmp/go1.3.3.linux-386.tar.gz && \
    echo "PATH=$PATH:/usr/local/go/bin" | tee /etc/profile.d/go.sh

RUN  linux32 yum -y install \
    git \
    install \
    perl-ExtUtils-MakeMaker \
    fakeroot

RUN git config --global user.email "package@datadoghq.com"
RUN git config --global user.name "Centos Omnibus Package"
RUN git clone https://github.com/DataDog/dd-agent-omnibus.git
RUN cd dd-agent-omnibus && \
     linux32 /bin/bash -l -c "bundle install --binstubs"

# This is a hack for rrdtool 
RUN ln -s /usr/lib/perl5/5.8.8/i386-linux-thread-multi/CORE /usr/lib/perl5/CORE 

VOLUME ["/dd-agent-omnibus/pkg"]

ENTRYPOINT linux32 /bin/bash -l /dd-agent-omnibus/omnibus_build.sh
