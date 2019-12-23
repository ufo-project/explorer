#!/bin/bash
# must add -B or beat to support celery beat crontab
celery worker -A blockex -E -B
