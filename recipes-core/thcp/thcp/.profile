# .profile

# aliases
alias ls=ls\ --color
alias l=ls\ -la
alias ..=cd\ ..
alias ...='..&&..'

# counter
[ -z "${KALO}" ] && KALO=1 || KALO=`expr $KALO + 1`
export KALO

# run imgui demo
[ -n "$DISPLAY" ] && /usr/bin/example_glfw_opengl2_cmake

