# thclass.bbclass

python do_tomber() {
    bb.plain("= %s =" % d.getVar('BP'))
}

addtask tomber before do_install


