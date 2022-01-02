# docker-nfdump-csv
Export nfcapd data to CSV


Inspired by https://github.com/netsage-project/docker-nfdump-collector to allow for the collection and exporting of netflow data for ingestion into Splunk

The container will create CSV output files from netflow capture files, found in the volume mounted at '/data', with the exception of the most recent file.  CSV output will be stored in the '/log' directory of the container.  The capture file will be deleted after nfdump completes.

Example dockercompose

```yaml
version: "3.6"
services:
  nfcap:
    container_name: netflow_collector
    image: netsage/nfdump-collector:1.6.23
    command: /usr/local/bin/nfcapd -T all -l /data -S 1 -w -z -p 9999
    restart: on-failure
    volumes:
      - netflow_data:/data
    ports:
      - "9999:9999/udp"
    networks:
      - default
  nfdump:
    container_name: netflow_dump
    build:
      context: . 
    restart: on-failure
    volumes:
      - netflow_data:/data
      - /var/log/netflow:/log
    networks:
      - default
volumes:
  netflow_data:
    external: true
networks:
  default:
    driver: bridge

```