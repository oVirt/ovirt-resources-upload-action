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
          # SSH username for upload. Required.
          username: test
          # SSH key for upload. Required
          key: ssh-rsa ...
          # Which files to upload.
          source: testdata/*
          # Which directory to upload to. This directory must exist on the target server.
          target: /test
          # SSH hostname to upload to. Optional, defaults to resources.ovirt.org
          host: resources.ovirt.org 
          # Cleanup files on target server, keep the last few. Optional, defaults to "no".
          cleanup: yes
          # How many files to keep. Optional, defaults to 1000.
          keep_files_count: 10
```
