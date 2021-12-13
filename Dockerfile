FROM nfcore/base:1.14
LABEL authors="Barry Digby" \
    description="Zhao et al Dockerfile"

RUN apt-get update; apt-get clean all;

RUN apt-get install --yes build-essential \
    gcc-multilib \
    tar \
    unzip \
    ncurses-base \
    zlib1g \
    liblzma5 \
    libbz2-1.0 \
    gcc \
    g++ \
    zlib1g-dev

RUN mkdir -p /usr/src/scratch
WORKDIR /usr/src/scratch

# Install RSEM
RUN wget https://github.com/deweylab/RSEM/archive/refs/tags/v1.3.3.tar.gz \
    && tar -xzvf RSEM-1.3.3.tar.gz \
    && cd RSEM-1.3.3 \
    && make \
    && make install \
    && cd -

# Install CNCI
RUN wget https://github.com/BarryDigby/CNCI/releases/download/v2.0.0/CNCI_v2.0.0.tar.gz \
    && tar -xzvf CNCI_v2.0.0.tar.gz
RUN chmod -R 777 CNCI/
ENV PATH=/usr/src/scratch/CNCI/:$PATH

# Install BLAST
RUN wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.12.0+-x64-linux.tar.gz \
    && tar -xzvf ncbi-blast-2.12.0+-x64-linux.tar.gz
ENV PATH=/usr/src/scratch/ncbi-blast-2.12.0+/bin:$PATH


WORKDIR ./
COPY environment.yml ./
RUN conda env create -f environment.yml && conda clean -a
ENV PATH /opt/conda/envs/test_env/bin:/usr/local/go/bin:/home/tyler/anaconda3/envs/test_env/bin:/home/tyler/anaconda3/condabin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:~/.bin:~/.bin:/home/tyler/go/bin

