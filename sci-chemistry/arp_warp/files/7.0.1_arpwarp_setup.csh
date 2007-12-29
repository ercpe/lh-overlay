#
# File to be sourced from .cshrc to setup ARP/wARP environment
#
#
set namesystem = `uname`
set nameprocessor = `uname -m | sed -e 's/ //g'`
if ( $nameprocessor == 'PowerMacintosh' ) then
    set nameprocessor = `uname -p | sed -e 's/ //g'`
endif
if ( $namesystem == 'IRIX64' || $namesystem == 'IRIX' ) then
    set identifier = 'mips-IRIX64'
else
    set identifier = ${nameprocessor}'-'${namesystem}
endif
#
set arpwarphome = '/usr/lib/arp_warp-7.0.1'
#
setenv warpbin ${arpwarphome}/bin/bin-${identifier}
setenv warpdoc ${arpwarphome}/manual
set path = ( $warpbin $path )
#
# Settings for python
# Checks for CBIN variable
if ( ! $?CBIN ) then
    echo
    echo 'Cannot setup ARP/wARP'
    echo 'Variable $CBIN is not defined'
    echo 'Please install CCP4 first'
    goto errorsetup
endif
if ( ! -d $CBIN ) then
    echo
    echo 'Cannot setup ARP/wARP'
    echo 'Directory $CBIN '$CBIN' does not exist'
    echo 'Please install CCP4 first'
    goto errorsetup
endif
#
# Checks for python version

###  Taking care of flex-wARP now; multiple steps :
##    1. Check if there is a 'working' python in the PATH :
set search_list = ""
python -V >& /dev/null
if ( $status == 0 ) then
    set search_list = `unalias *; which python`
endif

##    2. Complement by other potential places for python :
set search_list = "${search_list} /usr/local/bin/python /usr/bin/python"
setenv flex_wARP_python "/dev/null"

##    3. Pick up the first one of the list which seems reasonable :
foreach python_to_test ( ${search_list} )
#        3.a The file exists, is executable and returns a proper value with '-V':
    ${python_to_test} -V >& /dev/null
    if ( 0 != $status ) then
        continue
    endif
    set infomessage = ` ${python_to_test} -V |& tail -1 | sed -e 's/\./ /g' `
    set pythonvrs1 = ` echo $infomessage | awk '{print $2}' `
    set pythonvrs2 = ` echo $infomessage | awk '{print $3}' `
#        3.b If the byte-code is ready for this version.
    if ( -e ${arpwarphome}/byte-code/python-${pythonvrs1}.${pythonvrs2}/CPyWARP.pyc ) then
        setenv flex_wARP_python ${python_to_test}
        setenv flex_wARP_bin ${arpwarphome}/byte-code/python-${pythonvrs1}.${pythonvrs2}
        break
    endif
    if ( -e ${HOME}/.flex-wARP/python-${pythonvrs1}.${pythonvrs2}/CPyWARP.pyc ) then
        setenv flex_wARP_python ${python_to_test}
        setenv flex_wARP_bin ${HOME}/.flex-wARP/python-${pythonvrs1}.${pythonvrs2}
        break
    endif
#        3.c Otherwise, we should be able to create the byte-code using the python.
    /bin/mkdir -p ${arpwarphome}/byte-code/python-${pythonvrs1}.${pythonvrs2} >& /dev/null
    if ( 0 != $status ) then
        /bin/mkdir -p ${HOME}/.flex-wARP/python-${pythonvrs1}.${pythonvrs2} >& /dev/null
        setenv flex_wARP_bin ${HOME}/.flex-wARP/python-${pythonvrs1}.${pythonvrs2}
    else
        setenv flex_wARP_bin ${arpwarphome}/byte-code/python-${pythonvrs1}.${pythonvrs2}
    endif
    pushd ${flex_wARP_bin} >& /dev/null
    if ( 0 != $status ) then
        setenv flex_wARP_bin ${HOME}/.flex-wARP/python-${pythonvrs1}.${pythonvrs2}
        /bin/mkdir -p ${flex_wARP_bin} >& /dev/null
        pushd ${flex_wARP_bin} >& /dev/null
    endif
    /bin/cp -p ${arpwarphome}/flex-wARP-src/*.py .
    ${python_to_test} ./compile.py
    /bin/rm -f *.py
    popd >& /dev/null
    if ( -e ${flex_wARP_bin}/CPyWARP.pyc ) then
        setenv flex_wARP_python ${python_to_test}
        echo "Created a new set of flex-wARP byte code in the directory :"
        echo "  '${flex_wARP_bin}'"
        break
    endif
end
##    4. If nothing is available, print out a message.
if ( "/dev/null" != ${flex_wARP_python} ) then
    setenv flex_wARP_warpbin $warpbin
    setenv flex_wARP_cbin $CBIN
else
    echo
    echo "WARNING while setting up ARP/wARP"
    echo "No valid 'python' command was found"
    echo "flex-warp ('ARP/wARP Expert System' in the GUI) will not be available."
    echo
    setenv flex_wARP_warpbin "Unavailable"
    setenv flex_wARP_cbin "Unavailable"
    setenv flex_wARP_python "/dev/null"
    setenv flex_wARP_bin "Unavailable"
endif

#
# Setting up library path for SGI
if ( ${namesystem} == 'IRIX64' || ${namesystem} == 'IRIX' ) then
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
unsetenv flex_wARP_warpbin
unsetenv flex_wARP_cbin
unsetenv flex_wARP_bin
#
endsetup:
#
#echo
#echo 'ARP/wARP Version 7.0.1 has been setup'
#

