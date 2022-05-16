# oVirt Resources Upload Action

This action uploads artifacts to the `resources.ovirt.org` server.

## Usage

In your GitHub Actions workflow add the following:

```yaml
name: Add name here 
on:
  # Add triggers here
jobs:
  some-job:
    name: Some job
    runs-on: ubuntu-latest
    steps:
      # Add other steps to create artifacts before the step below.
      - name: Upload artifacts
        uses: ovirt/ovirt-resources-upload-action@main
        with:
          # Add known_hosts file here. Required.
          known_hosts: ...
          # SSH username for upload. Required.
          username: test
          # Base64-encoded SSH key for upload. Required
          key: put-key-here
          # Which files to upload.
          source: testdata/*
          # Which directory to upload to. This directory must exist on the target server.
          target: /test
          # SSH hostname to upload to. Optional, defaults to resources.ovirt.org
          host: resources.ovirt.org 
          # Delete the file(s) before uploading file(s) with the same name(s). Useful in case we hard-link the uploaded files.
          delete_before_upload: no
          # Cleanup files on target server, keep the last few. Optional, defaults to "no".
          cleanup: yes
          # How many files to keep. Optional, defaults to 1000.
          keep_files_count: 10
```

## A note on cleanup

The cleanup process deletes all but the last X files from the target server based on the *modification date*. However, the modification date is preserved during upload, so the deletion process may yield unexpected results. If you are uploading older files make sure to `touch` them before upload!


## A note on delete_before_upload

This option is useful when we hard-link the uploaded files i.e. to save disk space, and don't want the upload of the file with the exisiting file name to push changes to all the hard-linked files. Setting delete_before_upload to yes will attempt to delete file before uploading it, effectively implementing a Copy-On-Write approach in this case.
