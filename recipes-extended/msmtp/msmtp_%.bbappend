FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:prepend = "file://.msmtprc "
FILES:${PN}:append = " ${ROOT_HOME}"

inherit thclass

do_install:append() {
	install -d ${D}${ROOT_HOME}
	install -m 0600 ${WORKDIR}/.msmtprc ${D}/${ROOT_HOME}
}

