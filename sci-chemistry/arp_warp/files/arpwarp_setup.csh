#
# File to be sourced from .cshrc to setup ARP/wARP environment
#
alias printl        'echo'
alias runtestpython 'python -V'
#
set namesystem = `uname`
set nameprocessor = `uname -m | sed -e 's/ //g'`
if ( $nameprocessor == 'PowerMacintosh' || $namesystem == 'IRIX64' ) then
  set nameprocessor = `uname -p | sed -e 's/ //g'`
endif
set identifier = ${nameprocessor}'-'${namesystem}
#
set arpwarphome = '/usr/lib/arp_warp_7.0'
#
setenv warpbin ${arpwarphome}/bin/bin-${identifier}
setenv warpdoc ${arpwarphome}/manual
set path   = ( $warpbin $path )
#
# Settings for python
# Checks for CBIN variable
if ( ! $?CBIN ) then
  printl
  printl 'Cannot setup ARP/wARP'
  printl 'Variable $CBIN is not defined'
  printl 'Please install CCP4 first'
  goto errorsetup
endif
if ( ! -d $CBIN ) then
  printl
  printl 'Cannot setup ARP/wARP'
  printl 'Directory $CBIN '$CBIN' does not exist'
  printl 'Please install CCP4 first'
  goto errorsetup
endif
#
# Checks for python version
runtestpython >& /dev/null
if( $status ) then
  printl
  printl 'WARNING while setting up ARP/wARP'
  printl '"python" command is not available'
  printl 'flex-warp ("ARP/wARP Expert System" in the GUI) will not be installed'
  goto endsetup
else
  set infomessage = (`runtestpython |& tail -1`)
  set pythonvrs = (`printl $infomessage[$#infomessage] | sed -e 's/\./ /g'`)
  set pythoncode = (`ls $arpwarphome'/byte-code'`)
  set pythonneeded = 'python-'${pythonvrs[1]}'.'${pythonvrs[2]}
  set ic = '0'
  foreach test ( $pythoncode )
    if ( $test == $pythonneeded ) set ic = '1'
  end
  if ( $ic == 1 ) then
    set pythontouse = ${arpwarphome}'/byte-code/'${pythonneeded}
  else
    printl
    printl 'WARNING while setting up ARP/wARP'
    printl 'ARP/wARP does not have executables for python-'${pythonvrs[1]}'.'${pythonvrs[2]}
    printl 'flex-warp ("ARP/wARP Expert System" in the GUI) will not be installed'
    printl 'Please re-install ARP/wARP, this will create required executables'
    goto endsetup
  endif
endif
#
setenv pywarp_warpbin /usr/lib/arp_warp_7.0/bin/bin-${identifier}
setenv pywarp_cbin $CBIN
setenv pywarpbin $pythontouse
#
# Setting up library path for SGI
if ( ${identifier} == 'mips-IRIX64' ) then
  if ( ${?LD_LIBRARY_PATH} ) then
    setenv LD_LIBRARY_PATH ${warpbin}:${LD_LIBRARY_PATH}
  else
    setenv LD_LIBRARY_PATH ${warpbin}
  endif
endif
#
goto endsetup
#
errorsetup:
unsetenv warpbin
unsetenv pywarp_warpbin
unsetenv pywarp_cbin
unsetenv pywarpbin
#
endsetup:
#
#printl
#printl 'ARP/wARP Version 7.0 has been setup'
#
unalias printl
unalias runtestpython

