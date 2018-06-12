#!/bin/bash

args=()

if [[ -n $CLOUDAMQP_URL ]]; then
  args+=(--uri "$CLOUDAMQP_URL")
fi

if [[ $PREDECLARED = 'true' ]]; then
  args+=(--predeclared)
fi

if [[ $PRODUCER = 'true' ]]; then
  if [[ -n $PRODUCER_FLAG ]]; then
    args+=(--flag "$PRODUCER_FLAG")
  fi

  if [[ -n $PRODUCER_FLAG ]]; then
    args+=(--flag "$PRODUCER_FLAG")
  fi

  if [[ -n $PRODUCER_QUEUE ]]; then
    args+=(--queue "$PRODUCER_QUEUE")
  fi

  if [[ -n $PRODUCER_MESSAGE_SIZE ]]; then
    args+=(--size "$PRODUCER_MESSAGE_SIZE")
  fi

  if [[ -n $PRODUCER_RATE ]]; then
    args+=(--rate "$PRODUCER_RATE")
  fi

  if [[ -n $PRODUCER_THREADS ]]; then
    args+=(--producers "$PRODUCER_THREADS")
  fi

  if [[ -n $PRODUCER_CHANNEL_COUNT ]]; then
    args+=(--producer-channel-count "$PRODUCER_CHANNEL_COUNT")
  fi
fi

if [[ $CONSUMER = 'true' ]]; then
  if [[ -n $CONSUMER_QOS ]]; then
    args+=(--qos "$CONSUMER_QOS")
  fi

  if [[ -n $CONSUMER_THREADS ]]; then
    args+=(--consumers "$CONSUMER_THREADS")
  fi

  if [[ -n $CONSUMER_CHANNEL_COUNT ]]; then
    args+=(--consumer-channel-count "$CONSUMER_CHANNEL_COUNT")
  fi
fi

bin/runjava com.rabbitmq.perf.PerfTest "${args[@]}" $*
