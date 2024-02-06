SUMMARY = "compact image with a running imgui demo"
DESCRIPTION = "triplehelix-consulting.com"
RECIPE_MAINTAINER = "Kaloyan Krastev <kaloyan@triplehelix-consulting.com>"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

IMAGE_FSTYPES = "ext3 ext4"
IMAGE_OVERHEAD_FACTOR = "1.1"

IMAGE_FEATURES:remove = "splash"
IMAGE_FEATURES:remove = "package-management"
IMAGE_FEATURES:append = " x11-base"
IMAGE_FEATURES:append = " allow-root-login"
IMAGE_FEATURES:append = " allow-empty-password"
IMAGE_FEATURES:append = " empty-root-password"
IMAGE_FEATURES:append = " post-install-logging"
IMAGE_FEATURES:append = " ssh-server-dropbear"

IMAGE_INSTALL:append = " thcp"
IMAGE_INSTALL:append = " imgui"

IMAGE_INSTALL:append = " msmtp"
IMAGE_INSTALL:append = " ca-certificates"
IMAGE_INSTALL:append = " gnupg"
IMAGE_INSTALL:append = " gnutls"
IMAGE_INSTALL:append = " tzdata"
IMAGE_INSTALL:append = " ssh-pregen-hostkeys"

# optional packages 
IMAGE_INSTALL:append = " os-release"
IMAGE_INSTALL:append = " procps"
IMAGE_INSTALL:append = " file"
IMAGE_INSTALL:append = " zile"
IMAGE_INSTALL:append = " cpufrequtils"


# IMAGE_INSTALL:append = " picamera-libs"
IMAGE_INSTALL:append = " libcamera"
# IMAGE_INSTALL:append = " v4l-utils"
# IMAGE_INSTALL:append = " libgphoto"

# IMAGE_INSTALL:append = " run-postinsts"
# IMAGE_INSTALL:append = " openssl-bin"

inherit core-image features_check extrausers thclass

# mkpasswd -m sha256crypt <your-password>
# uncomment next two lines to have a password, in this case password is ppp
# PASSWD = "\$5\$2qQtEpyiwk33Lj5/\$KK0mV7X4Mzt15EAo56iymdLUtL9Bbv0HWe8hpUZdhm1"
# EXTRA_USERS_PARAMS = "usermod -p '${PASSWD}' root;"

REQUIRED_DISTRO_FEATURES = "x11 cpufrequtils"

