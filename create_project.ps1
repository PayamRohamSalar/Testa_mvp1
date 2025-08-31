# create_project.ps1
Param(
  [string]$Root = "D:\Projects\persian-open-innovation"
)

New-Item -ItemType Directory -Force -Path $Root | Out-Null
New-Item -ItemType Directory -Force -Path "$Root\assets" | Out-Null
New-Item -ItemType Directory -Force -Path "$Root\data"   | Out-Null
New-Item -ItemType Directory -Force -Path "$Root\docs"   | Out-Null
New-Item -ItemType Directory -Force -Path "$Root\scripts"| Out-Null

@"
# Persian Open Innovation Platform (Single-File React)
This repository contains a single-file demo (`index.html`) for a Farsi (RTL) open innovation platform + TESTA module.
Open `index.html` directly in a browser (no server needed).
"@ | Out-File -FilePath "$Root\README.md" -Encoding UTF8 -Force

@"
# Ignore OS/editor files
.DS_Store
Thumbs.db
*.log

# Ignore temporary dev artifacts (if any appear)
node_modules/
dist/
.vscode/
.cursor/

# No build output is expected for this project
"@ | Out-File -FilePath "$Root\.gitignore" -Encoding UTF8 -Force

@"
<!DOCTYPE html>
<html dir="rtl" lang="fa">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>پلتفرم نوآوری باز + TESTA (دمو)</title>
  <!-- Tailwind CDN -->
  <script src="https://cdn.tailwindcss.com"></script>
  <!-- React/ReactDOM + Babel -->
  <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
  <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
  <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
</head>
<body class="bg-gray-50">
  <div id="root" class="min-h-screen"></div>

  <script type="text/babel">
    // --- UTILITIES: storage (MVP) ---
    const storage = {
      get: (k, fb) => { try { return JSON.parse(localStorage.getItem(k)) ?? fb; } catch { return fb; } },
      set: (k, v) => localStorage.setItem(k, JSON.stringify(v)),
      clear: () => localStorage.clear()
    };

    // --- STATE MODELS & SEED ---
    const KEYS = ["users","orgs","challenges","submissions","messages","events","exhibitors","notifications","reputationEvents","settings","session"];
    function seedDataOnce() {
      const firstRun = !localStorage.getItem("seeded");
      if (!firstRun) return;

      const users = [
        { id:"u-admin",  role:"ADMIN",  email:"admin@platform.ir",  name:"مدیر",   password:"123456" },
        { id:"u-seeker", role:"SEEKER", email:"info@parstech.ir",   name:"پارس‌تک", password:"123456", orgId:"o-pars" },
        { id:"u-solver", role:"SOLVER", email:"a.mohammadi@university.ac.ir", name:"امیرمحمدی", password:"123456" }
      ];
      const orgs = [{ id:"o-pars", name:"شرکت توسعه فناوری پارس", domains:["انرژی"] }];

      const challenges = [
        { id:"c-energy", orgId:"o-pars", title:"سامانه مدیریت هوشمند انرژی", reward:50000000, category:"Energy", status:"published" }
      ];

      KEYS.forEach(k => { if (!localStorage.getItem(k)) storage.set(k, []); });
      storage.set("users", users);
      storage.set("orgs", orgs);
      storage.set("challenges", challenges);
      storage.set("settings", { kiosk:false, countdownTarget: null });
      storage.set("session", null);
      localStorage.setItem("seeded","1");
    }

    // --- SIMPLE ROUTER (hash-based) ---
    function useHashRoute(initial="home") {
      const [route, setRoute] = React.useState(() => location.hash.replace("#","") || initial);
      React.useEffect(() => {
        const onHash = () => setRoute(location.hash.replace("#","") || initial);
        window.addEventListener("hashchange", onHash);
        return () => window.removeEventListener("hashchange", onHash);
      }, []);
      return [route, setRoute];
    }

    // --- APP SHELL ---
    function App(){
      React.useEffect(seedDataOnce, []);
      const [route] = useHashRoute("home");
      return (
        <div className="max-w-5xl mx-auto p-4">
          <header className="flex items-center justify-between mb-6">
            <h1 className="text-xl font-bold">پلتفرم نوآوری باز + TESTA (دمو)</h1>
            <nav className="flex gap-3 text-blue-600">
              <a href="#home">خانه</a>
              <a href="#challenges">چالش‌ها</a>
              <a href="#testa">TESTA</a>
            </nav>
          </header>
          <main className="bg-white rounded-xl p-6 shadow">
            {route === "home" && <p>سلام! این نسخهٔ نمایشیِ تک‌فایل است.</p>}
            {route === "challenges" && <p>کاتالوگ چالش‌ها (به‌زودی).</p>}
            {route === "testa" && <p>بخش نمایشگاه TESTA (به‌زودی).</p>}
          </main>
        </div>
      );
    }

    ReactDOM.createRoot(document.getElementById("root")).render(<App />);
  </script>
</body>
</html>
"@ | Out-File -FilePath "$Root\index.html" -Encoding UTF8 -Force

"echo Off
echo Opening index.html...
start index.html
" | Out-File -FilePath "$Root\scripts\serve.cmd" -Encoding ASCII -Force

Write-Host "Project scaffold created at $Root"
