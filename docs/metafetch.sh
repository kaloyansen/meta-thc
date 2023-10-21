#!/usr/bin/env sh
# metafetch.sh
# fetch rpi metadata branch

BRANCH=kirkstone

while getopts ":l:b:h" option; do
   case $option in
      h) echo usage $0 -l layerdir -b buildir; exit 420;;
     \?) echo usage $0 -l layerdir -b buildir; exit 420;;
      l) LAYER=$OPTARG;;
      b) BUILD=$OPTARG;;
   esac
done

nodat() { echo $1; exit 111; }
nodir() {
    echo error: $1 is not a directory && mkdir $1 &&
        echo info: directory $1 created ||
            exit 111;
}

[ -n "$LAYER" ] || nodat 'specify layer directory'
[ -n "$BUILD" ] || nodat 'specify build directory'
[ -d $LAYER ] || nodir $LAYER
[ -d $BUILD ] || nodir $BUILD

LAYER=$(realpath $LAYER) && echo fetching $BRANCH in $LAYER
BUILD=$(realpath $BUILD) && echo fetching configuration in $BUILD

git clone -b $BRANCH git@github.com:yoctoproject/poky.git $LAYER/poky
git clone -b $BRANCH git@github.com:openembedded/meta-openembedded.git $LAYER/oe
git clone -b $BRANCH git@github.com:agherzan/meta-raspberrypi $LAYER/rpi/meta-raspberrypi
git clone git@github.com:kaloyanski/meta-thc.git $LAYER/thc/meta-thc
git clone git@github.com:TripleHelixConsulting/rpiconf.git $BUILD/conf

sed -i s#/home/yocto/layer#$LAYER#g $BUILD/conf/bblayers.conf
source $LAYER/poky/oe-init-build-env $BUILD
bitbake-layers show-layers
# bitbake core-image-x11

exit 0
