SUMMARY = "Dear ImGUI demo"
DESCRIPTION = "triplehelix-consulting.com"
RECIPE_MAINTAINER = "Kaloyan Krastev <kaloyan@triplehelix-consulting.com>"
LICENSE = "MIT"

IMAGE_FEATURES:append = " x11-base"
IMAGE_FEATURES:remove = "splash"
IMAGE_FEATURES:remove = "package-management"

inherit core-image features_check

REQUIRED_DISTRO_FEATURES = "x11"

QB_MEM = '${@bb.utils.contains("DISTRO_FEATURES", "opengl", "-m 512", "-m 256", d)}'


