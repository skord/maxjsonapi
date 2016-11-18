FROM skord/maxscale:edge-consul
RUN yum -y install centos-release-scl
RUN yum-config-manager --enable centos-sclo-rh-testing
RUN yum install -y rh-ruby23 rh-ruby23-ruby-devel rh-ruby23-rubygem-rake rh-ruby23-rubygem-bundler rh-nodejs4 sqlite-devel
COPY build/scl_enable /etc/scl_enable
COPY build/maxadminfile /root/.maxadmin
ENV BASH_ENV=/etc/scl_enable \
    ENV=/etc/scl_enable \
    PROMPT_COMMAND=". /etc/scl_enable"

ADD Gemfile Gemfile.lock /opt/maxapi/
WORKDIR /opt/maxapi
RUN bash -c bundle install
ADD . /opt/maxapi
EXPOSE 9292
CMD ["bash","-c","rails","server"]
