#!/bin/bash

echo "Waiting for Elasticsearch..."
until curl -s -k -u "elastic:${ELASTIC_PASSWORD}" https://elasticsearch:9200/_cluster/health > /dev/null; do
    sleep 5
done

echo "Setting kibana_system password..."
curl -X POST "https://elasticsearch:9200/_security/user/kibana_system/_password?pretty" \
  -k \
  -u "elastic:${ELASTIC_PASSWORD}" \
  -H "Content-Type: application/json" \
  -d "{\"password\":\"${KIBANA_SYSTEM_PASSWORD}\"}"

echo "Setting logstash_system password..."
curl -X POST "https://elasticsearch:9200/_security/user/logstash_system/_password?pretty" \
  -k \
  -u "elastic:${ELASTIC_PASSWORD}" \
  -H "Content-Type: application/json" \
  -d "{\"password\":\"${LOGSTASH_SYSTEM_PASSWORD}\"}"

echo "Setup completed!"