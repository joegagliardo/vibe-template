@echo off
setlocal enabledelayedexpansion

:: 1. Set your variables
set "TRIGGER_NAME=deploy-on-tag-suffix"
set "GITHUB_OWNER="
set "REPO_NAME="

:: 2. Create/Clear a temporary processed file
if exist processed_trigger.yaml del processed_trigger.yaml

:: 3. Loop through template and replace strings
for /f "tokens=*" %%a in (trigger.yaml.tmpl) do (
    set "line=%%a"
    set "line=!line:__TRIGGER_NAME__=%TRIGGER_NAME%!"
    set "line=!line:__GITHUB_OWNER__=%GITHUB_OWNER%!"
    set "line=!line:__REPO_NAME__=%REPO_NAME%!"
    echo !line! >> processed_trigger.yaml
)

:: 4. Import the processed file
gcloud alpha builds triggers import --source=processed_trigger.yaml --region=global

:: 5. Cleanup
del processed_trigger.yaml
pause
