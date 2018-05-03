FROM nginx:latest

COPY generate_conf.sh /
COPY entrypoint.sh /

CMD ["sh", "entrypoint.sh"]