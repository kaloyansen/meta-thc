# .profile

# aliases
alias ls=ls\ --color
alias l=ls\ -la
alias ..=cd\ ..
alias ...='..&&..'

FUN=/etc/init.d/functions
[ -f $FUN ] && . $FUN || echo no fun

# counter
[ -z "$ALO" ] && ALO=1 || ALO=`expr $ALO + 1`
export ALO
hostname rpi$ALO

# run imgui demo
[ -n "$DISPLAY" ] && /usr/bin/example_glfw_opengl2_cmake

