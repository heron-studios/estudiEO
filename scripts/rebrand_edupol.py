import os
import re
import shutil

# Configuration
ROOT_DIR = '/Users/brayanizq/Documents/estudiEO'

# Directories to entirely skip
EXCLUDE_DIRS = {
    '.git', 'build', '.dart_tool', 'android', 'ios', 'macos', 
    'linux', 'windows', 'web', 'assets', '.idea'
}

# Specific files to skip content replacement (Firebase Config)
EXCLUDE_FILES = {
    'firebase.json',
    'firebase_options.dart',
    'google-services.json',
    'GoogleService-Info.plist',
    'rebrand_edupol.py',
    'pubspec.lock'
}

# Regex pattern (case-insensitive)
pattern = re.compile(re.escape('estudieo'), re.IGNORECASE)

def process_file_content(filepath):
    filename = os.path.basename(filepath)
    if filename in EXCLUDE_FILES:
        return

    # Check if it's a binary file or text file
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
    except UnicodeDecodeError:
        # Not a text file, skip
        return

    # If pattern found, replace and write back
    if pattern.search(content):
        new_content = pattern.sub('EDUPOL', content)
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated content in: {filepath}")

def main():
    # Phase 1: Rename files and directories
    # We do this bottom-up to avoid breaking paths as we rename parent directories
    for root, dirs, files in os.walk(ROOT_DIR, topdown=False):
        # Exclude directories if they are in the root (simple check)
        rel_path = os.path.relpath(root, ROOT_DIR)
        parts = rel_path.split(os.sep)
        if any(part in EXCLUDE_DIRS for part in parts):
            continue

        for name in files:
            if pattern.search(name) and name not in EXCLUDE_FILES:
                old_path = os.path.join(root, name)
                # Keep extension intact, just lowercasing 'edupol' is better for filenames
                new_name = pattern.sub('edupol', name)
                new_path = os.path.join(root, new_name)
                os.rename(old_path, new_path)
                print(f"Renamed file: {old_path} -> {new_path}")

        for name in dirs:
            if pattern.search(name) and name not in EXCLUDE_DIRS:
                old_path = os.path.join(root, name)
                new_name = pattern.sub('edupol', name)
                new_path = os.path.join(root, new_name)
                os.rename(old_path, new_path)
                print(f"Renamed dir: {old_path} -> {new_path}")

    # Phase 2: Update contents
    for root, dirs, files in os.walk(ROOT_DIR):
        # Prevent diving into excluded directories
        dirs[:] = [d for d in dirs if d not in EXCLUDE_DIRS]
        
        for name in files:
            filepath = os.path.join(root, name)
            process_file_content(filepath)

if __name__ == '__main__':
    main()
