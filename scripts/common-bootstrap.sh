#!/bin/bash

set -ex

sudo apt-get update \
  && sudo apt-get install apache2 \
    --no-install-suggests \
    --no-install-recommends \
      --yes \
  && apt-get clean