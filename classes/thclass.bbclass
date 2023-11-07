# triplehelix-consulting.com

python do_tomber() {
    bb.plain()
    bb.plain("=== kkk ===> executing %s" % d.getVar('TOMBEXT'))
    bb.plain()
    d.delVar("TOMBEXT")
}

