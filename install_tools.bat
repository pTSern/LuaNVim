@echo off
setlocal enabledelayedexpansion

:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] This script requires administrative privileges.
    echo Please right-click and "Run as Administrator".
    pause
    exit /b 1
)

:: Check if Chocolatey is installed
echo [*] Checking for Chocolatey...
where choco >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Chocolatey not found. Installing...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
    if %errorLevel% neq 0 (
        echo [!] Failed to install Chocolatey. Please install it manually from https://chocolatey.org/install
        pause
        exit /b 1
    )
    echo [+] Chocolatey installed successfully.
    :: Refresh environment variables for the current session
    set "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
) else (
    echo [+] Chocolatey is already installed.
)

:: Install tools
echo [*] Installing required tools...

set "TOOLS=git ripgrep fd fzf cmake sed tokei bat jq git-delta du-dust xh sd"

for %%T in (%TOOLS%) do (
    echo [*] Installing %%T...
    choco install %%T -y
)

echo.
echo [+] All tools installed successfully!
echo [!] Please restart your terminal/Neovim for changes to take effect.
pause
