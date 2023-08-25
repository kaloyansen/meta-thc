SUMMARY = "imgui recipe with cmake"
DESCRIPTION = "recipe for building imgui with cmake"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file:///home/kalo/work/config/LICENSE;md5=c013f313bd63a3f147337df79bb29991"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"

SRC_URI = "file:///home/kalo/work/tarball/imgui_aarch64_glfw_openGL2_experiment.tar.gz"
#SRC_URI[md5sum] = "fb7e8dd3cda8d4740a1f0de0eba481fd"
#SRC_URI[sha256sum] = "485a7bfe74127f2630ef94950ebdbb6bc5c311f921aa8b4bd314c8df1ace9c56"

DEPENDS = "mesa glfw"
# mesa"
# RDEPENDS_${PN} = "libx11"
# PSEUDO_DEBUG = "nfoPcvdDyerpswikVx"
S = "${WORKDIR}/imgui_aarch64_glfw_openGL2_experiment/imgui/examples/example_glfw_opengl2"

inherit cmake thclass

TOMBEXT = "install imgui"
addtask tomber before do_install

do_install() {
	install -d ${D}/${bindir}
	install -m 0755 ${B}/example_glfw_opengl2_cmake ${D}/${bindir}
}

# FILES_${PN} = "${bindir}/example_glfw_opengl2_cmakee"
