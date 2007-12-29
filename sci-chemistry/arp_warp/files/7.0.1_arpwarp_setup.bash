#
# File to be sourced from .bashrc to setup ARP/wARP environment
#
#
namesystem=`uname`
nameprocessor=`uname -m | sed -e 's/ //g'`
if [ "$nameprocessor" = 'PowerMacintosh' ]; then
    nameprocessor=`uname -p | sed -e 's/ //g'`
fi
if [[ "$namesystem" = 'IRIX64' || "$namesystem" = 'IRIX' ]]; then
    identifier = 'mips-IRIX64'
else
    identifier=${nameprocessor}'-'${namesystem}
fi
#
arpwarphome="/usr/lib/arp_warp-7.0.1"
#
export warpbin=${arpwarphome}/bin/bin-${identifier}
export warpdoc=${arpwarphome}/manual
export PATH=${warpbin}:${PATH}
#
testccp='0'
#
# Checks for CBIN variable
if [ "$CBIN" = "" ]; then
    echo
    echo "Cannot setup ARP/wARP"
    echo 'Variable $CBIN is not defined'
    echo "Please install CCP4 first"
    testccp='1'
fi
if [ "$testccp" = '0' ]; then
    if [ ! -d $CBIN ]; then
        echo
        echo "Cannot setup ARP/wARP"
        echo 'Directory $CBIN '$CBIN' does not exist'
        echo "Please install CCP4 first"
        testccp='1'
    fi
fi
#
if [ "$testccp" = '0' ]; then
###  Taking care of flex-wARP now; multiple steps :
##    1. Check if there is a 'working' python in the PATH :
    search_list=""
    python -V 1>/dev/null 2>&1
    if [ $? == 0 ] ; then
        search_list=$( unalias -a ; which python )
    fi

##    2. Complement by other potential places for python :
    search_list="${search_list} /usr/local/bin/python /usr/bin/python"
    flex_wARP_python="/dev/null"

##    3. Pick up the first one of the list which seems reasonable :
    for python_to_test in ${search_list} ; do
#           3.a The file exists, is executable and returns a proper value with '-V':
        ${python_to_test} -V 1> /dev/null 2>&1
        if [ 0 != $? ] ; then 
            continue
        fi
        infomessage=$( ${python_to_test} -V 2>&1 | tail -1 | sed -e 's/\./ /g' )
        pythonvrs1=$( echo $infomessage | awk '{print $2}' )
        pythonvrs2=$( echo $infomessage | awk '{print $3}' )
#        3.b If the byte-code is ready for this version.
        if [ -e ${arpwarphome}/byte-code/python-${pythonvrs1}.${pythonvrs2}/CPyWARP.pyc ] ; then
            export flex_wARP_python=${python_to_test}
            export flex_wARP_bin=${arpwarphome}/byte-code/python-${pythonvrs1}.${pythonvrs2}
            break
        fi
        if [ -e ${HOME}/.flex-wARP/python-${pythonvrs1}.${pythonvrs2}/CPyWARP.pyc ] ; then
            export flex_wARP_python=${python_to_test}
            export flex_wARP_bin=${HOME}/.flex-wARP/python-${pythonvrs1}.${pythonvrs2}
            break
        fi
#        3.c Otherwise, we should be able to create the byte-code using the python.
        /bin/mkdir -p ${arpwarphome}/byte-code/python-${pythonvrs1}.${pythonvrs2} 1> /dev/null 2>&1
        if [ 0 != $? ] ; then
            /bin/mkdir -p ${HOME}/.flex-wARP/python-${pythonvrs1}.${pythonvrs2} 1> /dev/null 2>&1
            export flex_wARP_bin=${HOME}/.flex-wARP/python-${pythonvrs1}.${pythonvrs2}
        else
            export flex_wARP_bin=${arpwarphome}/byte-code/python-${pythonvrs1}.${pythonvrs2}
        fi
        pushd ${flex_wARP_bin} 1> /dev/null 2>&1
        if [ 0 != $? ] ; then 
            export flex_wARP_bin=${HOME}/.flex-wARP/python-${pythonvrs1}.${pythonvrs2}
            /bin/mkdir -p ${flex_wARP_bin} 1> /dev/null 2>&1
            pushd ${flex_wARP_bin} 1> /dev/null 2>&1
        fi
        /bin/cp -p ${arpwarphome}/flex-wARP-src/*.py .
        ${python_to_test} ./compile.py
        /bin/rm -f *.py
        popd 1> /dev/null 2>&1
        if [ -e ${flex_wARP_bin}/CPyWARP.pyc ] ; then
            export flex_wARP_python=${python_to_test}
            echo "Created a new set of flex-wARP byte code in the directory :"
            echo "  '${flex_wARP_bin}'"
            break
        fi
    done
##    4. If nothing is available, print out a message.
    if [ "/dev/null" != ${flex_wARP_python} ] ; then
        export flex_wARP_warpbin=$warpbin
        export flex_wARP_cbin=$CBIN
    else
        echo
        echo "WARNING while setting up ARP/wARP"
        echo "No valid 'python' command was found"
        echo "flex-warp ('ARP/wARP Expert System' in the GUI) will not be available."
        echo
        export flex_wARP_warpbin="Unavailable"
        export flex_wARP_cbin="Unavailable"
        export flex_wARP_python="/dev/null"
        export flex_wARP_bin="Unavailable"
    fi
fi

#
# Setting up library path for SGI
if [[ "${namesystem}" = 'IRIX64' || "${namesystem}" = 'IRIX' ]]; then
    if test "$LD_LIBRARY_PATH"; then
        export LD_LIBRARY_PATH=${warpbin}:${LD_LIBRARY_PATH}
    else
        export LD_LIBRARY_PATH=${warpbin}
    fi
fi
#   echo
#   echo 'ARP/wARP Version 7.0.1 has been setup'
#


