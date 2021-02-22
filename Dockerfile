ARG IMAGE=store/intersystems/irishealth-community:2020.3.0.221.0

FROM ${IMAGE}

USER root
ENV SRC_DIR=/home/irisowner/src

COPY --chown=irisowner init/ ${SRC_DIR}/
RUN ${SRC_DIR}/root.sh

USER irisowner
RUN ${SRC_DIR}/iris.sh

HEALTHCHECK --interval=5s CMD /irisHealth.sh || exit 1
