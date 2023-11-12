SUMMARY = "imgui recipe with cmake"
HOMEPAGE = "https://triplehelix-consulting.com"
DESCRIPTION = "recipe for building imgui with cmake"
LICENSE = "MIT"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"

IMGIT = "imgui_aarch64_glfw_openGL2_experiment"
IMDIR = "example_glfw_opengl2"
IMBIN = "${IMDIR}_cmake"

PV .= "+git${SRCPV}"
SRCREV = "29ae8998cff3a898c7d6736af19f16379a9909ef"
SRC_URI = "git://github.com/kaloyanski/${IMGIT}.git;branch=master;protocol=https"

DEPENDS = "mesa glfw"
DEPENDS:remove = "mesa"

S = "${WORKDIR}/git/imgui/examples/${IMDIR}"

inherit cmake thclass

addtask tomber before do_install

do_install() {
	install -d ${D}/${bindir}
	install -m 0755 ${B}/${IMBIN} ${D}/${bindir}
}

