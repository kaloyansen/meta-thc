FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit thclass

do_install:append() {
    ln -s /usr/share/dhcpcd/hooks/10-wpa_supplicant ${D}/usr/libexec/dhcpcd-hooks/
	touch ${D}/usr/libexec/dhcpcd-hooks/wpa-supplicant-link-in-libexec
}
