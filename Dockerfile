FROM postgres:latest

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD postgres

COPY *.sql /docker-entrypoint-initdb.d/

RUN  apt update && apt install -y  build-essential git postgresql-server-dev-all
RUN cd /opt && git clone https://github.com/mausimag/pgflake.git && cd pgflake && make && make install && rm -rf /opt/pgflake