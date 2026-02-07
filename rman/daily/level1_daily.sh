#! /bin/sh

set -e

nohup rman target / cmdfile=/backup/rman/scripts/level1_daily.rman log=/backup/rman/logs/level1_daily_$(date +%Y_%m_%d_%s).log >/dev/null 2>&1