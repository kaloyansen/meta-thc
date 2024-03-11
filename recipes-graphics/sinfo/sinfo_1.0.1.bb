SUMMARY = "this is not a dear imgui example recipe"
DESCRIPTION = "recipe for building a compact graphical system monitor"
RECIPE_MAINTAINER = "Kaloyan Krastev <kaloyansen@gmail.com>"
HOMEPAGE = "https://kaloyansen.github.io/imgui"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

IMREPO  ?= "kaloyansen"
IMBIN   ?= "sinfo"

SRC_URI = "git://github.com/${IMREPO}/imgui.git;branch=master;protocol=https"
PV .= "+git${SRCPV}"
SRCREV = "a6bcb7afa76dab2aea42cf598b1dd3a99d099df6"
SRCREV = "a8b4103e37be914fa0f99ada46ebaa0491050315"

DEPENDS = "glfw"

S = "${WORKDIR}/git/${IMBIN}"

inherit pkgconfig thclass

do_install() {

	install -d ${D}/${bindir}
	install -m 0755 ${B}/${IMBIN} ${D}/${bindir}
}

TARGET_CC_ARCH:append = " ${LDFLAGS}"
