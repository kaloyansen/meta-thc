FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:prepend         = "file://toprc "
FILES:${PN}:append      = " ${ROOT_HOME}"
DESTIN                  = "${D}${ROOT_HOME}/.config/procps"

inherit thclass

do_install:append() {

	install -d ${DESTIN}
	install -m 0600 ${WORKDIR}/toprc ${DESTIN}
}

