---
bibliography: thcport.bib
title: Embedded Operating System for with
---

# introduction

This article`\cite{kalo2023}`{=latex} reports the progress in the
configuration and build of a Linux-based operating system for
`\cite{raspberry}`{=latex} with `\cite{yocto}`{=latex}. Please refer
`\cite{kalohowto2023}`{=latex} for technical details.

The [CPU]{acronym-label="CPU" acronym-form="singular+short"} is $ARM$
$Cortex$-$A72$. It is a high performance [CPU]{acronym-label="CPU"
acronym-form="singular+short"} with low power consumption. With
dimensions of 9 x 7 x 2 cm, the machine has 4   of RAM. As there are no
fixed storage devices, $images$ are installed on $SD$ cards.

Embedded devices`\cite{vasquez2021}`{=latex} are compact systems with
specific purpose. Embedded operating systems provide a limited number of
services defined by this purpose and device [HW]{acronym-label="HW"
acronym-form="singular+short"}. There are important reasons why Linux is
a preferred [OS]{acronym-label="OS" acronym-form="singular+short"}
kernel for embedded devices. Since such devices usually have limited
[HW]{acronym-label="HW" acronym-form="singular+short"} resources, they
rely on optimized [SW]{acronym-label="SW" acronym-form="singular+short"}
implementations. Smaller and faster than their original, such programs
have limited, but usually sufficient functionality. For example,
$BusyBox$ combines tiny versions of many common $unix$ utilities into a
single executable`\cite{busybox}`{=latex}. Another example is $Dropbear$
$SSH$ - an optimized [SSH]{acronym-label="SSH"
acronym-form="singular+short"} server
implementation`\cite{dropbear}`{=latex}. $Dropbear$ is significantly
smaller in size compared to $OpenSSH$. Unlike [GNU]{acronym-label="GNU"
acronym-form="singular+short"}/Linux desktop
distributions`\cite{rusev2023}`{=latex}, embedded Linux has neither a
[GUI]{acronym-label="GUI" acronym-form="singular+short"} for system
configuration nor a centralized service manager like $systemd$.

Project`\cite{yocto}`{=latex} provides a popular framework for
configuration and build of Linux-based operating systems. First of all,
supports [HW]{acronym-label="HW" acronym-form="singular+short"} via a
[SW]{acronym-label="SW" acronym-form="singular+short"} layer called
[BSP]{acronym-label="BSP" acronym-form="singular+short"}. In addition,
there are custom distribution configuration and a tool called $Bitbake$
to create [SW]{acronym-label="SW" acronym-form="singular+short"}
packages and to build [OS]{acronym-label="OS"
acronym-form="singular+short"} $images$. These $images$ are configurable
and operational. There is a bootloader, a kernel release and the
user-space part of the [OS]{acronym-label="OS"
acronym-form="singular+short"}, including custom user applications. This
approach is indispensable when it comes to embedded devices. images are
collections of [SW]{acronym-label="SW" acronym-form="singular+short"}
packages. Packages are created via [SW]{acronym-label="SW"
acronym-form="singular+short"} recipes. Although a recipe may have all
sorts of instructions, a typical one contains the source code location
and the [SW]{acronym-label="SW" acronym-form="singular+short"} build
configuration. These are architecture independent. However, binaries are
cross-compiled in case of different target machine processor
architecture. This applies to the entire [OS]{acronym-label="OS"
acronym-form="singular+short"}.

# sources

As they differ, it could be extremely useful to isolate the
[SW]{acronym-label="SW" acronym-form="singular+short"} development from
the [OS]{acronym-label="OS" acronym-form="singular+short"} build. This
way developers may work and test a [SW]{acronym-label="SW"
acronym-form="singular+short"} application on their own. As far as I
could fetch the source code, in example, from a $git$ repository, in
theory, it should not be too complicated to build an
[OS]{acronym-label="OS" acronym-form="singular+short"} able to run this
application. What is more, I can build it for a computing device of my
choice. I just need the corresponding [BSP]{acronym-label="BSP"
acronym-form="singular+short"}.

A complete list of $github$ [SW]{acronym-label="SW"
acronym-form="singular+short"} repositories used in this project
includes , the [BSP]{acronym-label="BSP" acronym-form="singular+short"},
a [SW]{acronym-label="SW" acronym-form="singular+short"} layer with
custom recipes, the configuration and the source code of the application
and the dependencies. Note that for a relatively simple application I
must fetch six [SW]{acronym-label="SW" acronym-form="singular+short"}
repositories. Follow links for details.

-    reference distribution
    [yoctoproject.org/poky.git](https://git.yoctoproject.org/poky)

-   [BSP]{acronym-label="BSP" acronym-form="singular+short"} layer for
    $Raspberry$ $\pi$ boards
    [agherzan/meta-raspberrypi.git](https://github.com/agherzan/meta-raspberrypi)

-    configuration
    [TripleHelixConsulting/rpiconf.git](https://github.com/TripleHelixConsulting/rpiconf)

-   [SW]{acronym-label="SW" acronym-form="singular+short"} layer
    [kaloyanski/meta-thc.git](https://github.com/kaloyanski/meta-thc)

-   immediate mode [GUI]{acronym-label="GUI"
    acronym-form="singular+short"}
    [kaloyanski/imgui_aarch64_glfw_openGL2_experiment.git](https://github.com/kaloyanski/imgui_aarch64_glfw_openGL2_experiment)

-   graphics library framework
    [glfw/glfw.git](https://github.com/glfw/glfw)

## application

$Dear$ $ImGui$`\cite{imgui}`{=latex} is a bloat-free
[GUI]{acronym-label="GUI" acronym-form="singular+short"} library for
C++. It outputs optimized vertex buffers that you can render anytime in
your 3D-pipeline-enabled application. It is fast, portable, renderer
agnostic, and self-contained (no external dependencies). $Dear$ $ImGui$
is designed to enable fast iterations and to empower programmers to
create content creation tools and visualization/debug tools (as opposed
to UI for the average end-user). It favors simplicity and productivity
toward this goal and lacks certain features commonly found in more
high-level libraries. $Dear$ $ImGui$ is particularly suited to
integration in game engines (for tooling), real-time 3D applications,
full-screen applications, embedded applications, or any applications on
console platforms where operating system features are non-standard.

$Dear$ $ImGui$ depends on $GLFW$`\cite{glfw}`{=latex}, an open-source,
multi-platform library for $OpenGL$, $OpenGL$ $ES$ and $Vulkan$
development on the desktop. It provides a simple API for creating
windows, contexts and surfaces, receiving input and events. $GLFW$ is
written in $C$ and supports $Windows$, $macOS$, $X11$ and $Wayland$.

$Dear$ $ImGui$ is licensed under the $MIT$ License. $GLFW$ is licensed
under the $zlib/libpng$ license.

## layers

Here is a list of $metadata$ layers. The project reference distribution
is $poky$.

-   $meta$\
    user-space

-   $meta-poky$\
    reference distribution

-   $meta-raspberrypi$\
    This`\cite{meta-rpi}`{=latex} is the general [HW]{acronym-label="HW"
    acronym-form="singular+short"} specific [BSP]{acronym-label="BSP"
    acronym-form="singular+short"} overlay for the $RaspberryPi$ device.
    The core [BSP]{acronym-label="BSP" acronym-form="singular+short"}
    part of $meta-raspberrypi$ works with different $OpenEmbedded$/
    distributions and layer stacks. In short, the recipes to build the
    kernel and kernel modules are in this layer. For details see the
    package $linux$-$raspberrypi$. In addition, here is the
    [HW]{acronym-label="HW" acronym-form="singular+short"} specific
    firmware. The build configuration corresponds the specific
    [HW]{acronym-label="HW" acronym-form="singular+short"}, in this case
    .

-   $meta-thc$\
    I have introduced a new [SW]{acronym-label="SW"
    acronym-form="singular+short"} layer to control the build of $Dear$
    $ImGui$ and $GLFW$. As long as the source codes have a standard
    build configuration, the $bitbake$ recipes are straightforward. Both
    instructions inherit $cmake$ $bitbake$ class.

# build

## configuration

provides a list of image types. I have chosen
$core-image-x11$`\cite{yocto}`{=latex} - a very basic X11 image with a
terminal. In the main build configuration, apart from $Dear$ $ImGui$ and
$GLFW$, I have added the following packages;

-   $os-release$\
    [OS]{acronym-label="OS" acronym-form="singular+short"}
    identification

-   $Dropbear$\
    Compact [SSH]{acronym-label="SSH" acronym-form="singular+short"}
    server`\cite{dropbear}`{=latex}

-   $thcp$\
    [OS]{acronym-label="OS" acronym-form="singular+short"}
    post-configuration scripts

## image

The used space on the partition of the [OS]{acronym-label="OS"
acronym-form="singular+short"} is 220  . The free space is configurable.
The kernel $ARM$, 64 boot executable $image$ of 23   is a configuration
of Linux 5.15. This kernel release has a [LTS]{acronym-label="LTS"
acronym-form="singular+short"}. The total size of kernel modules is
21  .

provides multiple [SW]{acronym-label="SW" acronym-form="singular+short"}
package and [OS]{acronym-label="OS" acronym-form="singular+short"}
$image$ formats. Further, different ways exist to install $images$.
Finally, formats do not matter, as long as the result is a complete
[OS]{acronym-label="OS" acronym-form="singular+short"} on an $SD$ card.
I recommend the classic command-line tool $dd$ to copy data. It works
fine with different $image$ formats like $rpi-sdimg$, $hddimg$ and
$wic$.

# connection

Connected embedded systems can communicate to one another and to
cloud-based [PaaS]{acronym-label="PaaS" acronym-form="singular+short"}
solutions. In addition, a remote control may be required. An
[SSH]{acronym-label="SSH" acronym-form="singular+short"} server is a
standard solution for both problems.

Wireless connection is established via classic command-line tools like
$ip$, $iw$, $udhcpc$, and $wpa$\_$supplicant$. Custom shell scripts are
installed in , as well as a running [GUI]{acronym-label="GUI"
acronym-form="singular+short"} example to demonstrate the usage of the
$Dear$ $ImGui$ library. Once an [IP]{acronym-label="IP"
acronym-form="singular+short"} address is assigned, the
[SSH]{acronym-label="SSH" acronym-form="singular+short"} server by
$Dropbear$ allows for a secured remote login, remote control and file
transfer.

# outlook

This reports the progress in the development of a custom Linux-based
[OS]{acronym-label="OS" acronym-form="singular+short"} for
`\cite{raspberry}`{=latex}. The kernel version of this embedded
[OS]{acronym-label="OS" acronym-form="singular+short"} is Linux release
5.15. An example [GUI]{acronym-label="GUI"
acronym-form="singular+short"} application using the $Dear$ $ImGui$
library is built as a part of the [OS]{acronym-label="OS"
acronym-form="singular+short"}. In addition, an
[SSH]{acronym-label="SSH" acronym-form="singular+short"} server provides
remote connection, data transfer and device control. As the
[OS]{acronym-label="OS" acronym-form="singular+short"} is now
functional, performance and real-time tests are ongoing.

# acronyms {#acronyms .unnumbered}

::: acronym
:::
