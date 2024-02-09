SUMMARY = "this is not a dear imgui example recipe"
DESCRIPTION = "recipe for building a compact graphical user interface for system information"
RECIPE_MAINTAINER = "Kaloyan Krastev <kaloyan@triplehelix-consulting.com>"
HOMEPAGE = "https://triplehelix-consulting.com"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

IMREPO  ?= "kaloyanski"
IMBIN   ?= "sinfo"

SRC_URI = "git://github.com/${IMREPO}/imgui.git;branch=master;protocol=https"
PV .= "+git${SRCPV}"
SRCREV = "cd21563bb49a1baadba45984d4c944e320d38fcd"

DEPENDS = "glfw"

S = "${WORKDIR}/git/src/${IMBIN}"

inherit pkgconfig thclass

do_install() {

	install -d ${D}/${bindir}
	install -m 0755 ${B}/${IMBIN} ${D}/${bindir}
}

TARGET_CC_ARCH:append = " ${LDFLAGS}"
