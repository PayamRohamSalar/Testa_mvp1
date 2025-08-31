# create_project.py
import os, textwrap, pathlib

ROOT = r"D:\OneDrive\AI-Project\TESTA_WS_mvp1"  # تغییر مسیر دلخواه

def w(path, content):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f: f.write(content)

os.makedirs(os.path.join(ROOT, "assets"), exist_ok=True)
os.makedirs(os.path.join(ROOT, "data"), exist_ok=True)
os.makedirs(os.path.join(ROOT, "docs"), exist_ok=True)
os.makedirs(os.path.join(ROOT, "scripts"), exist_ok=True)

w(os.path.join(ROOT,"README.md"), "# Persian Open Innovation Platform (Single-File React)\nOpen `index.html` directly in a browser.\n")
w(os.path.join(ROOT,".gitignore"), ".DS_Store\nThumbs.db\n*.log\nnode_modules/\ndist/\n.vscode/\n.cursor/\n")
w(os.path.join(ROOT,"index.html"), "<!DOCTYPE html>\n<html dir=\"rtl\" lang=\"fa\">...\n</html>\n")  # همان محتوای کامل بالا را جایگزین کنید
w(os.path.join(ROOT,"scripts","serve.cmd"), "start ..\\index.html\n")
print(f"Created at {ROOT}")
