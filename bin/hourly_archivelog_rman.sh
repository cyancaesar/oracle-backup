#! /bin/sh
#
# Script Name: hourly_archivelog_rman.sh
# Description: Executes an Oracle RMAN Hourly Archivelog backup.
# Backup Type: RMAN Archivelog Backup (Hourly)
# Author: Abdulaziz (cyancaesar)
# Date: 2026-02-09
#

export ORACLE_HOME=/u01/app/oracle/products/23.26.1/db_home1
export ORACLE_SID=cyandb01
export PATH=$ORACLE_HOME/bin:$PATH

readonly DATE_NOW=$(date +%Y_%m_%d_%S)
readonly BASE_DIR=/backup/rman
readonly SCRIPT_DIR=${BASE_DIR}/scripts
readonly LOG_DIR=${BASE_DIR}/scripts
readonly RMAN_FILE=${SCRIPT_DIR}/hourly/arc.hourly.rman
readonly LOG_FILE=${BASE_DIR}/logs/arc.hourly.${DATE_NOW}.log

# Check if the user is in dba group
id -nG $USER | grep -q dba
if [ $? -ne 0 ]; then
  echo "The user $USER must be in dba group"
  exit 1
fi

# Check if the RMAN file exists
if [ ! -f ${RMAN_FILE} ]; then
  echo "The RMAN file ${RMAN_FILE} does not exists!"
  exit 1
fi

# Running RMAN
rman target / \
  cmdfile=${RMAN_FILE} \
  log=${LOG_FILE}
  
if [ $? -eq 0 ]; then
  echo "RMAN hourly archivelog backup script finished successfully.";
  exit 0
else
  echo "RMAN hourly archivelog backup script failed.";
  exit 1
fi