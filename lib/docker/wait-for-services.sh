#!/bin/bash

# Wait for MySQL
until nc -z -v -w30 $DB_HOST $DB_PORT; do
 echo 'Waiting for MySQL...'
 sleep 1
done

echo "MySQL is up and running!"

# Wait for ElasticSearch
until nc -z -v -w30 $ELASTICSEARCH_HOST $ELASTICSEARCH_PORT; do
 echo 'Waiting for ElasticSearch...'
 sleep 1
done

echo "ElasticSearch is up and running!"