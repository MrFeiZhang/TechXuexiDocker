FROM python:3.7-slim

RUN apt-get update
RUN apt-get install -y wget unzip libzbar0
RUN wget -O dev.zip https://github.com/MrFeiZhang/TechXueXi/archive/refs/heads/dev.zip; mkdir xuexi;unzip dev.zip;cp -r ./TechXueXi-dev/SourcePackages/* /xuexi; cp ./TechXueXi-dev/requirements.txt /xuexi
# RUN rm -f /xuexi/config/*; ls -la
COPY start.sh /xuexi
RUN chmod +x /xuexi/start.sh
RUN pip install -r /xuexi/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN cd /xuexi/; wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_92.0.4515.159-1_amd64.deb; dpkg -i google-chrome-stable_92.0.4515.159-1_amd64.deb; apt-get -fy install; google-chrome --version; rm -f google-chrome-stable_92.0.4515.159-1_amd64.deb
RUN cd /xuexi/; wget -O chromedriver_linux64_92.0.4515.107.zip http://npm.taobao.org/mirrors/chromedriver/92.0.4515.107/chromedriver_linux64.zip; unzip chromedriver_linux64_92.0.4515.107.zip; chmod 755 chromedriver; ls -la; ./chromedriver --version
ENV AccessToken=
ENV Secret=
WORKDIR /xuexi
ENTRYPOINT ["./start.sh"]
