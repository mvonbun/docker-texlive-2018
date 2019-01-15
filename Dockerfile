FROM ubuntu:16.04
MAINTAINER Michael Vonbun <michael.vonbun@tum.de>

ARG DEBIAN_FRONTEND=noninteractive
ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE                                   \
      org.label-schema.vcs-url="https://github.com/mvonbun/docker-texlive-2018" \
      org.label-schema.vcs-ref=$VCS_REF                                         \
      org.label-schema.schema-version="1.0"

RUN buildDeps='software-properties-common'; \
    set -x;                                 \
    apt-get update -q -y;                   \
    apt-get install -q -y --no-install-recommends $buildDeps; \
    add-apt-repository -y ppa:jonathonf/texlive-2018;         \
    apt-get update -q -y;                          \
    apt-get install -q -y --no-install-recommends  \
        build-essential                            \
        texlive                                    \
        texlive-generic-extra                      \
        texlive-lang-german                        \
        texlive-latex-extra                        \
        texlive-science                            \
        latexmk                                    \
        inkscape                                   \
        ;                                          \
    apt-get purge -y --auto-remove $buildDeps;     \
    apt-get autoremove -q -y;                      \
    apt-get clean -q -y;                           \
    rm -rf /var/lib/apt/lists/*
