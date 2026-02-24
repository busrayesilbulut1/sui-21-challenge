Day 0: Setup \& Getting Started

Welcome to the 21-Day Sui Move Challenge! Before you start coding, let's set up your development environment.



What You'll Set Up

✅ Sui CLI (command-line tool)

✅ Code editor (VS Code recommended)

✅ Terminal basics

✅ Your first build and test

Time needed: 20-30 minutes



Step 1: Install Sui CLI

The Sui CLI is the main tool you'll use to build and test Move code.



Recommended Method: Using suiup (All Platforms)

suiup is the official Sui installer and version manager. It works on macOS, Linux, and Windows (via WSL).



Step 1.1: Install suiup

Open Terminal and run:



curl -sSfL https://raw.githubusercontent.com/Mystenlabs/suiup/main/install.sh | sh

This downloads and installs the suiup tool.



Step 1.2: Install Sui CLI

After suiup is installed, run:



suiup install sui@testnet

Note: This installs Sui for testnet. If you need a different version, check the suiup repository.



Windows-Specific Instructions

Windows users: First install WSL2 (Windows Subsystem for Linux):



Open PowerShell as Administrator

Run: wsl --install

Restart your computer

Open Ubuntu from Start menu

Follow the suiup installation steps above in Ubuntu terminal

NixOS-Specific Instructions

NixOS users: Instead of using suiup, you can use the flake.nix shipped with this repository.



Easiest way to use the flake is running the command nix develop.



Verify Installation

After installation, verify it worked:



sui --version

You should see something like: sui 1.x.x-testnet



Troubleshooting

"command not found" error?



The Sui binaries directory might not be in your PATH. Try:



\# Reload your shell configuration

source ~/.bashrc   # For bash

\# or

source ~/.zshrc    # For zsh



\# Then try again

sui --version

Still not working?



Close and reopen your terminal completely

Check if suiup installed correctly: which suiup

See detailed troubleshooting: Sui Installation Docs

Alternative: Manual Installation (Advanced)

If suiup doesn't work, you can install via cargo:



\# Install Rust first

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source $HOME/.cargo/env



\# Install Sui CLI

cargo install --locked --git https://github.com/MystenLabs/sui.git --branch testnet sui

Note: This method takes 10-15 minutes and requires more disk space.



Step 2: Install VS Code (Code Editor)

VS Code is a free code editor that works great with Move.



Download \& Install

Go to: https://code.visualstudio.com/

Download for your operating system

Install and open VS Code

Install Move Extension

Open VS Code

Click the Extensions icon (4 squares) on the left sidebar

Search for "Move"

Install the "Move" extension by Mysten Labs

Benefits:



Syntax highlighting (colors for code)

Auto-completion

Error detection

Step 3: Understanding Terminal Basics

The terminal (also called command line) is where you'll run commands.



Opening Terminal

macOS:



Press Cmd + Space

Type "Terminal"

Press Enter

Linux:



Press Ctrl + Alt + T

Windows (WSL):



Open "Ubuntu" from Start menu

Basic Commands

\# Show current directory

pwd



\# List files in current directory

ls



\# Change directory

cd folder\_name



\# Go to parent directory

cd ..



\# Go to home directory

cd ~

Practice

Try these commands:



\# Navigate to your Desktop

cd ~/Desktop



\# See where you are

pwd



\# List files

ls

Step 4: Clone or Download This Project

Option A: Using Git (Recommended)

If you have Git installed:



cd ~/Desktop

git clone \[repository-url]

cd 21Challenge

Option B: Download ZIP

Download the project as ZIP

Extract to your Desktop

Open Terminal and navigate:

cd ~/Desktop/21Challenge

Step 5: Your First Build \& Test

Let's make sure everything works!



Navigate to Day 1

cd day\_01

Understanding this command:



cd = change directory (move to a folder)

day\_01 = the folder name

Build the Code

sui move build

What this does: Compiles (translates) your Move code into a format Sui can understand.



Expected output:



BUILDING day\_01

Build successful

If you see errors: Check TROUBLESHOOTING.md in the project root.



Run Tests

sui move test

What this does: Runs all test functions to verify code works correctly.



Expected output:



Running Move unit tests

Test result: OK. Total tests: 0; passed: 0; failed: 0

Note: Day 1 has no tests yet, that's normal!



Step 6: Open Project in VS Code

Open from Terminal

While in the 21Challenge folder:



code .

Note: The . means "current directory"



Or Open Manually

Open VS Code

Click "File" → "Open Folder"

Navigate to 21Challenge

Click "Open"

Explore the Structure

In VS Code's sidebar, you'll see:



21Challenge/

├── README.md

├── day\_01/

│   ├── README.md

│   ├── Move.toml

│   └── sources/

│       └── main.move

├── day\_02/

...

Step 7: Understanding the Workflow

For each day, you'll follow this pattern:



1\. Navigate to the Day's Folder

cd day\_01

2\. Read the README

cat README.md

Or open it in VS Code.



3\. Open the Code File

Open sources/main.move in VS Code.



4\. Complete the TODOs

Look for comments like:



// TODO: Your task here

5\. Build After Changes

sui move build

Fix any errors before moving to the next step.



6\. Run Tests

sui move test

All tests should pass ✅



7\. Commit Your Work

git add .

git commit -m "Day 1: completed"

Common Questions

Q: Which terminal should I use?

macOS/Linux: Built-in Terminal is perfect Windows: WSL Ubuntu terminal (after installing WSL)



Q: Do I need to know Rust?

No! Move has some similarities to Rust, but you'll learn Move from scratch.



Q: Can I use a different editor?

Yes! VS Code is recommended, but you can use:



Vim/Neovim with Move plugins

Any text editor (but no syntax highlighting)

Q: How much time per day?

Plan for 1-2 hours per day:



15-30 min reading

30-60 min coding

5-10 min testing

Q: Can I skip days?

Not recommended! Each day builds on previous days. If you skip, you'll miss important concepts.



Q: What if I get stuck?

Re-read the day's README

Check TROUBLESHOOTING.md

Look at sources/solution.move (but try first!)

Check Move Book links provided

Checklist: Are You Ready?

Before starting Day 1, make sure:



&nbsp;sui --version works

&nbsp;VS Code is installed with Move extension

&nbsp;You can navigate with cd in terminal

&nbsp;sui move build works in day\_01

&nbsp;You understand the daily workflow

All checked? You're ready! Go to day\_01/README.md and start learning!



Next Steps

Go to day\_01 folder: cd day\_01

Read the README: cat README.md or open in VS Code

Start coding!

Need Help?

If you get stuck or have questions:



WhatsApp Community: Join our support group

X (Twitter): @ercandotsui

Don't hesitate to ask questions - we're here to help!



Happy learning!

