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
heroku addons:upgrade cloudamqp:rabbit # larger plan needed for HA
heroku addons:open CLOUDAMQP
ruby generate-rabbitmqadmin-conf.rb
```

## Run

```
heroku run -- perftest --help

# default settings
heroku run -- perftest

# durable queue
rabbitmqadmin declare queue name=perf_durable auto_delete=false durable=true
heroku run -- perftest --flag persistent --predeclared --queue perf_durable
```

## Monitoring

* `travis-rabbitmq-perf-test`
  * [Heroku](https://dashboard.heroku.com/apps/travis-rabbitmq-perf-test)
  * [Papertrail](https://papertrailapp.com/systems/travis-rabbitmq-perf-test/events)
* `acrobatic-reindeer.rmq.cloudamqp.com`
  * [Papertrail](https://papertrailapp.com/systems/1963154171/events)
  * [Librato](https://metrics.librato.com/s/spaces/670753?source=%2Aacrobatic-reindeer%2A)
