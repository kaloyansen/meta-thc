

python do_tomber() {
    bb.plain()
    bb.plain("***********************************************")
    bb.plain("*      configurated by Kaloyan Krastev        *")
    bb.plain("*    copyleft triplehelix-consulting.com      *")
    bb.plain("***********************************************")
    bb.plain()
    bb.plain("========> executing %s" % d.getVar('TOMBEXT'))
    bb.plain()
    d.delVar("TOMBEXT")
}

