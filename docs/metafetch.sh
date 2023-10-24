#!/bin/sh
# metafetch.sh
# fetch rpi metadata
# release 2

FETCHER=https://github.com/
GITFETCHER=git@github.com:
BRANCH=kirkstone

erreur() { echo $* && exit 0 || kill $$; }

confirm() {

    read -p "confirm (y/n) " choix
    [ "$choix" == "y" ] && echo 0 || echo 1;
}


while getopts ":l:b:r:hg" option; do

    case $option in

        h ) erreur usage: $0 -l layerdir -b buildir -r branch -g;;
        l ) LAYER=$OPTARG;;
        b ) BUILD=$OPTARG;;
        r ) BRANCH=$OPTARG;;
        g ) FETCHER=$GITFETCHER;;
        * ) erreur minimal usage: $0 -l layerdir -b buildir;;
    esac
done

[ -n "$LAYER" ] || LAYER=$HOME/yocto_$BRANCH/layer
[ -n "$BUILD" ] || BUILD=$HOME/yocto_$BRANCH/build
[ -d $LAYER ] || mkdir -p $LAYER || erreur cannot create $LAYER
[ -d $BUILD ] || mkdir -p $BUILD || erreur cannot create $BUILD
LAYER=$(realpath $LAYER) && echo fetcher $FETCHER branch $BRANCH in $LAYER || erreur cannot find $LAYER
BUILD=$(realpath $BUILD) && echo fetcher $FETCHER configuration in $BUILD || erreur cannot find $BUILD

if [[ "$(confirm)" != 0 ]]; then
    rmdir $LAYER
    rmdir $BUILD
    erreur $0 interrupt
fi

#[ confirm ] && ( rmdir $LAYER; rmdir $BUILD; erreur stop $0 )

git clone -b $BRANCH ${FETCHER}yoctoproject/poky.git $LAYER/poky
git clone -b $BRANCH ${FETCHER}openembedded/meta-openembedded.git $LAYER/oe
git clone -b $BRANCH ${FETCHER}agherzan/meta-raspberrypi $LAYER/rpi/meta-raspberrypi
git clone ${FETCHER}kaloyanski/meta-thc.git $LAYER/thc/meta-thc
git clone ${FETCHER}TripleHelixConsulting/rpiconf.git $BUILD/conf

sed -i s#/home/yocto/layer#$LAYER#g $BUILD/conf/bblayers.conf || erreur cannot sed

OEINIT=oe-init-build-env
cd $LAYER/poky && pwd || erreur cannot find $LAYER/poky
[ -x $OEINIT ] && . ./$OEINIT $BUILD || erreur cannot find $OEINIT

bitbake-layers show-layers
# bitbake core-image-x11
