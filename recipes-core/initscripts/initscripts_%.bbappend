ALLER                    = "functions"
AVEC                     = "munctions"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:prepend          = "file://${AVEC} "
LOCO                     = "/etc/init.d"

inherit thclass

do_install:append() {

	install -m 0600 ${WORKDIR}/${AVEC} ${D}${LOCO}
	echo . ${LOCO}/${AVEC} >> ${D}${LOCO}/${ALLER}

}

