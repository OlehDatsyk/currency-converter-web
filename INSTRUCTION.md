# 🎬 CineSearch — Complete Beginner's Instruction Guide

Welcome! This guide assumes you have **never used Python, Git, Visual Studio Code, a terminal, virtual environments, or an API before**. Every step is spelled out — just follow along in order, top to bottom, and don't skip ahead.

By the end, you'll have a working movie search website running on your own computer.

> 💡 **Tip:** Keep this file open in one window and follow along in VS Code in another. Do the steps in order — later steps depend on earlier ones.

---

## Table of Contents

1. [What you're building](#1-what-youre-building)
2. [Installing Python](#2-installing-python)
3. [Installing Git](#3-installing-git)
4. [Installing Visual Studio Code](#4-installing-visual-studio-code)
5. [Required VS Code Extensions](#5-required-vs-code-extensions)
6. [Opening the project](#6-opening-the-project)
7. [Creating a virtual environment](#7-creating-a-virtual-environment)
8. [Activating the virtual environment](#8-activating-the-virtual-environment)
9. [Installing dependencies](#9-installing-dependencies)
10. [Creating the .env file](#10-creating-the-env-file)
11. [Getting your free TMDb API key](#11-getting-your-free-tmdb-api-key)
12. [Running the application](#12-running-the-application)
13. [Testing the application](#13-testing-the-application)
14. [Using every feature](#14-using-every-feature)
15. [Troubleshooting](#15-troubleshooting)
16. [FAQ](#16-faq)
17. [Common mistakes](#17-common-mistakes)
18. [Security recommendations](#18-security-recommendations)
19. [Next learning steps](#19-next-learning-steps)

---

## 1. What you're building

**CineSearch** is a website that runs on your own computer. It lets you:
- Search for any movie by name
- See posters, ratings, and release years in a grid
- Click a movie to see its cast, genres, description, and trailer

It's built with **Python** (using a tool called **Flask** to run a small web server) on the "backend" (the part you don't see), and **HTML/CSS/JavaScript** on the "frontend" (the part you see in your browser). Movie data comes from a free service called **TMDb** (The Movie Database).

You don't need to understand any of that yet — just follow the steps.

---

## 2. Installing Python

Python is the programming language this project is written in. Your computer doesn't come with the right version by default, so we install it first.

1. Go to **https://www.python.org/downloads/** in your web browser.
2. Click the big yellow **"Download Python 3.x.x"** button (it auto-detects Windows or Mac).
3. Run the downloaded installer.
   - **Windows:** On the very first installer screen, **check the box that says "Add python.exe to PATH"** (or "Add Python to PATH") **before** clicking Install. This step is critical — if you miss it, your terminal won't recognize the `python` command later.
   - **Mac:** Just run the installer and click through the default options (Continue → Continue → Agree → Install).
4. When installation finishes, verify it worked:
   - **Windows:** Press the `Windows` key, type `cmd`, press Enter to open Command Prompt, then type:
     ```
     python --version
     ```
   - **Mac:** Open the **Terminal** app (press `Cmd + Space`, type "Terminal", press Enter), then type:
     ```
     python3 --version
     ```
5. You should see something like `Python 3.12.x`. If you see an error instead, see [Troubleshooting](#15-troubleshooting).

> **Windows vs Mac note:** On Windows, the command is usually `python`. On Mac, it's usually `python3`. This guide will show both where it matters.

---

## 3. Installing Git

Git is a tool for tracking changes in code and downloading projects from GitHub. It's optional for just *running* this app, but useful to have.

1. Go to **https://git-scm.com/downloads**.
2. Download the installer for your operating system.
3. Run it. On Windows, click "Next" through all the default options — the defaults are fine for beginners.
4. Verify it installed by opening your terminal (Command Prompt on Windows, Terminal on Mac) and typing:
   ```
   git --version
   ```
   You should see something like `git version 2.4x.x`.

---

## 4. Installing Visual Studio Code

Visual Studio Code (VS Code) is the program you'll use to view, edit, and run the project's code.

1. Go to **https://code.visualstudio.com/**.
2. Click **Download**.
3. Run the installer and accept the defaults.
4. Open VS Code once to confirm it launches.

---

## 5. Required VS Code Extensions

Extensions add features to VS Code. Install these two:

1. Open VS Code.
2. Click the **Extensions** icon in the left sidebar (it looks like four squares, one detached).
3. Search for and install:
   - **Python** (by Microsoft) — adds Python language support, syntax highlighting, and lets VS Code find your virtual environment.
   - **Pylance** (by Microsoft) — usually installs automatically with the Python extension; if not, install it too. It gives better code suggestions and error checking.
4. (Optional but nice) **vscode-icons** — gives folders/files colorful icons, purely cosmetic.

---

## 6. Opening the project

1. Make sure the `movie-search-web` project folder is somewhere easy to find, like your Desktop or Documents folder.
2. Open VS Code.
3. Go to **File → Open Folder…** (Mac: **File → Open…**).
4. Select the `movie-search-web` folder (the one containing `app.py`, `config.py`, `templates/`, etc.) and click **Select Folder** (Mac: **Open**).
5. You should now see the file list on the left side of VS Code, including `app.py`, `config.py`, `services/`, `templates/`, `static/`.

---

## 7. Creating a virtual environment

A **virtual environment** ("venv") is an isolated, private copy of Python just for this project, so the packages this app needs don't clash with anything else on your computer. This is standard professional practice.

1. In VS Code, open the built-in terminal: **Terminal → New Terminal** (or press `` Ctrl+` `` on Windows/Linux, `` Cmd+` `` on Mac).
2. Make sure the terminal's current folder is your project folder (it should say something like `...\movie-search-web>` or `.../movie-search-web %`).
3. Run:
   - **Windows:**
     ```
     python -m venv venv
     ```
   - **Mac:**
     ```
     python3 -m venv venv
     ```
4. This creates a new folder called `venv` inside your project. This is expected and normal — it will **not** be uploaded to GitHub (it's already excluded in `.gitignore`).

---

## 8. Activating the virtual environment

"Activating" tells your terminal to use the project's private Python instead of your computer's main Python.

- **Windows (Command Prompt):**
  ```
  venv\Scripts\activate
  ```
- **Windows (PowerShell):**
  ```
  venv\Scripts\Activate.ps1
  ```
  > If PowerShell gives a "running scripts is disabled" error, see [Troubleshooting](#15-troubleshooting).
- **Mac / Linux (Terminal):**
  ```
  source venv/bin/activate
  ```

When it worked, you'll see `(venv)` appear at the start of your terminal line, like:
```
(venv) C:\Users\You\movie-search-web>
```

> ⚠️ **You must re-activate the virtual environment every time you open a new terminal window** to work on this project. VS Code sometimes does this automatically if you select the right Python interpreter (bottom-right corner of VS Code), but it's good to know how to do it manually.

---

## 9. Installing dependencies

"Dependencies" are the external code libraries this project needs (Flask, requests, python-dotenv). With your virtual environment **activated** (you should see `(venv)` in your terminal):

```
pip install -r requirements.txt
```

This reads `requirements.txt` and installs exactly the versions listed. It may take a minute. When it finishes, you'll see a list of "Successfully installed..." packages.

---

## 10. Creating the .env file

The `.env` file holds your personal secret values (like your API key) and is **never shared or uploaded to GitHub** (it's excluded via `.gitignore`).

1. In the project folder, find the file named `.env.example`.
2. Make a copy of it named exactly `.env` (no `.example` at the end):
   - **Windows (Command Prompt):**
     ```
     copy .env.example .env
     ```
   - **Mac / Linux:**
     ```
     cp .env.example .env
     ```
   - Or just do it in VS Code: right-click `.env.example` → Copy, then right-click the folder → Paste, then rename the copy to `.env`.
3. Open the new `.env` file in VS Code. You'll fill in the `TMDB_API_KEY` value in the next step.

---

## 11. Getting your free TMDb API key

TMDb (The Movie Database) is the free service that provides all the movie data. You need a free account and API key.

1. Go to **https://www.themoviedb.org/** and click **Sign Up** (top right) to create a free account.
2. Verify your email if asked.
3. Once logged in, go to **https://www.themoviedb.org/settings/api**.
4. Click **Create** (or **Request an API Key**), choose **Developer** (the free option).
5. Fill in the short form (application name, URL — you can put `http://localhost` and describe it as a "personal learning project").
6. Once approved (usually instant), copy the value labeled **"API Key (v3 auth)"** — it's a long string of letters and numbers.
7. Open your `.env` file in VS Code and paste it in:
   ```
   TMDB_API_KEY=paste_your_key_here
   ```
8. Save the file (`Ctrl+S` / `Cmd+S`).

> 🔒 Never share this key publicly or commit it to GitHub. It's tied to your account.

---

## 12. Running the application

With your virtual environment activated and `.env` filled in:

```
python app.py
```
(Mac users: if `python` doesn't work, try `python3 app.py`)

You should see output like:
```
 * Running on http://127.0.0.1:1001
```

Open your web browser and go to:
```
http://127.0.0.1:1001
```

You should see the CineSearch homepage with a grid of currently popular movies. 🎉

To stop the server, click back in the terminal and press `Ctrl + C`.

---

## 13. Testing the application

Quick checklist to confirm everything works:

- [ ] The homepage loads and shows a grid of popular movies with posters.
- [ ] Typing a movie name (e.g. "Inception") into the search bar and pressing Enter/Search shows matching results.
- [ ] Clicking a movie card opens a details popup with description, cast, and genres.
- [ ] If a trailer is available, the "Watch Trailer" button opens YouTube in a new tab.
- [ ] The sun/moon icon in the top right toggles between dark and light mode.
- [ ] Searching for gibberish (e.g. "zzzxxxqqq123") shows a friendly "No movies found" message instead of crashing.

If any of these fail, check [Troubleshooting](#15-troubleshooting) below.

---

## 14. Using every feature

| Feature | How to use it |
|---|---|
| **Browse popular movies** | Just open the homepage — it loads automatically. |
| **Search** | Type a title into the search bar at the top and press Enter or click "Search". Clearing the search box and searching again returns you to the popular list. |
| **View details** | Click anywhere on a movie's poster card (or press Tab to focus it, then Enter). |
| **Watch trailer** | Inside the details popup, click "Watch Trailer" (only enabled if TMDb has one). |
| **Close details** | Click the ✕ button, click outside the popup, or press `Esc`. |
| **Dark/Light mode** | Click the sun/moon icon in the top-right of the header. |

---

## 15. Troubleshooting

**"`python` is not recognized as an internal or external command"** (Windows)
→ Python wasn't added to PATH during install. Re-run the Python installer, choose "Modify", and make sure "Add python.exe to PATH" is checked. Or reinstall from scratch and check that box.

**"`python3: command not found`"** (Mac)
→ Try `python3` instead of `python`, or reinstall Python from python.org (the version that ships with macOS by default is often outdated or missing).

**PowerShell says "running scripts is disabled on this system"**
→ Open PowerShell **as Administrator** and run:
```
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```
Type `Y` to confirm, then try activating the virtual environment again. Or simply use Command Prompt instead of PowerShell.

**"ModuleNotFoundError: No module named 'flask'"**
→ Your virtual environment isn't activated, or dependencies weren't installed. Make sure you see `(venv)` in your terminal, then re-run `pip install -r requirements.txt`.

**The page loads but shows an error like "TMDB_API_KEY is missing"**
→ Your `.env` file either doesn't exist yet or doesn't have a valid key. Revisit [Step 10](#10-creating-the-env-file) and [Step 11](#11-getting-your-free-tmdb-api-key).

**"TMDb rejected the API key (401 Unauthorized)"**
→ Double-check you copied the entire API key with no extra spaces, and that you copied the **API Key (v3 auth)**, not the "API Read Access Token" (a different, longer value).

**Port 1001 already in use / "Address already in use"**
→ Something else on your computer is using port 1001 (on Macs, this is sometimes AirPlay Receiver). Either close that other program, or open `app.py`, find the line `app.run(debug=True, host="0.0.0.0", port=1001)` and change `1001` to another number like `5050`, then visit `http://127.0.0.1:5050` instead.

**Nothing happens when I double-click the startup script**
→ See the script-specific notes in the `Start App.bat` (Windows) or `Start App (Mac).command` (Mac) sections of this guide, and make sure you completed Steps 2–11 at least once manually first.

**The page loads but no images show up**
→ Check your internet connection — poster images are loaded live from TMDb's image servers, not stored locally.

---

## 16. FAQ

**Do I need to pay for anything?**
No. Python, VS Code, Git, and a TMDb developer API key are all free.

**Do I need to know how to code to use this app?**
No — once it's set up and running, it's just a website you use in your browser. Coding knowledge is only needed if you want to *change* how it works.

**Can I close the terminal after starting the app?**
No — closing the terminal (or pressing `Ctrl+C` in it) stops the Flask server, and the website will stop working until you start it again.

**Can other people on the internet use my running app?**
Not by default — it only runs on `127.0.0.1` (your own computer), so only you can access it via your browser. Making it accessible to others requires proper deployment, which is outside the scope of this beginner guide (see [Next learning steps](#19-next-learning-steps)).

**Do I need to redo all the setup steps every time I want to use the app?**
No. Steps 2–6 and 10–11 (installing software, creating `.env`, getting an API key) are one-time. After that, you only need to activate your virtual environment (Step 8) and run `python app.py` (Step 12) each time — or just use the provided startup scripts, which automate this.

---

## 17. Common mistakes

- **Forgetting to activate the virtual environment** before running `pip install` or `python app.py` — always check for `(venv)` in your terminal prompt first.
- **Naming the file `.env.txt` instead of `.env`** — some operating systems hide file extensions by default, so `.env` can accidentally become `.env.txt`. In VS Code, rename it directly in the file explorer to be sure.
- **Pasting the wrong TMDb key** — TMDb shows both an "API Key (v3 auth)" and an "API Read Access Token." This project needs the shorter **API Key (v3 auth)**.
- **Leaving spaces or quotes around values in `.env`** — write `TMDB_API_KEY=abc123`, not `TMDB_API_KEY = "abc123"`.
- **Editing files while the server is running and expecting it to restart on its own** — Flask's debug/auto-reload usually handles this, but if changes don't show up, stop the server (`Ctrl+C`) and run `python app.py` again.
- **Running `python app.py` from the wrong folder** — the terminal must be inside the `movie-search-web` folder itself, not a parent folder.

---

## 18. Security recommendations

- **Never commit your `.env` file to GitHub.** It's already excluded by `.gitignore`, but always double check with `git status` before pushing that `.env` isn't listed as a new/changed file.
- **Never share your TMDb API key** in screenshots, chat messages, or public forums.
- **Don't turn off debug mode carelessly, but also don't leave it on in anything other than local development** — Flask's debug mode is meant for your own computer only. If you ever deploy this app somewhere publicly reachable, debug mode must be turned off (see the security notes in `PROJECT_REVIEW.md` for specifics).
- **Keep dependencies updated periodically** by checking for newer, still-compatible versions of the packages in `requirements.txt`.
- **Generate a real random `SECRET_KEY`** instead of relying on the default placeholder if you ever move beyond local, personal use — you can generate one by running `python -c "import secrets; print(secrets.token_hex(32))"` in your terminal and pasting the result into `.env`.

---

## 19. Next learning steps

Once you're comfortable running the app, here are natural next things to learn:

1. **Learn basic Python** — freeCodeCamp and Python's own official tutorial (docs.python.org) are great free starting points.
2. **Learn how Flask routes work** — try adding a new simple route in `app.py` (e.g. `/api/health` that returns `{"status": "ok"}`) and see it appear.
3. **Learn Git basics** — `git init`, `git add`, `git commit`, and pushing to a GitHub repository, so you can save versions of your work and share it.
4. **Try adding a feature** — e.g. a "favorites" list (this would need to learn about browser storage or a small database).
5. **Learn about deployment** — services like Render, Railway, or PythonAnywhere let you put a Flask app like this online for others to use (this requires additional security hardening — see `PROJECT_REVIEW.md`).
6. **Learn automated testing** — look into `pytest` to write tests that check your code keeps working as you change it.

You now have a fully working, professionally structured Python web app on your computer — nice work getting through the full setup! 🎬
