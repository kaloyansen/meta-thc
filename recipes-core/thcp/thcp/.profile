# .profile

# aliases
alias ls=ls\ --color
alias l=ls\ -la
alias ..=cd\ ..
alias ...='..&&..'

FUN=/etc/init.d/functions
[ -f $FUN ] && . $FUN || echo \ dot profile no fun

TTYN=`fgconsole`

say() {

    warning && echo \ dot profile tty$TTYN $*
}

# counter
[ -z "$ALO" ] && ALO=1 || ALO=`expr $ALO + 1`
export ALO

hostname rpi$TTYN

# clock
DATE=`date`
rdate -s time.nist.gov >& /dev/null && say clock set: $DATE || say clock not set: $?

# run imgui demo
[ -n "$DISPLAY" ] && /usr/bin/example_glfw_opengl2_cmake || say no display for imgui

