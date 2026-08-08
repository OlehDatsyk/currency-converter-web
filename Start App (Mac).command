#!/bin/bash
# ============================================================
#  CineSearch - macOS Startup Script
#  Double-click this file to set up (first run) and launch
#  the app. Safe to run again any time - it will skip steps
#  that are already done.
#
#  NOTE: The first time you double-click this file, macOS may
#  block it ("cannot be opened because it is from an
#  unidentified developer"). If that happens: right-click (or
#  Control-click) this file -> Open -> click "Open" in the
#  dialog that appears. You only need to do this once.
# ============================================================

# Move into the folder this script lives in, regardless of
# where it was double-clicked from.
cd "$(dirname "$0")" || exit 1

echo "==========================================================="
echo "  CineSearch - Movie Search App (Was made by Oleh Datsyk)"
echo "==========================================================="
echo ""

# ------------------------------------------------------------
# Helper: pause and keep the Terminal window open on error
# ------------------------------------------------------------
pause_on_exit() {
    echo ""
    echo "------------------------------------------------------------"
    echo "  Press Enter to close this window."
    echo "------------------------------------------------------------"
    read -r
    exit 1
}

# ------------------------------------------------------------
# 1. Check that Python 3 is installed
# ------------------------------------------------------------
echo "[1/6] Checking for Python..."
PYTHON_CMD=""
if command -v python3 >/dev/null 2>&1; then
    PYTHON_CMD="python3"
elif command -v python >/dev/null 2>&1; then
    PYTHON_CMD="python"
fi

if [ -z "$PYTHON_CMD" ]; then
    echo ""
    echo "ERROR: Python was not found on your system."
    echo ""
    echo "Please install Python from https://www.python.org/downloads/"
    echo "and run this script again."
    echo ""
    echo "See INSTRUCTION.md, Section 2, for full step-by-step help."
    pause_on_exit
fi
echo "      Python found ($PYTHON_CMD): OK"
echo ""

# ------------------------------------------------------------
# 2. Create the virtual environment if it doesn't exist yet
# ------------------------------------------------------------
echo "[2/6] Checking for virtual environment..."
if [ ! -f "venv/bin/activate" ]; then
    echo "      No virtual environment found. Creating one now..."
    "$PYTHON_CMD" -m venv venv
    if [ ! -f "venv/bin/activate" ]; then
        echo ""
        echo "ERROR: Failed to create the virtual environment."
        echo "Please see INSTRUCTION.md, Section 7, for help."
        pause_on_exit
    fi
    echo "      Virtual environment created: OK"
else
    echo "      Virtual environment already exists: OK"
fi
echo ""

# ------------------------------------------------------------
# 3. Activate the virtual environment
# ------------------------------------------------------------
echo "[3/6] Activating virtual environment..."
# shellcheck disable=SC1091
source "venv/bin/activate"
echo "      Activated: OK"
echo ""

# ------------------------------------------------------------
# 4. Install/verify dependencies
# ------------------------------------------------------------
echo "[4/6] Checking dependencies (this may take a minute the first time)..."
python -m pip install --disable-pip-version-check -q -r requirements.txt
if [ $? -ne 0 ]; then
    echo ""
    echo "ERROR: Failed to install required packages."
    echo "Please check your internet connection and see INSTRUCTION.md, Section 9."
    pause_on_exit
fi
echo "      Dependencies installed: OK"
echo ""

# ------------------------------------------------------------
# 5. Verify the .env file exists
# ------------------------------------------------------------
echo "[5/6] Checking for .env configuration file..."
if [ ! -f ".env" ]; then
    echo ""
    echo "WARNING: No .env file was found."
    echo "The app needs a .env file with your TMDB_API_KEY to load movie data."
    echo ""
    if [ -f ".env.example" ]; then
        cp ".env.example" ".env"
        echo "A new .env file was created for you, but you still need to"
        echo "add your own free TMDb API key to it."
        echo ""
        echo "  1. Open the .env file in this folder using TextEdit or VS Code."
        echo "  2. Replace \"your_tmdb_api_key_here\" with your real key."
        echo "  3. Save the file, then run this script again."
        echo ""
        echo "See INSTRUCTION.md, Section 11, for how to get a free API key."
        pause_on_exit
    else
        echo "ERROR: .env.example is also missing. Cannot continue."
        echo "Please restore the project files and try again."
        pause_on_exit
    fi
else
    echo "      .env file found: OK"
fi
echo ""

# ------------------------------------------------------------
# 6. Launch the application
# ------------------------------------------------------------
echo "[6/6] Starting CineSearch..."
echo ""
echo "------------------------------------------------------------"
echo "  The app will start below. Once you see a line like:"
echo "      * Running on http://127.0.0.1:1001"
echo "  open that address in your web browser."
echo ""
echo "  To stop the app, come back to this window and press"
echo "  CTRL + C, or simply close this window."
echo "------------------------------------------------------------"
echo ""

python app.py
APP_EXIT_CODE=$?

# ------------------------------------------------------------
# If we reach here, the app exited or crashed - keep the
# window open so the user can read any error messages.
# ------------------------------------------------------------
echo ""
echo "------------------------------------------------------------"
echo "  The app has stopped (exit code $APP_EXIT_CODE)."
echo "  If this was unexpected, scroll up to read any error"
echo "  messages above, or see INSTRUCTION.md, Section 15"
echo "  (Troubleshooting)."
echo "------------------------------------------------------------"
echo ""
echo "Press Enter to close this window."
read -r
