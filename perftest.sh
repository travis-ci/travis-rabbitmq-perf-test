#!/bin/bash

args=()

if [[ -n $CLOUDAMQP_URL ]]; then
  args+=(--uri "$CLOUDAMQP_URL")
fi

bin/runjava com.rabbitmq.perf.PerfTest "${args[@]}" $*
