#!/usr/bin/env bash

set -e
set -x

mkdir -p tmp

# cenos
source ../centos/base.sh

# ubuntu
source ../ubuntu/base.sh

# es
source ./es/deploy.sh
source ./es.a6/deploy.sh

# ai
source ./ai/deploy.sh
