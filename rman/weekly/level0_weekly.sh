#! /bin/sh

set -e

nohup rman target / cmdfile=/backup/rman/scripts/level0_weekly.rman log=/backup/rman/logs/level0_weekly_$(date +%Y_%m_%d_%s).log >/dev/null 2>&1