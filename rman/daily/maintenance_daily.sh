#! /bin/sh

set -e

nohup rman target / cmdfile=/backup/rman/scripts/maintenance_daily.rman log=/backup/rman/logs/maintenance_daily_$(date +%Y_%m_%d_%s).log >/dev/null 2>&1