FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:prepend = "file://toprc "
FILES:${PN}:append = " ${ROOT_HOME}"

inherit thclass

do_install:append() {

	install -d ${D}${ROOT_HOME}/.config/procps
	install -m 0600 ${WORKDIR}/toprc ${D}/${ROOT_HOME}/.config/procps
}

