FROM ubuntu:19.04

ADD requirements.txt /opt/requirements.txt
RUN apt-get update
RUN apt-get install -y python3 python3-dev python3-pip libglib2.0-dev qt5-default wget && \
    pip3 install -r /opt/requirements.txt

RUN wget https://github.com/MiniZinc/MiniZincIDE/releases/download/2.3.2/MiniZincIDE-2.3.2-bundle-linux-x86_64.tgz && \
    tar -xzvf MiniZincIDE-2.3.2-bundle-linux-x86_64.tgz && \
    mv /MiniZincIDE-2.3.2-bundle-linux/bin/* /usr/local/bin/ && \
    mv /MiniZincIDE-2.3.2-bundle-linux/share/minizinc/ /usr/local/share/ && \
    mv /MiniZincIDE-2.3.2-bundle-linux/lib/* /usr/local/lib/
RUN wget https://github.com/google/or-tools/releases/download/v7.3/or-tools_flatzinc_ubuntu-19.04_v7.3.7083.tar.gz && \
    tar -xzvf or-tools_flatzinc_ubuntu-19.04_v7.3.7083.tar.gz && \
    mv or-tools_flatzinc_Ubuntu-19.04-64bit_v7.3.7083/bin/* /usr/local/bin && \
    mkdir -p /usr/local/share/or-tools/ && \
    mv /or-tools_flatzinc_Ubuntu-19.04-64bit_v7.3.7083/share/minizinc* /usr/local/share/or-tools/ && \
    mv /or-tools_flatzinc_Ubuntu-19.04-64bit_v7.3.7083/lib/* /usr/local/lib/

ADD ortools.msc /usr/local/share/minizinc/solvers/ortools.msc