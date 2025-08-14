FROM httpd:2.4-alpine

RUN apk update
RUN apk add ruby=3.4.4-r0
RUN gem install rexml

COPY .infra/httpd.conf /usr/local/apache2/conf/httpd.conf
COPY . /usr/local/apache2/htdocs/

RUN chmod +x /usr/local/apache2/htdocs/public/index.cgi
