SUMMARY = "dear imgui recipe"
DESCRIPTION = "recipe for building an imgui example"
RECIPE_MAINTAINER = "Kaloyan Krastev <kaloyan@triplehelix-consulting.com>"
HOMEPAGE = "https://triplehelix-consulting.com"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

#INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
#INHIBIT_PACKAGE_STRIP = "1"

IMREPO ?= "kaloyanski"
IMREPO ?= "ocornut"
IMBIN  ?= "example_glfw_opengl2"
IMBIN  ?= "example_glfw_opengl3"

PV .= "+git${SRCPV}"
SRCREV = "d8c68473ce414fe7342d084e461556fc90d01814"
SRC_PATH = "${FILE_DIRNAME}/${BPN}"
SRC_URI = "git://github.com/${IMREPO}/imgui.git;branch=master;protocol=https"

DEPENDS = "glfw"

S = "${WORKDIR}/git/examples/${IMBIN}"
FILES:${PN}:append = " ${ROOT_HOME}"

inherit pkgconfig thclass

do_install() {

	install -d ${D}/${bindir}
	install -d ${D}/${ROOT_HOME}
	install -m 0755 ${B}/${IMBIN} ${D}/${bindir}
	install -m 0644 ${SRC_PATH}/imgui.ini ${D}/${ROOT_HOME}
}

#INSANE_SKIP:${PN} += "ldflags"
TARGET_CC_ARCH:append = " ${LDFLAGS}"
