ALLER                    = "functions"
PATCH                    = "patch"
AVEC                     = "munctions"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:prepend          = "file://${AVEC} "
SRC_URI:prepend          = "file://${PATCH} "
LOCO                     = "/etc/init.d"

inherit thclass

do_install:append() {

	install -m 0600 ${WORKDIR}/${AVEC} ${D}${LOCO}
	cat ${WORKDIR}/${PATCH} >> ${D}${LOCO}/${ALLER}

}

# echo . ${LOCO}/${AVEC} >> ${D}${LOCO}/${ALLER}
