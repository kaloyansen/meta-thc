# thclass.bbclass

python do_tomber() {
    bb.plain("= %s =" % d.getVar('BP'))
}

addtask tomber before do_install


# thconf_loop() {
#    echo this is a test function
# }

# EXPORT_FUNCTIONS loop
