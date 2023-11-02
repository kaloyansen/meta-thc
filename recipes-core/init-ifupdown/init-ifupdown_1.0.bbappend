FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit thclass

TOMBEXT = "${PF}: edit /etc/network/interfaces"
addtask tomber before do_install

do_install:append() {
    echo auto wlan0 >> ${D}${sysconfdir}/network/interfaces
    echo >> ${D}${sysconfdir}/network/interfaces
}
