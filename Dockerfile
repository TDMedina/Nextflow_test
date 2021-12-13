FROM nfcore/base:1.14
LABEL authors="Barry Digby" \
    description="Docker container containing fastqc"

WORKDIR ./
COPY environment.yml ./
RUN conda env create -f environment.yml && conda clean -a
ENV PATH /opt/conda/envs/test_env/bin:/usr/local/go/bin:/home/tyler/anaconda3/envs/test_env/bin:/home/tyler/anaconda3/condabin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:~/.bin:~/.bin:/home/tyler/go/bin

RUN mkdir -p /usr/src/scratch
WORKDIR /usr/src/scratch
RUN wget https://github.com/BenLangmead/bowtie2/releases/download/v2.4.4/bowtie2-2.4.4-linux-x86_64.zip
RUN unzip bowtie2-2.4.4-linux-x86_64.zip
ENV PATH=/usr/src/scratch/bowtie2-2.4.4-linux-x86_64/:$PATH
