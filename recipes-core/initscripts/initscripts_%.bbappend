ALLER                    = "functions"
AVEC                     = "munctions"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI:prepend          = "file://${AVEC} "

inherit thclass

do_install:append() {

    cat ${WORKDIR}/${AVEC} >> ${D}/etc/init.d/${ALLER}
}

