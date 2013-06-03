TEMPLATE = subdirs

PROJECTNAME = ubuntu-ui-toolkit

SOURCECODE = `find .. -name *.qml`

message("")
message(" Project Name: $$PROJECTNAME ")
message(" Source Code: $$SOURCECODE ")
message("")
message(" run 'make pot' to generate the pot file from source code. ")
message(" run 'make mo' to generate the mo files from po files. ")
message(" run 'qmake; make install' to install the mo files. ")
message("")

## generate pot file 'make pot'
potfile.target = pot
potfile.commands = ./update-pot.sh
QMAKE_EXTRA_TARGETS += potfile

## generate mo files 'make mo'
mofiles.target = mo
mofiles.commands = ./generate_mo.sh
QMAKE_EXTRA_TARGETS += mofiles

## Installation steps for mo files. 'make install'
MO_FILES = $$system(ls locale/*/LC_MESSAGES/*.mo)

install_mo_commands =
for(mo_file, MO_FILES) {
  mo_name = $$replace(mo_file,.mo,)
  mo_targetpath_prefix = $(INSTALL_ROOT)/usr/share
  mo_target = $${mo_targetpath_prefix}/$${mo_file}
  !isEmpty(install_mo_commands): install_mo_commands += &&
  install_mo_commands += test -d $$mo_targetpath || mkdir -p $$mo_targetpath
  install_mo_commands += && cp $$mo_file $$mo_target
}

install.commands = $$install_mo_commands

QMAKE_EXTRA_TARGETS += install
