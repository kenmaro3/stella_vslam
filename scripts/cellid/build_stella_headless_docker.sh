#!/bin/sh

TOPDIR="$(dirname $(realpath "$0"))"/../../ #stella_vslam directory

( 
    cd $TOPDIR

    # Building Docker Image
    docker build -t stella_vslam-desktop -f Dockerfile.desktop . --build-arg NUM_THREADS=`expr $(nproc) - 1`

    docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix:ro --volume ${TOPDIR}/stella-mb-feasibility-tools:/stella_vslam_examples/stella-mb-feasibility-tools:rw stella_vslam-desktop

)

# reference
## https://stella-cv.readthedocs.io/en/latest/installation.html#chapter-installation
## https://stella-cv.readthedocs.io/en/latest/docker.html
