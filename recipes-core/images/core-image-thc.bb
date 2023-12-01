SUMMARY = "Dear ImGUI demo"
DESCRIPTION = "triplehelix-consulting.com"
RECIPE_MAINTAINER = "Kaloyan Krastev <kaloyan@triplehelix-consulting.com>"

LICENSE = "MIT"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

IMAGE_FEATURES:remove = "splash"
IMAGE_FEATURES:remove = "package-management"
IMAGE_FEATURES:append = " x11-base"
IMAGE_FEATURES:append = " allow-root-login"
IMAGE_FEATURES:append = " allow-empty-password"
IMAGE_FEATURES:append = " empty-root-password"
IMAGE_FEATURES:append = " post-install-logging"

VOLATILE_LOG_DIR = "no"

IMAGE_INSTALL:append = " thcp"
IMAGE_INSTALL:append = " imgui"

inherit core-image features_check

REQUIRED_DISTRO_FEATURES = "x11"

