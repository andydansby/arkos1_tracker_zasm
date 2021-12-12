path = "C:\z88dk199c\bin"
path = "songs\"

cls

cd songs
	akstobin -a 0xC800 fuckit.aks fuckit.bin
	zx0 -f fuckit.bin fuckit.zx0
	move fuckit.bin "..\"
cd ..

bas2tap -a10 loader.bas loader.tap

z80asm.exe -v -s -m -b --split-bin main.asm 

bin2tap -o main.tap -a 32768 main.bin
bin2tap -o AKG_Player.tap -a 49152 main_AKG_ZX_Player.bin
bin2tap -o MUSIC.tap -a 51200 main_MUSIC.bin

copy /b loader.tap + main.tap + AKG_Player.tap + MUSIC.tap 1Z_output.tap


echo off

rem cleanup
@ del "loader.tap"
@ del "main.tap"
@ del "AKG_Player.tap"
@ del "MUSIC.tap"
@ del "fuckit.bin"

@ move "main.bin" "maps\"
@ move "main_AKG_ZX_Player.bin" "maps\"
@ move "main_MUSIC.bin" "maps\"

@ move "main.sym" "maps\"
@ move "main.map" "maps\"
@ move "main.o" "maps\"

echo on