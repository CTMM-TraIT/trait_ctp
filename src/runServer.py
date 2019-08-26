from flask import Flask, Response, request, render_template, send_file
import subprocess
import json

app = Flask('CTP Pipeline Generator')

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/', methods=["POST"])
def searchResult():
    commandLine = "rm -f CTP_*.zip"
    p = subprocess.Popen(commandLine, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    out, err = p.communicate()
    log = out.decode("utf-8")  + "\r\n" + err.decode("utf-8")
    print(log)

    settings = {
        "name": "test_name",
        "site": "test_site",
        "uid": "1.1.1.9999",
        "webport": "8080",
        "dicomport": "104"
    }

    # set config parameters from request form
    settings["name"] = request.form["projectName"]
    settings["site"] = request.form["siteName"]
    settings["uid"] = request.form["projectRootUID"]

    # write config to file
    fileHandler = open("pipeline_config.json", "w")
    json.dump(settings, fileHandler)
    fileHandler.close()

    commandLine = "sh generate_pipeline.sh"
    p = subprocess.Popen(commandLine, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    out, err = p.communicate()
    log = out.decode("utf-8")  + "\r\n" + err.decode("utf-8")
    print(log)

    commandLine = "sh clean_ctp.sh"
    p = subprocess.Popen(commandLine, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    out, err = p.communicate()
    log = out.decode("utf-8")  + "\r\n" + err.decode("utf-8")
    print(log)

    fileNameCtpZip = "CTP_" + settings["name"].upper() + "_" + settings["site"].upper() + ".zip"
    return send_file(fileNameCtpZip, as_attachment=True, attachment_filename=fileNameCtpZip)


app.run(debug=True, host='0.0.0.0', port=5000)