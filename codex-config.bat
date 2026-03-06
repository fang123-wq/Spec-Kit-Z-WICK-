@echo off
setlocal EnableExtensions DisableDelayedExpansion

set "CONFIG_DIR=%USERPROFILE%\.codex"
set "CONFIG_FILE=%CONFIG_DIR%\config.toml"
set "AUTH_FILE=%CONFIG_DIR%\auth.json"
set "BACKUP_CONFIG=%USERPROFILE%\codex-config.config.toml.bak"
set "BACKUP_AUTH=%USERPROFILE%\codex-config.auth.json.bak"

if not exist "%CONFIG_DIR%" mkdir "%CONFIG_DIR%"

set "API_KEY=%~1"
if not "%~1"=="" goto validate_key

set "TRY_COUNT=0"
:prompt_api_key
set /a TRY_COUNT+=1
set "API_KEY="
set /p API_KEY=Please enter your API KEY: 
if errorlevel 1 goto no_input
if "%API_KEY%"=="" goto empty_key
goto validate_key

:no_input
echo Error: No input detected. Exiting.
echo.
echo Press any key to exit...
pause >nul
exit /b 1

:empty_key
echo Error: API KEY cannot be empty. Please try again.
if %TRY_COUNT% GEQ 3 goto too_many_tries
goto prompt_api_key

:too_many_tries
echo.
echo Press any key to exit...
pause >nul
exit /b 1

:validate_key
if /I not "%API_KEY:~0,3%"=="clp" goto bad_key
goto do_update

:bad_key
echo Error: API KEY must start with clp. Please get it from dashboard.
echo CN: API KEY must start with clp, get it from Dashboard.
echo.
echo Press any key to exit...
pause >nul
exit /b 1

:do_update
if exist "%CONFIG_FILE%" copy /y "%CONFIG_FILE%" "%BACKUP_CONFIG%" >nul
if exist "%AUTH_FILE%" copy /y "%AUTH_FILE%" "%BACKUP_AUTH%" >nul

set "TMP_PS=%TEMP%\codex-config-update-%RANDOM%-%RANDOM%.ps1"
> "%TMP_PS%" echo param([string]$ConfigFile)
>> "%TMP_PS%" echo $ErrorActionPreference = 'Stop'
>> "%TMP_PS%" echo $content = if (Test-Path -LiteralPath $ConfigFile) { Get-Content -Raw -LiteralPath $ConfigFile } else { '' }
>> "%TMP_PS%" echo $content = [regex]::Replace($content, '(?m)^\s*model_provider\s*=.*\r?\n?', '')
>> "%TMP_PS%" echo $content = [regex]::Replace($content, '(?m)^\s*model\s*=.*\r?\n?', '')
>> "%TMP_PS%" echo $content = [regex]::Replace($content, '(?m)^\s*model_reasoning_effort\s*=.*\r?\n?', '')
>> "%TMP_PS%" echo $content = [regex]::Replace($content, '(?m)^\s*disable_response_storage\s*=.*\r?\n?', '')
>> "%TMP_PS%" echo $inProvider = $false
>> "%TMP_PS%" echo $out = New-Object System.Collections.Generic.List[string]
>> "%TMP_PS%" echo foreach ($ln in ($content -split "`r?`n")) { if (-not $inProvider -and $ln -match '^\[model_providers\.codex-for-me\]\s*$') { $inProvider=$true; continue }; if ($inProvider -and $ln -match '^\[.*\]\s*$') { $inProvider=$false; $out.Add($ln); continue }; if (-not $inProvider) { $out.Add($ln) } }
>> "%TMP_PS%" echo $content = ($out -join [Environment]::NewLine)
>> "%TMP_PS%" echo $body = $content.Trim()
>> "%TMP_PS%" echo $lines = New-Object System.Collections.Generic.List[string]
>> "%TMP_PS%" echo $lines.Add('model_provider = "codex-for-me"')
>> "%TMP_PS%" echo $lines.Add('model = "gpt-5.3-codex"')
>> "%TMP_PS%" echo $lines.Add('model_reasoning_effort = "high"')
>> "%TMP_PS%" echo $lines.Add('disable_response_storage = false')
>> "%TMP_PS%" echo if ($body -ne '') { $lines.Add(''); foreach ($ln in ($body -split "`r?`n")) { $lines.Add($ln) } }
>> "%TMP_PS%" echo $lines.Add('')
>> "%TMP_PS%" echo $lines.Add('[model_providers.codex-for-me]')
>> "%TMP_PS%" echo $lines.Add('name = "codex-for-me"')
>> "%TMP_PS%" echo $lines.Add('base_url = "https://api-vip.codex-for.me/v1"')
>> "%TMP_PS%" echo $lines.Add('wire_api = "responses"')
>> "%TMP_PS%" echo $lines.Add('requires_openai_auth = true')
>> "%TMP_PS%" echo Set-Content -LiteralPath $ConfigFile -Value ($lines -join [Environment]::NewLine) -Encoding UTF8

powershell -NoProfile -ExecutionPolicy Bypass -File "%TMP_PS%" -ConfigFile "%CONFIG_FILE%"
set "PS_RC=%ERRORLEVEL%"
if exist "%TMP_PS%" del /q "%TMP_PS%"
if not "%PS_RC%"=="0" goto update_failed

(
echo {
echo "OPENAI_API_KEY": "%API_KEY%"
echo }
) > "%AUTH_FILE%"

echo.
echo Configuration completed successfully!
echo.
echo Backup files:
echo   "%BACKUP_CONFIG%"
echo   "%BACKUP_AUTH%"
echo.
echo Press any key to exit...
pause >nul
exit /b 0

:update_failed
echo Error: failed to update "%CONFIG_FILE%".
echo.
echo Press any key to exit...
pause >nul
exit /b 1