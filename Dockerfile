FROM nfcore/base:1.14
LABEL authors="Barry Digby" \
    description="Docker container containing fastqc"

WORKDIR ./
COPY environment.yml ./
RUN conda env create -f environment.yml && conda clean -a
ENV PATH /opt/conda/envs/test_env/bin:/usr/local/go/bin:/home/tyler/anaconda3/envs/test_env/bin:/home/tyler/anaconda3/condabin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:~/.bin:~/.bin:/home/tyler/go/bin
