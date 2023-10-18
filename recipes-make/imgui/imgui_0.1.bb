SUMMARY = "imgui recipe with cmake"
DESCRIPTION = "recipe for building imgui with cmake"
HOMEPAGE = "https://triplehelix-consulting.com"

LICENSE = "MIT"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"

IMGIT = "imgui_aarch64_glfw_openGL2_experiment"
IMBIN = "example_glfw_opengl2"

### local source ###
SRC_URI = "file:///home/kalo/work/tarball/${IMGIT}.tar.gz"
#SRC_URI[md5sum] = "fb7e8dd3cda8d4740a1f0de0eba481fd"
#SRC_URI[sha256sum] = "485a7bfe74127f2630ef94950ebdbb6bc5c311f921aa8b4bd314c8df1ace9c56"

### remote source ###

IMTAG = "bof"
SRC_URI = "https://github.com/kaloyanski/${IMGIT}/archive/refs/tags/${IMTAG}.tar.gz"
# SRC_URI = "git://github.com/kaloyanski/${IMGIT}.git;branch=master;protocol=https"
# SRC_URI = "git://github.com/kaloyanski/${IMGIT}/archive/refs/tags/${IMTAG}.tar.gz;protocol=http"
# SRC_URI = "git://github.com/kaloyanski/${IMGGIT}/tarball/master;protocol=http"
SRC_URI[md5sum] = "20ba1da9ebd7325d0b300b3be37e413f"
#IMGIT:append = "-${IMTAG}"

# SRCREV = "dd8569f51eda8d344961a6542a05c618de3454e1"


DEPENDS = "mesa glfw"
# mesa"
# RDEPENDS_${PN} = "libx11"
# PSEUDO_DEBUG = "nfoPcvdDyerpswikVx"
S = "${WORKDIR}/${IMGIT}/imgui/examples/${IMBIN}"
S = "${WORKDIR}/${IMGIT}-${IMTAG}/imgui/examples/${IMBIN}"

inherit cmake thclass

TOMBEXT = "install imgui"
addtask tomber before do_install

do_install() {
	install -d ${D}/${bindir}
	install -m 0755 ${B}/${IMBIN}_cmake ${D}/${bindir}
}

# FILES_${PN} = "${bindir}/example_glfw_opengl2_cmakee"
