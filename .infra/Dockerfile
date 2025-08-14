FROM httpd:2.4-alpine

RUN apk update
RUN apk add ruby=3.4.4-r0
RUN gem install rexml
RUN gem install minitest

COPY .infra/httpd.conf /usr/local/apache2/conf/httpd.conf
