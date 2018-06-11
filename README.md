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
```

## Run

```
heroku run -- perftest --help
```
