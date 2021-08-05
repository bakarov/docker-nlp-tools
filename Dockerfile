FROM ubuntu

MAINTAINER Amir Bakarov

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN apt clean && apt update

COPY packages.txt /packages.txt
RUN cat packages.txt | xargs apt install -y

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 

COPY conda-packages.txt /conda-packages.txt
RUN conda create -n py38 python=3.8
SHELL ["conda", "run", "-n", "py38", "/bin/bash", "-c"]
RUN conda install --file conda-packages.txt

EXPOSE 8888
VOLUME ["/nlp-tools", "/jupyter/certs"]
WORKDIR /nlp-tools

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "jupyter", "notebook", "--ip=0.0.0.0", "--allow-root" ]
