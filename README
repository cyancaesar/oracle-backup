# Oracle backup scripts

Scripts I created for assisting of Oracle Database backup and recovery. It covers both RMAN and Data Pump.

RMAN scripts are segragated, each does it tasks as their name implies.

## Shared directories

Ensure the following directories exists on the shared directory:

```sh
mkdir -p /backup/rman
mkdir -p /backup/rman/level0
mkdir -p /backup/rman/level1
mkdir -p /backup/rman/archivelog
mkdir -p /backup/rman/controlfile
mkdir -p /backup/rman/scripts
mkdir -p /backup/rman/logs
mkdir -p /backup/dpump
mkdir -p /backup/dpump/scripts
mkdir -p /backup/dpump/logs
mkdir -p /backup/dpump/dump
```

## Mount NFS

Ensure you mount the backup directory with these options:

```sh
mount -t nfs4 -o rw,bg,hard,nointr,tcp,noatime,nodiratime,rsize=1048576,wsize=1048576 <NFS_IP>:/backup /backup
```

## Setup RMAN persistant configuration

You have to configure RMAN with a persistent configuration in order to run the scripts effectively.

Enter RMAN:

```sh
rman target /
```

Configure the default device:

```sh
CONFIGURE DEFAULT DEVICE TYPE TO DISK;
```

Configure backup type and set it to compressed:

```sh
CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET;
```

Configure parallelism:

```sh
CONFIGURE DEVICE TYPE DISK PARALLELISM 6;
```

Configure a default location for the backup, note that it won't be used for the actual backup, it's just the last resort:

```sh
CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/backup/rman/misc/%U.bkp';
```

Configure auto backup for control file, it's on by default, just to make sure:

```sh
CONFIGURE CONTROLFILE AUTOBACKUP ON;
```

Configure the location for the auto backup:

```sh
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/backup/rman/controlfile/cf_%F';
```

Configure the retention policy:

```sh
CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF 30 DAYS;
```

- The parameter `CONTROL_FILE_RECORD_KEEP_TIME` must be greater than or equal to the recovery window.

Now all the RMAN run block will use these persistent configuration unless overridden.
