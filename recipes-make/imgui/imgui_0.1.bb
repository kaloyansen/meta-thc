SUMMARY = "recipe for building imgui with cmake"
DESCRIPTION = "recipe for building imgui with cmake"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file:///home/kalo/work/config/LICENSE;md5=c013f313bd63a3f147337df79bb29991"


SRC_URI = "file:///home/kalo/work/tarball/imgui_aarch64_glfw_openGL2_experiment.tar.gz"
#SRC_URI[md5sum] = "fb7e8dd3cda8d4740a1f0de0eba481fd"
#SRC_URI[sha256sum] = "485a7bfe74127f2630ef94950ebdbb6bc5c311f921aa8b4bd314c8df1ace9c56"

DEPENDS = "glfw mesa"
# RDEPENDS_${PN} = "libx11"
S = "${WORKDIR}/imgui_aarch64_glfw_openGL2_experiment/imgui/examples/example_glfw_opengl2"

inherit cmake

python do_display_banner() {
    bb.plain("***********************************************");
    bb.plain("*                                             *");
    bb.plain("*       recipe to build imgui by kalo         *");
    bb.plain("*    copyleft triplehelix-consulting.com      *");
    bb.plain("*                                             *");
    bb.plain("***********************************************");
}

addtask display_banner before do_build

# do_configure() {
# 	cd ${B} 
# 	cmake ${S} # -DCMAKE_INSTALL_PREFIX=${D}
# }

# do_compile() {
# 	cd ${B}
# 	make
# }


#do_install() {
#    install -d ${D}${bindir}
#    install -m 0755 example_glfw_opengl2_cmake ${D}${bindir}
#}




#do_package() {
#	:
#	install -d ${D}/${bindir}
#	install -m 0755 ${B}/example_glfw_opengl2_cmake ${D}/${bindir}
#}
