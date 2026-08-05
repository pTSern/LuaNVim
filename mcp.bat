@echo off
setlocal EnableDelayedExpansion

echo ==========================================
echo    GitHub MCP Generator for Neovim
echo ==========================================
echo.

set /p TOKEN="what is your github access token: "

if "%TOKEN%"=="" (
    echo.
    echo [ERROR] Token cannot be empty. Exiting...
    pause
    exit /b 1
)

:: Set paths (Neovim config directory and current directory)
set "NVIM_DIR=%LOCALAPPDATA%\nvim"
set "TARGET_FILE=%NVIM_DIR%\mcp.json"

:: Create Neovim folder if it doesn't exist
if not exist "%NVIM_DIR%" mkdir "%NVIM_DIR%"

:: Write mcp.json
(
    echo {
    echo   "mcpServers": {
    echo     "github": {
    echo       "command": "cmd.exe",
    echo       "args": [
    echo         "/c",
    echo         "npx",
    echo         "-y",
    echo         "@modelcontextprotocol/server-github"
    echo       ],
    echo       "env": {
    echo         "GITHUB_PERSONAL_ACCESS_TOKEN": "%TOKEN%"
    echo       }
    echo     }
    echo   }
    echo }
) > "%TARGET_FILE%"

:: Create a copy in current directory as well
copy "%TARGET_FILE%" "%CD%\mcp.json" >nul

echo.
echo [SUCCESS] mcp.json generated successfully!
echo Configured path: %TARGET_FILE%
echo Local copy created: %CD%\mcp.json
echo.
pause
