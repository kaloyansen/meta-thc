FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit thclass

do_install:append() {
    echo auto wlan0 >> ${D}${sysconfdir}/network/interfaces
    echo >> ${D}${sysconfdir}/network/interfaces
}
