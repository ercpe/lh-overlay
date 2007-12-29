#
# File to be sourced from .bashrc to setup ARP/wARP environment
#
alias printl="echo"
alias runtestpython="python -V"
#
namesystem=`uname`
nameprocessor=`uname -m | sed -e 's/ //g'`
if [[ "$nameprocessor" = 'PowerMacintosh' || "$namesystem" = 'IRIX64' ]]; then
  nameprocessor=`uname -p | sed -e 's/ //g'`
fi
identifier=${nameprocessor}'-'${namesystem}
#
arpwarphome="/usr/lib/arp_warp_7.0"
#
export warpbin=${arpwarphome}/bin/bin-${identifier}
export warpdoc=${arpwarphome}/manual
export PATH=${warpbin}:${PATH}
#
testccp='0'
#
# Checks for CBIN variable
if [ "$CBIN" = "" ]; then
  printl
  printl "Cannot setup ARP/wARP"
  printl 'Variable $CBIN is not defined'
  printl "Please install CCP4 first"
  testccp='1'
fi
if [ "$testccp" = '0' ]; then
  if [ ! -d $CBIN ]; then
    printl
    printl "Cannot setup ARP/wARP"
    printl 'Directory $CBIN '$CBIN' does not exist'
    printl "Please install CCP4 first"
    testccp='1'
  fi
fi
#
if [ "$testccp" = '0' ]; then
#
# Checks for python version
  runtestpython >& /dev/null
  if [ "$?" != '0' ]; then
    printl
    printl "WARNING while setting up ARP/wARP"
    printl "'python' command is not available"
    printl "flex-warp ('ARP/wARP Expert System' in the GUI) will not be installed"
  else
    infomessage=`runtestpython 2>&1 | tail -1 | awk '{print $NF}'`
    pythonvrs1=`printl $infomessage | sed -e 's/\./ /g' | awk '{print $1}'`
    pythonvrs2=`printl $infomessage | sed -e 's/\./ /g' | awk '{print $2}'`
    pythoncode=`ls $arpwarphome"/byte-code"`
    pythonneeded="python-"$pythonvrs1'.'$pythonvrs2
    ic="0"
    for CODE in $pythoncode; do
      CODE=`printl $CODE | sed -e 's|/||g'`
	    if [ "$CODE" = "$pythonneeded" ]; then
        ic="1"
      fi
    done
    if [ "$ic" = "1" ]; then
      pythontouse=${arpwarphome}"/byte-code/"${pythonneeded}
    else
      printl
      printl "WARNING while setting up ARP/wARP"
      printl "ARP/wARP does not have executables for python-"$pythonvrs1"."$pythonvrs2
      printl "flex-warp ('ARP/wARP Expert System' in the GUI) will not be installed"
      printl "Please re-install ARP/wARP, this will create required executables"
    fi
    export pywarp_warpbin=/usr/lib/arp_warp_7.0/bin/bin-${identifier}
    export pywarp_cbin=$CBIN
    export pywarpbin=$pythontouse
  fi   
#
# Setting up library path for SGI
if [ "${identifier}" = 'mips-IRIX64' ]; then
  if test "$LD_LIBRARY_PATH"; then
    export LD_LIBRARY_PATH=${warpbin}:${LD_LIBRARY_PATH}
  else
    export LD_LIBRARY_PATH=${warpbin}
  fi
fi
#  printl
#  printl 'ARP/wARP Version 7.0 has been setup'
fi
#
unalias printl
unalias runtestpython


