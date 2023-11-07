#!/bin/bash
# metafetch.sh
# fetch rpi metadata

FETCHER=https://github.com/
GITFETCHER=git@github.com:
BRANCH=kirkstone
DEFMETADIR=$HOME/yocto_$BRANCH/metadata
DEFBUILDIR=$HOME/yocto_$BRANCH/rpi4

erreur() { echo $* && exit 0 || kill $$; }
usage() {    # print options and quit

    printf "
usage:
\t $0 <options>
    option        \t purpose                 \t default
    -h            \t print this              \t usage
    -d            \t dry run                 \t wet run
    -g            \t switch to git protocol  \t https protocol
    -r <branch>   \t branch                  \t $BRANCH
    -m <metadir>  \t metadata directory      \t $DEFMETADIR
    -b <buildir>  \t build directory         \t $DEFBUILDIR
"
    erreur
}

confirm() {    # get confirmation or quit

    read -p "please confirm (y/n) " choix
    [ "$choix" == "y" ] &&
        echo $1 confirm ||
            erreur $1 interrupted
}

while getopts ":m:b:r:hgd" option; do    # parce command-line options

    case $option in

        m ) METADIR=$OPTARG;;
        b ) BUILDIR=$OPTARG;;
        r ) BRANCH=$OPTARG;;
        g ) FETCHER=$GITFETCHER;;
        d ) DRYRUN=yes;;
        h ) usage $0;;
        * ) usage $0;;
    esac
done

# check system path
[ -n "$METADIR" ] || METADIR=$DEFMETADIR
[ -n "$BUILDIR" ] || BUILDIR=$DEFBUILDIR
[ -d $METADIR ] || mkdir -p $METADIR || erreur $? cannot create $METADIR
[ -d $BUILDIR ] || mkdir -p $BUILDIR || erreur $? cannot create $BUILDIR
METADIR=$(realpath $METADIR) && printf "\nmetadata:\t $METADIR\n" || erreur $? cannot find $METADIR
BUILDIR=$(realpath $BUILDIR) && printf "build:\t\t $BUILDIR\n" || erreur $? cannot find $BUILDIR
printf "branch:\t\t $BRANCH\nprotocol:\t $FETCHER\n\n"

declare -A REPO
REPO=(    # associative git repository array
    [yoctoproject/poky.git]=$METADIR/poky
    [openembedded/meta-openembedded.git]=$METADIR/oe
    [agherzan/meta-raspberrypi]=$METADIR/rpi/meta-raspberrypi
    [kaloyanski/meta-thc.git]=$METADIR/thc/meta-thc
    [TripleHelixConsulting/rpiconf.git]=$BUILDIR/conf
)

[ -n "$DRYRUN" ] || confirm $0 confirmation
for repo in ${!REPO[@]}; do    # clone repositories

    command="git clone -b $BRANCH $FETCHER$repo ${REPO[$repo]}"
    [ -n "$DRYRUN" ] || $command && echo $command
done
[ -n "$DRYRUN" ] && erreur $0 dry run exit

# adjust bibtbake layer configuration
sed -i s#/home/yocto/layer#$METADIR#g $BUILDIR/conf/bblayers.conf || erreur sed $?

# bitbake environment
OEINIT=oe-init-build-env
cd $METADIR/poky && pwd || erreur $? cannot find $METADIR/poky
[ -f $OEINIT ] && . ./$OEINIT $BUILDIR || erreur $? cannot find $OEINIT

bitbake-layers show-layers

printf "\n\t === how to start a new build === \n\n"

echo cd $METADIR/poky
echo . ./$OEINIT $BUILDIR
echo bitbake core-image-x11
echo
