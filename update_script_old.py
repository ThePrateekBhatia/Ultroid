#!/usr/bin/env python3
"""
Ultroid Update Script
This script handles updating the bot while it's not running.
"""

import os
import sys
import subprocess
import time
from pathlib import Path

def run_command(cmd, shell=True):
    """Run a command and return success status."""
    try:
        result = subprocess.run(cmd, shell=shell, capture_output=True, text=True)
        print(f"Command: {cmd}")
        print(f"Output: {result.stdout}")
        if result.stderr:
            print(f"Error: {result.stderr}")
        return result.returncode == 0
    except Exception as e:
        print(f"Error running command '{cmd}': {e}")
        return False

def main():
    """Main update function."""
    print("🔄 Starting Ultroid update process...")
    
    # Get script directory
    script_dir = Path(__file__).parent.absolute()
    os.chdir(script_dir)
    
    print(f"📁 Working directory: {script_dir}")
    
    # Check if we're in a git repository
    if not (script_dir / ".git").exists():
        print("❌ Not a git repository. Cannot update.")
        return False    
    # Get the repository URL from command line args or default to user's fork
    repo_url = sys.argv[1] if len(sys.argv) > 1 else "https://github.com/overspend1/Ultroid-fork.git"
    
    # Fetch and pull updates
    print("📥 Fetching updates from repository...")
    
    if repo_url:
        print(f"🔗 Using repository: {repo_url}")
        # Set up remote if needed
        if not run_command("git remote get-url origin"):
            run_command(f"git remote add origin {repo_url}")
        else:
            run_command(f"git remote set-url origin {repo_url}")
    
    # Fetch latest changes
    if not run_command("git fetch origin"):
        print("❌ Failed to fetch updates")
        return False
      # Get current branch
    result = subprocess.run("git branch --show-current", shell=True, capture_output=True, text=True)
    current_branch = result.stdout.strip() or "main"
    
    print(f"🌿 Current branch: {current_branch}")
      # Check for untracked files that might conflict
    print("🔍 Checking for conflicting files...")
    untracked_result = subprocess.run("git ls-files --others --exclude-standard", shell=True, capture_output=True, text=True)
    untracked_files = untracked_result.stdout.strip().split('\n') if untracked_result.stdout.strip() else []
    
    # Clean up cache files that might cause conflicts
    print("🧹 Cleaning up cache files...")
    run_command("find . -name '*.pyc' -delete")
    run_command("find . -name '__pycache__' -type d -exec rm -rf {} +")
    
    # Alternative Windows commands for cache cleanup
    run_command("for /r . %i in (*.pyc) do del \"%i\"")
    run_command("for /d /r . %d in (__pycache__) do @if exist \"%d\" rd /s /q \"%d\"")
    
    # Reset any local changes to tracked files (but preserve important configs)
    print("🔄 Resetting modified tracked files...")
    run_command("git checkout -- .")
    
    # If update_script.py is untracked and would conflict, temporarily move it
    script_moved = False
    if "update_script.py" in untracked_files:
        print("📦 Temporarily moving update script to avoid conflicts...")
        if run_command("move update_script.py update_script_temp.py"):
            script_moved = True
      # No need to stash since we reset tracked files
    # Just add untracked files to gitignore if they're problematic
    print("📝 Handling untracked files...")
    
    # Pull updates
    print("⬇️ Pulling updates...")
    if not run_command(f"git pull origin {current_branch}"):
        print("❌ Failed to pull updates")
        # Restore moved script if it was moved
        if script_moved and os.path.exists("update_script_temp.py"):
            print("🔄 Restoring update script...")
            run_command("move update_script_temp.py update_script.py")
        return False
    
    # Restore moved script if it was moved
    if script_moved and os.path.exists("update_script_temp.py"):
        print("🔄 Restoring update script...")
        run_command("move update_script_temp.py update_script.py")
    
    # Restore moved script if it was moved
    if script_moved and os.path.exists("update_script_temp.py"):
        print("🔄 Restoring update script...")
        run_command("move update_script_temp.py update_script.py")
    
    # Update dependencies
    print("📦 Installing/updating dependencies...")
    if not run_command("pip3 install -r requirements.txt --upgrade"):
        print("⚠️ Warning: Failed to update some dependencies")
    
    # Try alternative pip command
    run_command("pip3 install -r requirements.txt --break-system-packages --upgrade")
    
    print("✅ Update completed successfully!")
    return True

def restart_bot():
    """Restart the bot after update."""
    print("🔄 Restarting Ultroid...")
    
    # Check if we have a virtual environment
    venv_python = None
    if os.path.exists("venv/bin/python"):
        venv_python = "venv/bin/python"
    elif os.path.exists("venv/Scripts/python.exe"):
        venv_python = "venv/Scripts/python.exe"
    
    # Determine how to start the bot
    if len(sys.argv) > 1 and sys.argv[-1] == "main.py":
        # Started with main.py
        if venv_python:
            os.execv(venv_python, [venv_python, "main.py"])
        else:
            os.execv(sys.executable, [sys.executable, "main.py"])
    else:
        # Started as module
        if venv_python:
            os.execv(venv_python, [venv_python, "-m", "pyUltroid"])
        else:
            os.execv(sys.executable, [sys.executable, "-m", "pyUltroid"])

if __name__ == "__main__":
    print("🚀 Ultroid Update Script")
    print("=" * 40)
    
    # Wait a moment for the bot to fully shutdown
    time.sleep(2)
    
    # Perform update
    if main():
        print("=" * 40)
        restart_bot()
    else:
        print("❌ Update failed. Please check the errors above.")
        sys.exit(1)
