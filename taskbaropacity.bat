@echo off
cls

:OPTIONS
echo.
echo TaskbarOpacity v1.1 EN
echo Description: Adjusts Windows 10 taskbar transparency level.
echo Requirements: Windows 10 version 1803 or above, activated.
echo Author: vhanla
echo.
echo Input valur from 0 to 255 transparency level:
echo.
set /P opa=">
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v TaskbarAcrylicOpacity /t REG_DWORD /d %opa% /f
rem The following registry values must be updated too
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v ColorPrevalence /t REG_DWORD /d 0 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v EnableTransparency /t REG_DWORD /d 1 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /v SystemUsesLightTheme /t REG_DWORD /d 0 /f

echo Stopping explorer.exe process (taskbar parent):
tasklist /FI "IMAGENAME eq explorer.exe" /FO table
echo.
rem csv
taskkill /f /im explorer.exe && start explorer.exe
echo.
echo Explorer should have restarted, otherwise...
set res=
set /P res=Restart Explorer again [y/n]?
if "%res%"=="y" (
  echo Starting explorer...
  start explorer.exe
)