#! /bin/sh

export ORACLE_HOME=/u01/app/oracle/products/23.26.1/db_home1
export ORACLE_SID=cyandb01
export PATH=$ORACLE_HOME/bin:$PATH

readonly DATE_NOW=$(date +%Y_%m_%d_%S)
readonly BASE_DIR=/backup/rman
readonly SCRIPT_DIR=${BASE_DIR}/scripts
readonly LOG_DIR=${BASE_DIR}/scripts
readonly RMAN_FILE=${SCRIPT_DIR}/daily/maintenance.daily.rman
readonly LOG_FILE=${BASE_DIR}/logs/maintenance.daily.${DATE_NOW}.log

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
  echo "RMAN daily maintenance script finished successfully.";
  exit 0
else
  echo "RMAN daily maintenance script failed.";
  exit 1
fi