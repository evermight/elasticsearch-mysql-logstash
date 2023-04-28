#!/bin/bash

source ./.env

hostprotocol="http"
if [ "$ELASTICSSL" = "true" ]; then
  hostprotocol="https"
fi

curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/timesheet"
curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/timesheet/_mapping" \
-H "Content-Type: application/json" \
-d @$PROJECTPATH/mapping/timesheet.json

curl -X PUT -u $ELASTICUSER:$ELASTICPASS "$hostprotocol://$ELASTICHOST/_ingest/pipeline/timesheet" \
-H "Content-Type: application/json" \
-d @$PROJECTPATH/pipeline/timesheet.json

logstashconf=`cat ${PROJECTPATH}/logstash/logstash.conf`
logstashconf="${logstashconf//\#\#JDBCJARFILE\#\#/"$JDBCJARFILE"}"
logstashconf="${logstashconf//\#\#JDBCCONNSTRING\#\#/"$JDBCCONNSTRING"}"
logstashconf="${logstashconf//\#\#JDBCUSER\#\#/"$JDBCUSER"}"
logstashconf="${logstashconf//\#\#JDBCPASS\#\#/"$JDBCPASS"}"
logstashconf="${logstashconf//\#\#ELASTICHOST\#\#/"$ELASTICHOST"}"
logstashconf="${logstashconf//\#\#ELASTICSSL\#\#/"$ELASTICSSL"}"
logstashconf="${logstashconf//\#\#ELASTICUSER\#\#/"$ELASTICUSER"}"
logstashconf="${logstashconf//\#\#ELASTICPASS\#\#/"$ELASTICPASS"}"
/usr/share/logstash/bin/logstash -e "$logstashconf"

