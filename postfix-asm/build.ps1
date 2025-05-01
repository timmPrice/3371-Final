$env:Path = "C:\masm32\bin;$env:Path"
$env:INCLUDE = "C:\masm32\include"
$env:LIB = "C:\masm32\lib"

# Assemble and link
ml.exe /c /coff /Cp extra.asm
link.exe /SUBSYSTEM:CONSOLE extra.obj kernel32.lib user32.lib msvcrt.lib
