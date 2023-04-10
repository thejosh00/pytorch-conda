FROM paperspace/gradient-base:pt112-tf29-jax0317-py39-20230125

RUN apt-get update && \
    apt-get install git-lfs

RUN echo "# >>> conda initialize >>>" > /etc/profile.d/conda.sh && \
    echo "# !! Contents within this block are managed by 'conda init' !!" >> /etc/profile.d/conda.sh && \
    echo "__conda_setup=\"\$('/notebooks/conda/bin/conda' 'shell.posix' 'hook' 2> /dev/null)\"" >> /etc/profile.d/conda.sh && \
    echo "if [ \$? -eq 0 ]; then" >> /etc/profile.d/conda.sh && \
    echo "    eval \"\$__conda_setup\"" >> /etc/profile.d/conda.sh && \
    echo "else" >> /etc/profile.d/conda.sh && \
    echo "    if [ -f \"/notebooks/conda/etc/profile.d/conda.sh\" ]; then" >> /etc/profile.d/conda.sh && \
    echo "        . \"/notebooks/conda/etc/profile.d/conda.sh\"" >> /etc/profile.d/conda.sh && \
    echo "    else" >> /etc/profile.d/conda.sh && \
    echo "        export PATH=\"/notebooks/conda/bin:\$PATH\"" >> /etc/profile.d/conda.sh && \
    echo "    fi" >> /etc/profile.d/conda.sh && \
    echo "fi" >> /etc/profile.d/conda.sh && \
    echo "unset __conda_setup" >> /etc/profile.d/conda.sh && \
    echo "# <<< conda initialize <<<" >> /etc/profile.d/conda.sh

CMD ["bash", "-c", "source activate && exec jupyter lab --allow-root --ip=0.0.0.0 --no-browser --ServerApp.trust_xheaders=True --ServerApp.disable_check_xsrf=False --ServerApp.allow_remote_access=True --ServerApp.allow_origin='*' --ServerApp.allow_credentials=True"]





