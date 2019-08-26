#!/bin/bash
#
CTP_SOURCE="../currentClient/installed"
CTP_FOLDER="./CTP"
#
#configuration (required: https://stedolan.github.io/jq/download/)
config_file="pipeline_config.json"
name="$( jq -r '.name' "$config_file" )"
site="$( jq -r '.site' "$config_file" )"
name_upper=`echo "$name" | tr '[:lower:]'` 
site_upper=`echo "$site" | tr '[:lower:]'` 
CONFIG_FOLDER="../site_configurations/$name_upper/$site_upper"
#
# delete config and data folder
rm -rf "$CTP_FOLDER"
cp -R $CTP_SOURCE $CTP_FOLDER
rm "$CTP_FOLDER/config.xml"
#
# copy config folders
cp "$CONFIG_FOLDER/config.xml" "$CTP_FOLDER/config.xml"
cp -R "$CONFIG_FOLDER/ctpConfig/" "$CTP_FOLDER/ctpConfig"
rm "$CTP_FOLDER/ctpConfig/$name_upper/$site_upper/lookup.properties"
#
#  create a zip of the CTP
zip -r "CTP_${name_upper}_${site_upper}.zip" "$CTP_FOLDER"