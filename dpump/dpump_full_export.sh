#! /bin/sh
#
# A script that exports the PDB that is in a CDB using Data Pump
# It is used to migrate the data from/to a database.
# 
# Ensure you have created a sufficient data pump user and created a directory
# for the data pump export and granted it to the user.

set -e

export ORACLE_HOME=/u01/app/oracle/products/23.26.1/db_home1
export ORACLE_SID=cyandb01
export PATH=$ORACLE_HOME/bin:$PATH

DPUMP_USER=""
DPUMP_PASS=""
PDB_NAME=""
BASE_DIR=/backup/dpump/dump
DATE_NOW=$(date +%Y_%m_%d)
LOGFILE_NAME="FULL_${PDB_NAME}_${DATE_NOW}.log"
DUMPFILE_NAME="FULL_${PDB_NAME}_${DATE_NOW}_%U.dmp"
DATAPUMP_DIR="DATAPUMP_DIR"
PARALLEL_COUNT=8

if [ -f "${BASE_DIR}/FULL_${PDB_NAME}_${DATE_NOW}_01.dmp" ]; then
        echo "Dump file for today already exists"
        exit 1
fi

echo "Starting data dump export job $(date)"

expdp ${DPUMP_USER}/${DPUMP_PASS}@${PDB_NAME} \
        FULL=Y \
        DIRECTORY=${DATAPUMP_DIR} \
        DUMPFILE=${DUMPFILE_NAME} \
        LOGFILE=${LOGFILE_NAME} \
        PARALLEL=${PARALLEL_COUNT}
        COMPRESSION=ALL

echo "Data pump export finished at $(date)"
echo "To view the exported data, check ${BASE_DIR}"