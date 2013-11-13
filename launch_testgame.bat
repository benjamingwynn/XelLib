@echo off

echo *** Copying XelLib...
copy "xellib\*" "%CD%"
echo *** Copying XelLib components...
copy "xellib_components\*" "%CD%"
echo *** Copying extra stuff needed by XelLib...
copy "external\*" "%CD%"
echo *** Copying game...
copy "testgame\*" "%CD%"

if %PROCESSOR_ARCHITECTURE%==x86 (
  bin\love\win_x86\love.exe %CD%
) else (
  bin\love\win_x64\love.exe %CD%
)

del /q /f *.lua
del /q /f README.txt