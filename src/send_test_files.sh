#!/bin/bash
#
#configuration (required: https://stedolan.github.io/jq/download/)
config_file="pipeline_config.json"
dicomport="$( jq -r '.dicomport' "$config_file" )"
#
# send 10 files to test the pipeline
# offis dcmtk required! https://dicom.offis.de/dcmtk.php.en
for i in {1..10}
do
dcmodify -nb -gin "orig.dcm"
storescu -v localhost $dicomport "orig.dcm"
done