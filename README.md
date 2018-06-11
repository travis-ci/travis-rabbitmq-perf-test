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
heroku addons:upgrade cloudamqp:rabbit
heroku addons:open CLOUDAMQP
```

## Run

```
heroku run -- perftest --help
```

## Monitoring

* `travis-rabbitmq-perf-test`
  * [Heroku](https://dashboard.heroku.com/apps/travis-rabbitmq-perf-test)
  * [Papertrail](https://papertrailapp.com/systems/travis-rabbitmq-perf-test/events)
* `acrobatic-reindeer.rmq.cloudamqp.com`
  * [Papertrail](https://papertrailapp.com/systems/1963154171/events)
  * [Librato](https://metrics.librato.com/s/spaces/670753?source=%2Aacrobatic-reindeer%2A)
