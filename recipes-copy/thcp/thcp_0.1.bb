SUMMARY = "triplehelix-consulting.com"
DESCRIPTION = "copy scripts to the target system"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file:///home/kalo/work/config/LICENSE;md5=c013f313bd63a3f147337df79bb29991"

DEPENDS = "dhcpcd"

SRC_PATH = "home/yocto/layer/meta-thc/data"

SRC_URI = "file:///${SRC_PATH}/wifi.sh \
           file:///${SRC_PATH}/wifini.sh "

inherit thclass allarch

addtask tomber before do_install

do_install() {
	install -d ${D}/${bindir}
	install -m 0755 ${WORKDIR}/${SRC_PATH}/wifi.sh ${D}/${bindir}
	install -m 0755 ${WORKDIR}/${SRC_PATH}/wifini.sh ${D}/${bindir}
}
