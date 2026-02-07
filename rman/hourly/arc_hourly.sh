#! /bin/sh

set -e

nohup rman target / cmdfile=/backup/rman/scripts/arc_hourly.rman log=/backup/rman/logs/arc_hourly_$(date +%Y_%m_%d_%s).log >/dev/null 2>&1