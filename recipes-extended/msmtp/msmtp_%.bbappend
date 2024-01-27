FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:prepend = "file://.msmtprc.tmpl "
FILES:${PN}:append = " ${ROOT_HOME}"

inherit thclass

do_install:append() {
	install -d ${D}${ROOT_HOME}
	install -m 0600 ${WORKDIR}/.msmtprc.tmpl ${D}/${ROOT_HOME}
}

