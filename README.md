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

# durable queue (attempt to replicate prod)
rabbitmqadmin declare queue name=perf_durable auto_delete=false durable=true
heroku config:set PREDECLARED=true QUEUE=perf_durable PRODUCER_FLAG=persistent PRODUCER_MESSAGE_SIZE=400 PRODUCER_RATE=1500 PRODUCER_THREADS=2 PRODUCER_CHANNEL_COUNT=10 CONSUMER_QOS=500 CONSUMER_THREADS=2 CONSUMER_CHANNEL_COUNT=10
```

## Monitoring

* `travis-rabbitmq-perf-test`
  * [Heroku](https://dashboard.heroku.com/apps/travis-rabbitmq-perf-test)
  * [Papertrail](https://papertrailapp.com/systems/travis-rabbitmq-perf-test/events)
* `acrobatic-reindeer.rmq.cloudamqp.com`
  * [Papertrail](https://papertrailapp.com/systems/1963154171/events)
  * [Librato](https://metrics.librato.com/s/spaces/670753?source=%2Aacrobatic-reindeer%2A)
