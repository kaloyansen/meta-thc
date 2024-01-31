FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:prepend          = "file://.msmtprc.tmpl "
SRC_URI:prepend          = "file://.msmtp.conf "
FILES:${PN}:append       = " ${ROOT_HOME}"
DESTIN                   = "${D}${ROOT_HOME}"

inherit thclass

do_install:append() {
	install -d ${DESTIN}
	install -m 0600 ${WORKDIR}/.msmtprc.tmpl ${DESTIN}
	install -m 0600 ${WORKDIR}/.msmtp.conf ${DESTIN}
}

