SUMMARY = "triplehelix-consulting.com"
DESCRIPTION = "copy scripts to the target"
RECIPE_MAINTAINER = "Kaloyan Krastev <kaloyan@triplehelix-consulting.com>"
HOMEPAGE = "https://triplehelix-consulting.com"

LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

SRC_PATH = "${FILE_DIRNAME}/${BPN}"
SRC_URI = "file:///${SRC_PATH}"

FILES:${PN}:append = " ${ROOT_HOME}"

inherit thclass allarch

do_install() {
	# directory
	install -d ${D}/${bindir}
	install -d ${D}/${ROOT_HOME}
	install -d ${D}/${ROOT_HOME}/.config/procps

	# executables
	install -m 0755 ${WORKDIR}/${SRC_PATH}/wifini.sh ${D}/${bindir}
	install -m 0755 ${WORKDIR}/${SRC_PATH}/rpip ${D}/${bindir}

	# configuration
	install -m 0644 ${WORKDIR}/${SRC_PATH}/.profile ${D}/${ROOT_HOME}
#	install -m 0644 ${WORKDIR}/${SRC_PATH}/imgui.ini ${D}/${ROOT_HOME}
	install -m 0644 ${WORKDIR}/${SRC_PATH}/toprc ${D}/${ROOT_HOME}/.config/procps
#        ln -s /home/root ${D}/root
}
