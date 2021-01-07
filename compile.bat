@echo off
setlocal

if %1.==. goto error

:compile
    
    set _filename=%~n1
    set _extension=%~x1
    set _dir=%cd%
    
    echo Compile Kickass
    java -jar d:/mega65/kickassembler/Kickass.jar -odir build %1
    REM d:/mega65/kickassembler/KickAss.exe -odir build "%_dir%\\"%1
    
    echo Send %~n1.prg to Mega65
    d:/mega65/m65/m65.exe -l COM4 -F -r build/%~n1.prg


:error
    echo file input needed
:end
    endlocal

