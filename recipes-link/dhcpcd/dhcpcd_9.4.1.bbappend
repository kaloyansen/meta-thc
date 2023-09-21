FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit thclass

TOMBEXT = "dhcpcd link"
addtask tomber before do_install

do_install:append() {
    ln -s /usr/share/dhcpcd/hooks/10-wpa_supplicant ${D}/usr/libexec/dhcpcd-hooks/
	touch ${D}/usr/libexec/dhcpcd-hooks/wpa-link-success
}
