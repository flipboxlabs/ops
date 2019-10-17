# flipbox/ops - An Alpine based Docker image for operational tasks with built-in AWS hooks

## Environmental Variables
### `AWS_PARAMETER_PATH`
Set the prefix for items (SecureString only) stored in the [AWS SSM Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html). The values will be pulled into the container (at runtime), loading them as environmental variables.

#### Example
Suppose you have a group of SecureString parameters stored in `/MyApp/StagingEnv/`. Some inlude the following:
- `/MyApp/StagingEnv/DB_PASSWORD`
- `/MyApp/StagingEnv/DB_USERNAME`

You can set the path: `AWS_PARAMETER_PATH=/MyApp/StagingEnv/`

You can then access those parameters via environmental variables:
```bash
echo $DB_PASSWORD
```

### `S3_SYNC_PREFIX_SRC`
Supply a s3 path for syning down to the container.

#### Example
`S3_SYNC_PREFIX_SRC=s3://my-bucket/prefix-with-files/`

This will result in running the following command at startup:
```bash
aws s3 sync $S3_SYNC_PREFIX_SRC $S3_SYNC_DST
```

### `S3_SYNC_FILE_SRC`
Supply a s3 file path for copying down to the container.

#### Example
`S3_SYNC_PREFIX_SRC=s3://my-bucket/prefix-with-files/my-file.txt`

This will result in running the following command at startup:
```bash
aws s3 cp $S3_SYNC_FILE_SRC $S3_SYNC_DST
```

### `S3_SYNC_DST`
Supply a destination path for this s3 files.

#### Example
`S3_SYNC_DST=/usr/local/bin/`

## Other Features

### Running Shell Scripts on Startup (`/flipbox.d/`)
Files found in `/flipbox.d/` with a `.sh` extension will be run at startup (using `bash my-script.sh`)
