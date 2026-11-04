@echo off
rem ============================================================
rem  Signal Lab launcher (Windows)
rem  Double-click this file: it opens index.html in the computer's
rem  DEFAULT browser (whatever it is). Keep it next to index.html.
rem  For full screen press F11, or use the "Fullscreen" button
rem  inside the page (works in every browser).
rem
rem  Settings:
rem   MODE=default     open with the default browser (recommended)
rem   MODE=fullscreen  look for Chrome / Edge / Firefox and start it
rem                    already full screen
rem   FIREFOX_KIOSK=1  (fullscreen mode) Firefox without window
rem                    controls; to leave it press Alt+F4
rem ============================================================
setlocal
set "MODE=default"
set "FIREFOX_KIOSK=0"

set "PAGE=%~dp0index.html"
if not exist "%PAGE%" goto nopage
set "URL=file:///%PAGE:\=/%"
if /i "%MODE%"=="default" goto default

rem ---- 1) Google Chrome ----
set "B="
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" set "B=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not defined B if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" set "B=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
if not defined B if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" set "B=%LocalAppData%\Google\Chrome\Application\chrome.exe"
if defined B goto chromium

rem ---- 2) Microsoft Edge (installed on every Windows 10/11) ----
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" set "B=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
if not defined B if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" set "B=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
if defined B goto chromium

rem ---- 3) Mozilla Firefox ----
if exist "%ProgramFiles%\Mozilla Firefox\firefox.exe" set "B=%ProgramFiles%\Mozilla Firefox\firefox.exe"
if not defined B if exist "%ProgramFiles(x86)%\Mozilla Firefox\firefox.exe" set "B=%ProgramFiles(x86)%\Mozilla Firefox\firefox.exe"
if defined B goto firefox

rem ---- 4) Nothing found: default browser ----
:default
start "" "%PAGE%"
echo Opened in the default browser.
echo For full screen press F11 or use the Fullscreen button in the page.
timeout /t 5 >nul
exit /b 0

:chromium
start "" "%B%" --start-fullscreen --new-window "%URL%"
exit /b 0

:firefox
if "%FIREFOX_KIOSK%"=="1" goto kiosk
start "" "%B%" -new-window "%URL%"
echo Opened in Firefox. Press F11 for full screen.
timeout /t 4 >nul
exit /b 0

:kiosk
start "" "%B%" -kiosk "%URL%"
exit /b 0

:nopage
echo index.html was not found next to this file:
echo   %PAGE%
echo Copy start.bat and index.html into the same folder.
pause
exit /b 1
