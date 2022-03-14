#!/bin/bash

set -ex

pip install -U pip
pip install pip-tools

echo "creating requirements"
pip-compile

cat requirements.txt

echo "Publishing pypi package"
