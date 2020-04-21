docker run --rm -d ^
    --name ctp_covid ^
    -v %cd%\config.xml:/CTP/config.xml ^
    -v %cd%\config:/CTP/config ^
    -v %cd%\data:/CTP/data ^
    -p 80:80 ^
    jvsoest/ctp