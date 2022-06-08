FROM httpd:2.4-alpine

RUN apk update
RUN apk add ruby=3.1.2-r0
RUN gem install rexml

COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
COPY . /usr/local/apache2/htdocs/
