@echo off
REM ============================================================
REM  CineSearch - Windows Startup Script
REM  Double-click this file to set up (first run) and launch
REM  the app. Safe to run again any time - it will skip steps
REM  that are already done.
REM ============================================================

title CineSearch - Starting...
cd /d "%~dp0"

echo ===========================================================
echo   CineSearch - Movie Search App (Was made by Oleh Datsyk)
echo ===========================================================
echo.

REM ------------------------------------------------------------
REM 1. Check that Python is installed and on PATH
REM ------------------------------------------------------------
echo [1/6] Checking for Python...
where python >nul 2>nul
if errorlevel 1 (
    echo.
    echo ERROR: Python was not found on your system.
    echo.
    echo Please install Python from https://www.python.org/downloads/
    echo IMPORTANT: During installation, check the box that says
    echo            "Add python.exe to PATH" before clicking Install.
    echo.
    echo See INSTRUCTION.md, Section 2, for full step-by-step help.
    echo.
    pause
    exit /b 1
)
echo       Python found: OK
echo.

REM ------------------------------------------------------------
REM 2. Create the virtual environment if it doesn't exist yet
REM ------------------------------------------------------------
echo [2/6] Checking for virtual environment...
if not exist "venv\Scripts\activate.bat" (
    echo       No virtual environment found. Creating one now...
    python -m venv venv
    if errorlevel 1 (
        echo.
        echo ERROR: Failed to create the virtual environment.
        echo Please see INSTRUCTION.md, Section 7, for help.
        echo.
        pause
        exit /b 1
    )
    echo       Virtual environment created: OK
) else (
    echo       Virtual environment already exists: OK
)
echo.

REM ------------------------------------------------------------
REM 3. Activate the virtual environment
REM ------------------------------------------------------------
echo [3/6] Activating virtual environment...
call "venv\Scripts\activate.bat"
if errorlevel 1 (
    echo.
    echo ERROR: Could not activate the virtual environment.
    echo Please see INSTRUCTION.md, Section 8, for help.
    echo.
    pause
    exit /b 1
)
echo       Activated: OK
echo.

REM ------------------------------------------------------------
REM 4. Install/verify dependencies
REM ------------------------------------------------------------
echo [4/6] Checking dependencies (this may take a minute the first time)...
python -m pip install --disable-pip-version-check -q -r requirements.txt
if errorlevel 1 (
    echo.
    echo ERROR: Failed to install required packages.
    echo Please check your internet connection and see INSTRUCTION.md, Section 9.
    echo.
    pause
    exit /b 1
)
echo       Dependencies installed: OK
echo.

REM ------------------------------------------------------------
REM 5. Verify the .env file exists
REM ------------------------------------------------------------
echo [5/6] Checking for .env configuration file...
if not exist ".env" (
    echo.
    echo WARNING: No .env file was found.
    echo The app needs a .env file with your TMDB_API_KEY to load movie data.
    echo.
    echo Creating .env from .env.example now...
    if exist ".env.example" (
        copy /y ".env.example" ".env" >nul
        echo.
        echo A new .env file was created for you, but you still need to
        echo add your own free TMDb API key to it.
        echo.
        echo   1. Open the ".env" file in this folder using Notepad or VS Code.
        echo   2. Replace "your_tmdb_api_key_here" with your real key.
        echo   3. Save the file, then run this script again.
        echo.
        echo See INSTRUCTION.md, Section 11, for how to get a free API key.
        echo.
        pause
        exit /b 1
    ) else (
        echo ERROR: .env.example is also missing. Cannot continue.
        echo Please restore the project files and try again.
        echo.
        pause
        exit /b 1
    )
) else (
    echo       .env file found: OK
)
echo.

REM ------------------------------------------------------------
REM 6. Launch the application
REM ------------------------------------------------------------
echo [6/6] Starting CineSearch...
echo.
echo ------------------------------------------------------------
echo   The app will start below. Once you see a line like:
echo       * Running on http://127.0.0.1:1001
echo   open that address in your web browser.
echo.
echo   To stop the app, come back to this window and press
echo   CTRL + C, or simply close this window.
echo ------------------------------------------------------------
echo.

python app.py

REM ------------------------------------------------------------
REM If we reach here, the app exited or crashed - keep the
REM window open so the user can read any error messages.
REM ------------------------------------------------------------
echo.
echo ------------------------------------------------------------
echo   The app has stopped.
echo   If this was unexpected, scroll up to read any error
echo   messages above, or see INSTRUCTION.md, Section 15
echo   (Troubleshooting).
echo ------------------------------------------------------------
pause
