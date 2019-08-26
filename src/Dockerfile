FROM python:3

RUN apt update && apt install -y jq git zip

RUN git clone https://github.com/CTMM-TraIT/trait_ctp.git

RUN pip install flask

WORKDIR /trait_ctp/src
EXPOSE 5000
CMD ["python", "runServer.py"]