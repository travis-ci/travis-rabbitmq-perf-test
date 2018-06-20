#!/bin/bash

args=()

if [[ -n $CLOUDAMQP_URL ]]; then
  args+=(--uri "$CLOUDAMQP_URL")
fi

if [[ $PRODUCER = 'true' ]] || [[ $CONSUMER = 'true' ]]; then
  if [[ $PREDECLARED = 'true' ]]; then
    args+=(--predeclared)
  fi

  if [[ -n $QUEUE ]]; then
    args+=(--queue "$QUEUE")
  fi

  if [[ -n $EXCHANGE ]]; then
    args+=(--exchange "$EXCHANGE")
  fi

  if [[ $SKIP_BINDING_QUEUES = 'true' ]]; then
    args+=(--skip-binding-queues)
  fi
fi

if [[ $PRODUCER = 'true' ]]; then
  args+=(--consumers 0)

  if [[ -n $PRODUCER_FLAG ]]; then
    args+=(--flag "$PRODUCER_FLAG")
  fi

  if [[ -n $PRODUCER_FLAG ]]; then
    args+=(--flag "$PRODUCER_FLAG")
  fi

  if [[ -n $PRODUCER_MESSAGE_SIZE ]]; then
    args+=(--size "$PRODUCER_MESSAGE_SIZE")
  fi

  if [[ -n $PRODUCER_RATE ]]; then
    args+=(--rate "$PRODUCER_RATE")
  fi

  if [[ $PRODUCER_RANDOM_ROUTING_KEY = 'true' ]]; then
    args+=(--random-routing-key)
  fi

  if [[ -n $PRODUCER_THREADS ]]; then
    args+=(--producers "$PRODUCER_THREADS")
  fi

  if [[ -n $PRODUCER_CHANNEL_COUNT ]]; then
    args+=(--producer-channel-count "$PRODUCER_CHANNEL_COUNT")
  fi
fi

if [[ $CONSUMER = 'true' ]]; then
  args+=(--producers 0)

  if [[ -n $CONSUMER_QOS ]]; then
    args+=(--qos "$CONSUMER_QOS")
  fi

  if [[ -n $CONSUMER_MULTI_ACK_EVERY ]]; then
    args+=(--multi-ack-every "$CONSUMER_MULTI_ACK_EVERY")
  fi

  if [[ -n $CONSUMER_THREADS ]]; then
    args+=(--consumers "$CONSUMER_THREADS")
  fi

  if [[ -n $CONSUMER_CHANNEL_COUNT ]]; then
    args+=(--consumer-channel-count "$CONSUMER_CHANNEL_COUNT")
  fi
fi

exec bin/runjava com.rabbitmq.perf.PerfTest "${args[@]}" $*
