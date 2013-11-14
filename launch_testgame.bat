@echo off

echo *** Copying game...
copy "testgame\*.lua" "%CD%"

if %PROCESSOR_ARCHITECTURE%==x86 (
  bin\love\win_x86\love.exe %CD%
) else (
  bin\love\win_x64\love.exe %CD%
)

del /q /f *.lua
del /q /f README.txt