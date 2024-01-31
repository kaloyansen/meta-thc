ALLER                    = "functions"
EXTRA                    = "extra"
AVEC                     = "fun"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:prepend          = "file://${AVEC} "
SRC_URI:prepend          = "file://${EXTRA} "
LOCO                     = "/etc/init.d"

inherit thclass

do_install:append() {

	install -m 0600 ${WORKDIR}/${AVEC} ${D}${LOCO}
	cat ${WORKDIR}/${EXTRA} >> ${D}${LOCO}/${ALLER}

}
