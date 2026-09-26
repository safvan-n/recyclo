@echo off
title ReCyclo – Turning Waste into Worth
echo ===================================================
echo   Starting ReCyclo Mobile Application Server...
echo ===================================================
cd /d "%~dp0"
start "" http://localhost:8080
python -m http.server 8080
pause
