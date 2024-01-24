FROM ubuntu:22.04.3 LTS
WORKDIR C:\Program Files\Docker

COPY cpu_test_script.sh .
COPY fileio_test_script.sh .
COPY memory_test_script.sh .

RUN apt-get update
RUN apt-get install -y sysbench

RUN chmod +x cpu_test_script.sh
RUN chmod +x fileio_test_script.sh
RUN chmod +x memory_test_script.sh
