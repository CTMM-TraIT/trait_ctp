#!/bin/bash
#
#configuration (required: https://stedolan.github.io/jq/download/)
config_file="pipeline_config.json"
name="$( jq -r '.name' "$config_file" )"
site="$( jq -r '.site' "$config_file" )"
uid="$( jq -r '.uid' "$config_file" )"
webport="$( jq -r '.webport' "$config_file" )"
dicomport="$( jq -r '.dicomport' "$config_file" )"
#
#create UPPPER_CASE variables
name_upper=`echo "$name" | tr '[:lower:]'` 
site_upper=`echo "$site" | tr '[:lower:]'` 
#
#create folders to store config
if ! [ -d "../site_configurations/$name_upper" ]
then
	mkdir "../site_configurations/$name_upper"
fi
#
if ! [ -d "../site_configurations/$name_upper/$site_upper" ]
then
    mkdir "../site_configurations/$name_upper/$site_upper"
    mkdir "../site_configurations/$name_upper/$site_upper/ctpConfig"
    mkdir "../site_configurations/$name_upper/$site_upper/ctpConfig/$name_upper"
    mkdir "../site_configurations/$name_upper/$site_upper/ctpConfig/$name_upper/$site_upper"
else
    echo "$name_upper/$site_upper config exists, cannot overwrite existing config"
    exit
fi 
#
#copy template files to new project
config_xml="../site_configurations/$name_upper/$site_upper/config.xml"
anonymizer_xml="../site_configurations/$name_upper/$site_upper/ctpConfig/$name_upper/$site_upper/anonymizer.properties"
anonymizerXnat_xml="../site_configurations/$name_upper/$site_upper/ctpConfig/$name_upper/$site_upper/anonymizerXnat.properties"
#
cp "./template/config.xml" $config_xml
cp "./template/anonymizer.properties" $anonymizer_xml
cp "./template/anonymizerXnat.properties" $anonymizerXnat_xml
cp "./template/filter.script" "../site_configurations/$name_upper/$site_upper/ctpConfig/$name_upper/$site_upper/filter.script"
cp "./template/lookup.properties" "../site_configurations/$name_upper/$site_upper/ctpConfig/$name_upper/$site_upper/lookup.properties"
#
#update template files
sed -i -e 's/${name}/'"$name_upper"'/g' $config_xml
sed -i -e 's/${site}/'"$site_upper"'/g' $config_xml
sed -i -e 's/${webport}/'"$webport"'/g' $config_xml
sed -i -e 's/${dicomport}/'"$dicomport"'/g' $config_xml
#rm "$config_xml-e"
#
sed -i -e 's/${name}/'"$name_upper"'/g' $anonymizer_xml
sed -i -e 's/${site}/'"$site_upper"'/g' $anonymizer_xml
sed -i -e 's/${uid}/'"$uid"'/g' $anonymizer_xml
#rm "$anonymizer_xml-e"
#
sed -i -e 's/${name}/'"$name"'/g' $anonymizerXnat_xml
sed -i -e 's/${site}/'"$site"'/g' $anonymizerXnat_xml
#rm "$anonymizerXnat_xml-e"
#
echo "ctp config generation done"