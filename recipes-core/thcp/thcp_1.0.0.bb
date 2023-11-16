SUMMARY = "triplehelix-consulting.com"
DESCRIPTION = "copy scripts to the target"

LICENSE = "MIT"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_PATH = "${FILE_DIRNAME}/${BPN}"
SRC_URI = "file:///${SRC_PATH}"

FILES:${PN}:append = " ${ROOT_HOME}"

inherit thclass allarch

do_install() {
	# directory
	install -d ${D}/${bindir}
	install -d ${D}/${ROOT_HOME}
	install -d ${D}/${ROOT_HOME}/.config/procps

	# executable
	install -m 0755 ${WORKDIR}/${SRC_PATH}/wifini.sh ${D}/${bindir}
	install -m 0755 ${WORKDIR}/${SRC_PATH}/rpip ${D}/${bindir}

	# configuration
	install -m 0644 ${WORKDIR}/${SRC_PATH}/.profile ${D}/${ROOT_HOME}
	install -m 0644 ${WORKDIR}/${SRC_PATH}/imgui.ini ${D}/${ROOT_HOME}
	install -m 0644 ${WORKDIR}/${SRC_PATH}/toprc ${D}/${ROOT_HOME}/.config/procps
}
