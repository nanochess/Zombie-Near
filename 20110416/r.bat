echo off
md %1
md %1\graficas
md %1\sprites
echo Copiando gr ficas base...
xcopy graficas\*.* %1\graficas /q
xcopy sprites\*.* %1\sprites /q
echo Copiando gr ficas compiladas...
xcopy *.dat %1 /q
echo Copiando c¢digo fuente...
xcopy zw.asm %1 /q
xcopy ia.asm %1 /q
xcopy mapa?.asm %1 /q
xcopy graficas.asm %1 /q
xcopy sprites*.asm %1 /q
xcopy sonido.asm %1 /q
xcopy musica.asm %1 /q
xcopy historia.asm %1 /q
xcopy mensajes.asm %1 /q
xcopy combina.asm %1 /q
xcopy zombnear.* %1 /q
echo Copiando utilidades...
xcopy tniasm.exe %1 /q
xcopy tniasm.txt %1 /q
xcopy gwbasic.exe %1 /q
xcopy sprites.bas %1 /q
xcopy arma.bas %1 /q
xcopy imagen.* %1 /q
xcopy crujido.* %1 /q
xcopy csprites.* %1 /q
xcopy lector.* %1 /q
xcopy imagenes.bat %1 /q
xcopy r.bat %1 /q
echo Respaldo completo :)
