#!/usr/bin/busybox sh
# metafetch.sh
# fetch rpi metadata

FETCHER=git@github.com
BRANCH=kirkstone

while getopts ":l:b:r:h" option; do
   case $option in
      h) echo usage: $0 -l layerdir -b buildir -r branch; exit 420;;
     \?) echo minimal usage: $0 -l layerdir -b buildir; exit 420;;
      l) LAYER=$OPTARG;;
      b) BUILD=$OPTARG;;
      r) BRANCH=$OPTARG;;
   esac
done

nodat() { echo $*; exit 111; }
nodir() {
    echo error: $1 is not a directory && mkdir $1 &&
        echo info: directory $1 created ||
            exit 111;
}

[ -n "$LAYER" ] || nodat specify layer directory
[ -n "$BUILD" ] || nodat specify build directory
[ -d $LAYER ] || nodir $LAYER
[ -d $BUILD ] || nodir $BUILD

LAYER=$(realpath $LAYER) && echo $FETCHER $BRANCH in $LAYER
BUILD=$(realpath $BUILD) && echo $FETCHER configuration in $BUILD

read -p "confirm (y/n) " choice
case "$choice" in
    y ) echo $FETCHER;;
    * ) echo refused; rmdir -v $LAYER $BUILD; exit 0;;
esac

git clone -b $BRANCH $FETCHER:yoctoproject/poky.git $LAYER/poky
git clone -b $BRANCH $FETCHER:openembedded/meta-openembedded.git $LAYER/oe
git clone -b $BRANCH $FETCHER:agherzan/meta-raspberrypi $LAYER/rpi/meta-raspberrypi
git clone $FETCHER:kaloyanski/meta-thc.git $LAYER/thc/meta-thc
git clone $FETCHER:TripleHelixConsulting/rpiconf.git $BUILD/conf

sed -i s#/home/yocto/layer#$LAYER#g $BUILD/conf/bblayers.conf
source $LAYER/poky/oe-init-build-env $BUILD

bitbake-layers show-layers
# bitbake core-image-x11

exit 0
