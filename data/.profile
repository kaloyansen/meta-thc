alias ls=ls\ --color
alias l=ls\ -la

[[ -z "${KALO}" ]] && KALO=1 || KALO=`expr $KALO + 1`
export KALO


