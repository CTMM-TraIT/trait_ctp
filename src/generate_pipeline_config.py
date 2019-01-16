import json

#load config file
with open('pipeline_config.json') as data_file:
    config = json.load(data_file)

#check if xnat/bmia is valid
if config['archive']!= "xnat" and config['archive']!= "bmia" : 
    print("wrong archive selected, please choose xnat or nbia")
    exit()

print("you made it!")