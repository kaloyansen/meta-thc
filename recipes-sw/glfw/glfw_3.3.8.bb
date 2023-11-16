SUMMARY = "A multi-platform library for creating windows with OpenGL contexts \
and receiving input and events"
HOMEPAGE = "https://www.glfw.org/"
DESCRIPTION = "GLFW is an Open Source, multi-platform library for OpenGL, \
OpenGL ES and Vulkan application development. It provides a simple, \
platform-independent API for creating windows, contexts and surfaces, reading \
input, handling events, etc."
LICENSE  = "Zlib"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Zlib;md5=87f239f408daca8a157858e192597633"

SECTION = "lib"

inherit pkgconfig cmake features_check thclass

PV .= "+git${SRCPV}"
SRCREV = "781fbbadb0bccc749058177b1385c82da9ace880"
SRC_URI = "git://github.com/glfw/glfw.git;branch=master;protocol=https"

S = "${WORKDIR}/git"


EXTRA_OECMAKE = "-DCMAKE_INSTALL_PREFIX=${prefix} \
                 -DGLFW_BUILD_EXAMPLES=OFF \
                 -DGLFW_BUILD_TESTS=OFF \
                 -DGLFW_BUILD_DOCS=OFF"

# EXTRA_OECMAKE:append = " -DGLFW_USE_WAYLAND=ON"
# EXTRA_OECMAKE:append = " -DBUILD_SHARED_LIBS=ON"
# CFLAGS += " -fPIC"

DEPENDS = "libpng libglu zlib libxrandr libxinerama libxi libxcursor"
DEPENDS ?= "libxkbcommon glib-2.0 virtual/libgles2 virtual/egl weston wayland wayland-native wayland-protocols"

REQUIRED_DISTRO_FEATURES = "x11 opengl"
REQUIRED_DISTRO_FEATURES ?= "x11 opengl wayland"



COMPATIBLE_HOST:libc-musl = "null"
