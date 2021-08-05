FROM ubuntu

MAINTAINER Amir Bakarov

RUN apt clean && apt update
RUN apt install software-properties-common

COPY packages.txt /packages.txt
RUN cat packages.txt | xargs apt install -y

RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
RUN bash Anaconda3-2021.05-Linux-x86_64.sh -b -p ~/anaconda
RUN rm Anaconda3-2021.05-Linux-x86_64.sh
RUN echo 'export PATH="~/anaconda/bin:$PATH"' >> ~/.bashrc 

EXPOSE 8888
VOLUME ["/nlp-tools", "/jupyter/certs"]
WORKDIR /nlp-tools

ENTRYPOINT ["/entrypoint.sh"]
CMD [ "jupyter", "notebook", "--ip=0.0.0.0", "--allow-root" ]
