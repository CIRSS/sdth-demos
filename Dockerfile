ARG PARENT_IMAGE=cirss/repro-parent:latest

FROM ${PARENT_IMAGE}

COPY exports /repro/exports

ADD ${REPRO_DIST}/boot-setup /repro/dist/
RUN bash /repro/dist/boot-setup

USER repro

# install required external repro modules
RUN repro.require python-dev master ${REPROS_DEV} --default --code
RUN repro.require shell-notebook master ${REPROS_DEV}
RUN repro.require graphviz-runtime master ${REPROS_DEV} --util

RUN sudo apt install graphviz-dev -y

# use a local directory named tmp for each demo
RUN repro.env REPRO_DEMO_TMP_DIRNAME tmp

CMD  /bin/bash -il
