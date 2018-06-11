#!/bin/bash

set -e
set -o pipefail

PERF_TEST_VERSION=2.1.2

wget -q "https://github.com/rabbitmq/rabbitmq-perf-test/releases/download/v${PERF_TEST_VERSION}/rabbitmq-perf-test-${PERF_TEST_VERSION}-bin.tar.gz"
tar --strip-components=1 -xf rabbitmq-perf-test-$PERF_TEST_VERSION-bin.tar.gz
rm rabbitmq-perf-test-$PERF_TEST_VERSION-bin.tar.gz
