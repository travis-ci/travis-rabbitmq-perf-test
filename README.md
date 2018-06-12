# travis-rabbitmq-perf-test

Run [rabbitmq-perf-test](https://github.com/rabbitmq/rabbitmq-perf-test) on heroku.

## Heroku remote

```
heroku git:remote -a travis-rabbitmq-perf-test
```

## Setup

```
heroku buildpacks:add https://github.com/travis-ci/heroku-buildpack-run
heroku buildpacks:add heroku/jvm
heroku addons:create cloudamqp:bunny
heroku addons:upgrade cloudamqp:rabbit # larger plan needed for 2 node cluster
# heroku addons:create cloudamqp:rabbit --nodes=3
heroku addons:open CLOUDAMQP
ruby generate-rabbitmqadmin-conf.rb
```

## Run

```
heroku run -- perftest --help

# default settings
heroku run -- perftest

# policies
rabbitmqadmin delete policy name=HA
rabbitmqadmin declare policy name=ha pattern='^perf_ha$' definition='{"ha-mode":"all","ha-sync-mode":"automatic"}' apply-to=queues
rabbitmqadmin declare policy name=lazy pattern='^perf_lazy$' definition='{"queue-mode":"lazy"}' apply-to=queues
rabbitmqadmin declare policy name=ha-lazy pattern='^perf_ha_lazy$' definition='{"ha-mode":"all","ha-sync-mode":"automatic","queue-mode":"lazy"}' apply-to=queues

# exchanges
rabbitmqadmin declare exchange name=sharded type=x-modulus-hash auto_delete=false durable=true arguments='{"shards-per-node":2}'

# queues
rabbitmqadmin declare queue name=perf_default auto_delete=false durable=true
rabbitmqadmin declare queue name=perf_ha auto_delete=false durable=true
rabbitmqadmin declare queue name=perf_lazy auto_delete=false durable=true
rabbitmqadmin declare queue name=perf_ha_lazy auto_delete=false durable=true

# attempt to replicate prod
heroku config:set PREDECLARED=true QUEUE=perf_ha_lazy PRODUCER_FLAG=persistent PRODUCER_MESSAGE_SIZE=400 PRODUCER_RATE=1500 PRODUCER_THREADS=2 PRODUCER_CHANNEL_COUNT=10 CONSUMER_QOS=500 CONSUMER_THREADS=2 CONSUMER_CHANNEL_COUNT=10
```

## Monitoring

* `travis-rabbitmq-perf-test`
  * [Heroku](https://dashboard.heroku.com/apps/travis-rabbitmq-perf-test)
  * [Papertrail](https://papertrailapp.com/systems/travis-rabbitmq-perf-test/events)
* `acrobatic-reindeer.rmq.cloudamqp.com`
  * [Papertrail](https://papertrailapp.com/systems/1963154171/events)
  * [Librato](https://metrics.librato.com/s/spaces/670753?source=%2Aacrobatic-reindeer%2A)
