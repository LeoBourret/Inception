FROM debian:buster

RUN apt-get update && apt-get -y install nginx openssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/lebourre.42.fr.pem -keyout /etc/ssl/lebourre.42.fr.key -subj "/C=FR/ST=Ile-De-France/L=Paris/O=42/OU=lebourre/CN=lebourre.42.fr"

COPY ./nginx.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
