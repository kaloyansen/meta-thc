SUMMARY = "A multi-platform library for creating windows with OpenGL contexts and receiving input and events"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file:///home/kalo/work/config/LICENSE;md5=c013f313bd63a3f147337df79bb29991"


SRC_URI = "https://github.com/glfw/glfw/releases/download/${PV}/glfw-${PV}.tar.gz"
SRC_URI = "file:///home/kalo/work/tarball/glfw-${PV}.tar.gz"


S = "${WORKDIR}/glfw-${PV}"
DEPENDS = "libx11 libxrandr libxi libxinerama libxcursor"

inherit cmake

EXTRA_OECMAKE = "-DCMAKE_INSTALL_PREFIX=${prefix} \
                 -DGLFW_BUILD_EXAMPLES=OFF \
                 -DGLFW_BUILD_TESTS=OFF \
                 -DGLFW_BUILD_DOCS=OFF"


