#!/bin/sh -e
set -x

pipenv run ruff --fix .
pipenv run black .
pipenv run mypy -p app
