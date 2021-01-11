@echo off
setlocal

if %1.==. goto error

:compile
    
    set _filename=%~n1
    set _extension=%~x1
    set _dir=%cd%
    
    echo Compile Kickass
    java -jar d:/mega65/kickassembler/Kickass.jar -odir build %1
    
    if [%2]==[m65] ( 
        echo Send %~n1.prg to Mega65 
        d:/mega65/m65/m65.exe -l COM4 -F -r build/%~n1.prg 
    )
 
    if [%2]==[xemu] ( 
        echo Send %~n1.prg to XEMU 
        d:/mega65/xemu/dev/xmega65.exe  -prg build/%~n1.prg 
        REM d:/mega65/xemu/hernan/xmega65.exe  -prg build/%~n1.prg 
    )
    )
    


    goto end

:error
    echo file input needed
:end
    endlocal

