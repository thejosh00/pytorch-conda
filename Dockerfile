FROM paperspace/gradient-base:pt112-tf29-jax0317-py39-20230125

# Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /notebooks/conda/bin:$PATH

# Install Miniconda and cleanup installation files
RUN apt-get update --fix-missing && \
    apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion && \
    echo 'export PATH=/notebooks/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /notebooks/conda && \
    rm ~/miniconda.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    conda clean -tipsy && \
    conda create --yes -n textgen python=3.10.9 && \
    echo ". /notebooks/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate textgen" >> ~/.bashrc

# Update conda and install any additional packages if needed
RUN conda update conda && \
    conda clean -tipsy

CMD ["bash", "-c", "source activate textgen && exec jupyter lab --allow-root --ip=0.0.0.0 --no-browser --ServerApp.trust_xheaders=True --ServerApp.disable_check_xsrf=False --ServerApp.allow_remote_access=True --ServerApp.allow_origin='*' --ServerApp.allow_credentials=True"]
