SUMMARY = "A multi-platform library for creating windows with OpenGL contexts and receiving input and events"
LICENSE = "MIT"
LIC_FILES_CHKSUM ?= "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"


SRC_URI = "file:///home/kalo/work/tarball/glfw-${PV}.tar.gz"
SRC_URI = "https://github.com/glfw/glfw/releases/tag/${PV}/${PV}.tar.gz"
SRC_URI = "https://github.com/glfw/glfw/download/${PV}.tar.gz"
SRC_URI = "https://github.com/glfw/glfw/archive/refs/tags/${PV}.tar.gz"
SRC_URI[md5sum] = "55d99dc968f4cec01a412562a7cf851c"
#SRC_URI[sha256sum] = "29a315cdf9add3988d049d55428119d129fb5f05b2f5720a72584bf62d434b63"
#SRC_URI[md5sum] = "55d99dc968f4cec01a412562a7cf851c"
#SRC_URI[md5sum] = "d12cb3015af3816e1104595803d5fcbe"
#SRC_URI[sha256sum] = "cc70b239d64a93c240a8ba711381af5fa1d911700ce889654696c7617b3fcdff"


S = "${WORKDIR}/glfw-${PV}"
DEPENDS = "libx11 libxrandr libxi libxinerama libxcursor"

inherit cmake

EXTRA_OECMAKE = "-DCMAKE_INSTALL_PREFIX=${prefix} \
                 -DGLFW_BUILD_EXAMPLES=OFF \
                 -DGLFW_BUILD_TESTS=OFF \
                 -DGLFW_BUILD_DOCS=OFF"


