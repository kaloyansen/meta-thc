# .profile

# aliases
alias ls=ls\ --color
alias l=ls\ -la

# counter
[ -z "${KALO}" ] && KALO=1 || KALO=`expr $KALO + 1`
export KALO

[ -n "$DISPLAY" ] && /usr/bin/example_glfw_opengl2_cmake || /usr/bin/wifini.sh -s PuzlCowOrKing

