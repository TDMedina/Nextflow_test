FROM nfcore/base:1.14
LABEL authors="Barry Digby" \
    description="Docker container containing fastqc"

WORKDIR ./
COPY environment.yml ./
RUN conda env create -f environment.yml && conda clean -a
ENV PATH=/opt/conda/envs/first_script_env/bin:$PATH
