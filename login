<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
  <meta name="theme-color" content="#0a1628" />
  <title>EaseSave</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" /> 
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=DM+Mono:wght@400;500&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
  <style>
    /* ============================================================
       EASESAVE — DARK BLUE / GREEN GRADIENT THEME
       ============================================================ */

    * { margin:0; padding:0; box-sizing:border-box; }

    body {
      font-family:'DM Sans',sans-serif;
      background: linear-gradient(145deg, #0a1628 0%, #0d2a1a 100%);
      color: #E6EDF3;
      min-height:100vh;
      display:flex;
      flex-direction:column;
      -webkit-font-smoothing: antialiased;
    }

    .mono { font-family:'DM Mono',monospace; font-weight:500; font-variant-numeric: tabular-nums; }

    :root {
      --bg-primary: #0a1628;
      --bg-card: rgba(22, 27, 34, 0.85);
      --bg-card-hover: #1C2333;
      --bg-input: #0D1A2B;
      --bg-input-hover: #1A2A3A;
      --border-soft: #2A3A3A;
      --text-primary: #E6EDF3;
      --text-secondary: #8B949E;
      --text-muted: #6E7681;
      --plum: #7C5CBF;
      --plum-dark: #5A3D8A;
      --plum-glow: rgba(124, 92, 191, 0.25);
      --amber: #F5A623;
      --amber-dark: #c98a1a;
      --amber-glow: rgba(245, 166, 35, 0.2);
      --sage: #5BA87A;
      --sage-dark: #3d7a55;
      --sage-glow: rgba(91, 168, 122, 0.2);
      --soft-red: #E05C5C;
      --soft-red-dark: #b84444;
      --soft-red-glow: rgba(224, 92, 92, 0.15);
      --radius:16px;
      --radius-sm:10px;
      --shadow-card: 0 8px 24px rgba(0,0,0,0.5);
      --shadow-lift: 0 12px 32px rgba(0,0,0,0.6);
    }

    ::-webkit-scrollbar { width:4px; height:4px; }
    ::-webkit-scrollbar-track { background: var(--bg-primary); }
    ::-webkit-scrollbar-thumb { background: var(--plum); border-radius:10px; }

    /* ===== LOGIN SCREEN ===== */
    #loginScreen {
      position: fixed;
      top: 0; left: 0; right: 0; bottom: 0;
      background: linear-gradient(145deg, #0a1628 0%, #0d2a1a 100%);
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 9999;
      padding: 20px;
      transition: opacity 0.5s ease, visibility 0.5s ease;
    }
    #loginScreen.hidden {
      opacity: 0;
      visibility: hidden;
      pointer-events: none;
    }
    .login-box {
      background: var(--bg-card);
      backdrop-filter: blur(16px);
      border-radius: var(--radius);
      padding: 32px 28px;
      max-width: 380px;
      width: 100%;
      border: 1px solid var(--border-soft);
      box-shadow: var(--shadow-lift);
      text-align: center;
    }
    .login-box h1 {
      font-size: 28px;
      font-weight: 800;
      margin-bottom: 6px;
      color: var(--text-primary);
    }
    .login-box .sub {
      color: var(--text-secondary);
      font-size: 14px;
      margin-bottom: 24px;
    }
    .login-box .fingerprint-icon {
      font-size: 56px;
      color: var(--plum);
      margin-bottom: 16px;
      display: block;
    }
    .login-box .auth-input {
      margin-bottom: 12px;
      text-align: center;
    }
    .login-box .btn-primary {
      margin-top: 8px;
    }
    .login-box .btn-outline {
      margin-top: 8px;
    }
    .login-status {
      font-size: 14px;
      margin-top: 16px;
      min-height: 24px;
      color: var(--text-secondary);
    }
    .login-status.success { color: var(--sage); }
    .login-status.error { color: var(--soft-red); }
    .login-status.loading { color: var(--amber); }

    /* ===== APP SHELL ===== */
    #appShell {
      display: none;
      flex-direction: column;
      min-height: 100vh;
      padding-bottom: 88px;
    }
    #appShell.visible {
      display: flex;
    }

    /* ===== Existing styles (copied from your original) ===== */
    .screen { display:none; flex:1; padding:18px 16px 24px; animation:fadeIn 0.3s ease; }
    .screen.active { display:block; }
    @keyframes fadeIn { from { opacity:0; transform:translateY(12px); } to { opacity:1; transform:translateY(0); } }

    .bottom-nav {
      position:fixed; bottom:0; left:0; right:0;
      background: rgba(10, 22, 40, 0.92);
      backdrop-filter: blur(16px);
      display:flex; justify-content:space-around; align-items:center;
      padding:10px 0 14px;
      border-top:1px solid var(--border-soft);
      z-index:100;
    }
    .nav-item {
      display:flex; flex-direction:column; align-items:center;
      font-size:11px; color:var(--text-secondary);
      background:none; border:none; padding:6px 14px; border-radius:14px;
      cursor:pointer; transition: all 0.2s ease; font-family:'DM Sans',sans-serif;
      font-weight:500;
    }
    .nav-item i { font-size:20px; margin-bottom:3px; transition: transform 0.2s ease; }
    .nav-item.active { color:var(--plum); font-weight:700; background:rgba(124,92,191,0.12); }
    .nav-item.active i { color:var(--plum); transform: translateY(-1px); }
    .nav-item:hover { color:var(--text-primary); }

    .fab {
      position:fixed; bottom:96px; right:20px;
      width:62px; height:62px; border-radius:50%;
      background: linear-gradient(135deg, var(--amber), var(--amber-dark));
      color:white; border:none;
      box-shadow: 0 8px 24px rgba(245,166,35,0.35), 0 2px 6px rgba(0,0,0,0.3);
      font-size:26px; display:flex; align-items:center; justify-content:center;
      cursor:pointer; transition: all 0.25s cubic-bezier(.34,1.56,.64,1); z-index:99;
    }
    .fab:hover { transform:scale(1.08) rotate(8deg); box-shadow: 0 12px 30px rgba(245,166,35,0.45); }
    .fab:active { transform: scale(0.96); }

    .card {
      background: var(--bg-card);
      backdrop-filter: blur(8px);
      border-radius:var(--radius);
      padding:20px 18px;
      margin-bottom:16px;
      border: 1px solid rgba(42, 58, 58, 0.6);
      box-shadow: var(--shadow-card);
      transition: box-shadow 0.25s ease, border-color 0.25s ease;
    }
    .card:hover { border-color: rgba(124,92,191,0.25); }
    .card-title {
      font-weight:700; font-size:12px; color:var(--text-secondary);
      margin-bottom:12px; letter-spacing:0.8px; text-transform: uppercase;
    }
    .amount { font-family:'DM Mono',monospace; font-weight:600; font-size:20px; font-variant-numeric: tabular-nums; color:var(--text-primary); }
    .amount-large { font-size:30px; font-weight:700; }
    .badge {
      display:inline-block; background: var(--plum); color:white;
      border-radius:20px; padding:3px 13px; font-size:11px; font-weight:700;
      letter-spacing:0.3px;
    }

    .progress-bar {
      height:8px; background:#1A2A2A; border-radius:20px; overflow:hidden;
      margin-top:8px; box-shadow: inset 0 1px 3px rgba(0,0,0,0.3);
    }
    .progress-fill {
      height:100%; border-radius:20px;
      background: linear-gradient(90deg, var(--sage-dark), var(--sage));
      transition: width 0.6s cubic-bezier(.22,1,.36,1);
    }
    .progress-fill.amber { background: linear-gradient(90deg, var(--amber-dark), var(--amber)); }
    .progress-fill.red { background: linear-gradient(90deg, var(--soft-red-dark), var(--soft-red)); }

    #pulseCanvas { display:block; margin:0 auto; width:150px; height:150px; }
    .dial-label { text-align:center; margin-top:2px; font-size:14px; color:var(--text-secondary); font-weight:500; }
    .dial-value { font-family:'DM Mono',monospace; font-size:23px; font-weight:700; color:var(--text-primary); }

    .category-grid { display:grid; grid-template-columns:repeat(4,1fr); gap:10px; margin:14px 0; }
    .category-chip {
      display:flex; flex-direction:column; align-items:center;
      padding:14px 4px; border-radius:14px;
      background:#1A2A2A; border:2px solid transparent;
      transition: all 0.18s cubic-bezier(.34,1.56,.64,1);
      cursor:pointer; font-size:11.5px; font-weight:600; color:var(--text-secondary);
    }
    .category-chip i { font-size:22px; margin-bottom:6px; color:var(--text-muted); transition: color 0.18s ease; }
    .category-chip:active { transform: scale(0.94); }
    .category-chip.selected {
      border-color:var(--plum); background:rgba(124,92,191,0.12);
      transform: scale(1.03);
      box-shadow: 0 4px 16px rgba(124,92,191,0.15);
      color:var(--text-primary);
    }
    .category-chip.selected i { color:var(--plum); }
    .category-chip.income { background:rgba(91,168,122,0.08); }
    .category-chip.income.selected { border-color:var(--sage); background:rgba(91,168,122,0.15); }
    .category-chip.income.selected i { color:var(--sage); }

    .tx-item { display:flex; align-items:center; padding:12px 0; border-bottom:1px solid #1A2A2A; }
    .tx-item:last-child { border-bottom:none; }
    .tx-icon {
      width:40px; height:40px; border-radius:12px;
      background:rgba(124,92,191,0.12);
      display:flex; align-items:center; justify-content:center;
      margin-right:13px; color:var(--plum); font-size:16px; flex-shrink:0;
    }
    .tx-info { flex:1; min-width:0; }
    .tx-info .tx-note { font-size:14.5px; font-weight:600; color:var(--text-primary); overflow:hidden; text-overflow:ellipsis; white-space:nowrap; }
    .tx-info .tx-meta { font-size:12px; color:var(--text-secondary); margin-top:1px; }
    .tx-amount { font-family:'DM Mono',monospace; font-weight:700; font-size:14.5px; white-space:nowrap; }
    .tx-amount.income { color:var(--sage); }
    .tx-amount.expense { color:var(--soft-red); }
    .tx-actions { display:flex; gap:4px; margin-left:8px; }
    .tx-actions button {
      background:#1A2A2A; border:none; cursor:pointer; font-size:13px; padding:7px 9px;
      border-radius:9px; transition: background 0.15s ease; color:var(--text-secondary);
    }
    .tx-actions button:active { background:#1A3A3A; }
    .tx-actions .edit-btn:hover { color:var(--plum); }
    .tx-actions .delete-btn:hover { color:var(--soft-red); }

    .num-pad { display:grid; grid-template-columns:repeat(4,1fr); gap:9px; margin-top:14px; }
    .num-pad button {
      padding:16px 0; font-size:21px; font-family:'DM Mono',monospace; font-weight:600;
      background:#1A2A2A; border:none; border-radius:14px; cursor:pointer;
      transition: all 0.1s ease; color:var(--text-primary);
    }
    .num-pad button:active { background:#1A3A3A; transform:scale(0.95); }
    .num-pad .clear-btn { background:rgba(224,92,92,0.12); color:var(--soft-red); }
    .num-pad .clear-btn:active { background:rgba(224,92,92,0.2); }
    .num-pad .submit-btn { background:linear-gradient(135deg, var(--plum), var(--plum-dark)); color:white; font-size:18px; box-shadow:0 4px 16px rgba(124,92,191,0.3); }

    .auth-input, input[type="text"], input[type="number"], input[type="date"], input[type="month"], select {
      width:100%;
      padding:13px 16px;
      border-radius:13px;
      border:1.5px solid var(--border-soft);
      font-size:15px;
      font-family:'DM Sans',sans-serif;
      background:var(--bg-input);
      color:var(--text-primary);
      outline:none;
      transition: border-color 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
      appearance:none;
      -webkit-appearance:none;
    }
    .auth-input::placeholder, input::placeholder { color:var(--text-muted); font-weight:400; }
    .auth-input:focus, input:focus, select:focus {
      border-color:var(--plum);
      background:var(--bg-input-hover);
      box-shadow:0 0 0 4px rgba(124,92,191,0.08);
    }
    select.auth-input, select {
      background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%238B949E' stroke-width='1.6' fill='none' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
      background-repeat:no-repeat;
      background-position:right 14px center;
      padding-right:38px;
      cursor:pointer;
    }
    select option { background:#0D1A2B; color:var(--text-primary); }

    #amountInput {
      font-size:30px !important;
      font-family:'DM Mono',monospace !important;
      text-align:center;
      background:rgba(124,92,191,0.06) !important;
      color:var(--plum) !important;
      font-weight:700;
      border:2px solid rgba(124,92,191,0.15) !important;
      padding:20px 16px !important;
      letter-spacing:0.5px;
    }
    #amountInput:focus { border-color:var(--plum) !important; background:rgba(124,92,191,0.1) !important; }

    .field-label {
      font-size:12px; font-weight:700; color:var(--text-secondary);
      text-transform:uppercase; letter-spacing:0.5px; margin-bottom:6px; display:block;
    }

    .report-table { width:100%; border-collapse:collapse; font-size:14px; }
    .report-table th {
      text-align:left; color:var(--text-secondary); font-weight:700; text-transform:uppercase;
      font-size:11px; letter-spacing:0.4px; padding-bottom:10px; border-bottom:2px solid var(--border-soft);
    }
    .report-table td { padding:11px 0; border-bottom:1px solid #1A2A2A; font-weight:500; color:var(--text-primary); }
    .report-table .variance-positive { color:var(--sage); font-weight:700; }
    .report-table .variance-negative { color:var(--soft-red); font-weight:700; }

    .savings-item { display:flex; justify-content:space-between; padding:10px 0; border-bottom:1px solid #1A2A2A; font-size:14px; color:var(--text-primary); }
    .savings-item .dir-deposit { color:var(--sage); font-weight:700; }
    .savings-item .dir-withdrawal { color:var(--soft-red); font-weight:700; }

    .alert-banner {
      background:rgba(245,166,35,0.08); border-left:4px solid var(--amber);
      padding:14px 16px; border-radius:14px; margin-bottom:12px; font-size:13.5px;
      font-weight:500; color:var(--text-primary);
      box-shadow:var(--shadow-card);
    }
    .alert-banner.danger { background:rgba(224,92,92,0.08); border-left-color:var(--soft-red); }
    .alert-banner.success { background:rgba(91,168,122,0.08); border-left-color:var(--sage); }

    .flex-row { display:flex; justify-content:space-between; align-items:center; }
    .mt-8 { margin-top:8px; }
    .mb-8 { margin-bottom:8px; }
    .text-muted { color:var(--text-secondary); }
    .text-center { text-align:center; }
    .w-full { width:100%; }

    .btn-primary {
      background:linear-gradient(135deg, var(--plum), var(--plum-dark));
      color:white; border:none; padding:15px 20px; border-radius:16px;
      font-weight:700; font-size:15.5px; width:100%; cursor:pointer;
      transition: all 0.2s ease; box-shadow:0 6px 20px rgba(124,92,191,0.25);
      letter-spacing:0.2px;
    }
    .btn-primary:active { transform:scale(0.98); box-shadow:0 3px 12px rgba(124,92,191,0.15); }
    .btn-primary:disabled { opacity:0.4; cursor:not-allowed; box-shadow:none; }
    .btn-outline {
      background:transparent; border:2px solid var(--plum); color:var(--plum);
      padding:12px 20px; border-radius:16px; font-weight:700; width:100%; cursor:pointer;
      transition: background 0.2s ease;
    }
    .btn-outline:active { background:rgba(124,92,191,0.08); }

    .dashboard-header { display:flex; justify-content:space-between; align-items:center; margin-bottom:18px; }
    .dashboard-header h1 { font-size:25px; font-weight:800; color:var(--text-primary); letter-spacing:-0.3px; }

    .date-display {
      background:linear-gradient(135deg, #0D1A2B, #1A2A2A);
      border:1px solid var(--border-soft);
      border-radius:var(--radius);
      padding:20px 22px;
      color:var(--text-primary);
      margin-bottom:16px;
      display:flex;
      justify-content:space-between;
      align-items:center;
      box-shadow:var(--shadow-card);
      position:relative;
      overflow:hidden;
    }
    .date-display::after {
      content:'';
      position:absolute; top:-40%; right:-10%;
      width:160px; height:160px; border-radius:50%;
      background:rgba(124,92,191,0.04);
    }
    .date-display .date-main { font-size:21px; font-weight:700; }
    .date-display .date-sub { font-size:13.5px; opacity:0.6; margin-top:2px; }
    .date-display .date-day { font-size:38px; font-weight:800; opacity:0.5; font-family:'DM Mono',monospace; }

    .stipend-input-group { display:flex; gap:8px; align-items:center; margin-top:8px; }
    .stipend-input-group input {
      flex:1; padding:11px 14px; border-radius:12px; border:1.5px solid var(--border-soft);
      font-size:15px; font-family:'DM Mono',monospace; background:var(--bg-input); color:var(--text-primary);
      outline:none; transition:0.2s; width:100px;
    }
    .stipend-input-group input:focus { border-color:var(--plum); background:var(--bg-input-hover); }
    .stipend-input-group .save-stipend-btn {
      background:var(--sage-dark); color:white; border:none; padding:11px 18px;
      border-radius:12px; font-weight:700; cursor:pointer; font-size:13px;
      transition:0.2s; white-space:nowrap;
    }
    .stipend-input-group .save-stipend-btn:active { background:#3d7a55; transform:scale(0.96); }

    .cal-day {
      padding:10px 0; text-align:center; border-radius:13px; cursor:pointer;
      font-weight:500; color:var(--text-secondary); border:2px solid transparent;
      transition:all 0.15s ease; position:relative; background:transparent;
    }
    .cal-day:active { background:rgba(124,92,191,0.08); }
    .cal-day .dot { width:6px; height:6px; border-radius:50%; background:var(--sage); margin:3px auto 0; }
    .cal-day.today { border-color:var(--plum); font-weight:700; color:var(--text-primary); }
    .cal-day.has-tx { background:rgba(91,168,122,0.06); }
    .stipend-status.sage { color:var(--sage); font-weight:700; }
    .stipend-status.amber { color:var(--amber); font-weight:700; }

    .scrollable { max-height:400px; overflow-y:auto; padding-right:4px; }
    .scrollable::-webkit-scrollbar { width:3px; }
    .scrollable::-webkit-scrollbar-thumb { background:var(--plum); border-radius:10px; }
  </style>
</head>
<body>

<!-- ==================== LOGIN SCREEN ==================== -->
<div id="loginScreen">
  <div class="login-box">
    <span class="fingerprint-icon"><i class="fas fa-fingerprint"></i></span>
    <h1>EaseSave</h1>
    <p class="sub">Secure your finances with fingerprint</p>

    <input type="text" id="loginUsername" class="auth-input" placeholder="Username (e.g. john)" autocomplete="username" />
    
    <button id="loginRegisterBtn" class="btn-primary">Register Fingerprint</button>
    <button id="loginAuthBtn" class="btn-outline">Login with Fingerprint</button>

    <div id="loginStatus" class="login-status">Enter username, then register or login.</div>
  </div>
</div>

<!-- ==================== APP SHELL ==================== -->
<div id="appShell">

  <!-- SCREEN: Dashboard -->
  <div id="screen-dashboard" class="screen active">
    <div class="dashboard-header">
      <h1>📊 EaseSave</h1>
      <button id="logoutBtn" style="background:transparent; border:none; color:var(--text-secondary); font-size:20px; cursor:pointer;" title="Logout"><i class="fas fa-sign-out-alt"></i></button>
    </div>
    <div id="alertContainer"></div>

    <!-- Nice Date Display -->
    <div class="date-display" id="dateDisplay">
      <div>
        <div class="date-main" id="dateMain">Today</div>
        <div class="date-sub" id="dateSub">January 1, 2026</div>
      </div>
      <div class="date-day" id="dateDay">1</div>
    </div>

    <div class="card" style="text-align:center;">
      <div style="position:relative; display:inline-block;">
        <canvas id="pulseCanvas" width="140" height="140"></canvas>
        <div style="position:absolute; top:50%; left:50%; transform:translate(-50%,-50%); font-family:'DM Mono',monospace; font-size:24px; font-weight:500;"><span id="dialPercent">0%</span></div>
      </div>
      <div class="dial-label"><span class="dial-value" id="remainingBudget">0</span> UGX left this month</div>
      <div class="text-muted" style="font-size:13px; margin-top:4px;"><span id="daysLeft">0</span> days left · burn rate: <span id="burnRate">0</span> UGX/day</div>
    </div>
    <div class="card">
      <div class="flex-row"><span><strong>🏦 Sanlam</strong></span><span class="amount" id="sanlamBalance">0</span></div>
      <div class="flex-row text-muted" style="font-size:13px;"><span>This month saved: <span id="monthlySaved" class="amount">0</span></span><span>Goal: 25,000</span></div>
      <div class="progress-bar" style="margin-top:4px;"><div class="progress-fill" id="sanlamProgress" style="width:0%;"></div></div>
    </div>
    <div class="card">
      <div class="flex-row"><span><strong>🛡️ Emergency Buffer</strong></span><span class="amount" id="emergencyBalance">0</span></div>
      <div class="flex-row text-muted" style="font-size:13px;"><span>Goal: 100,000 UGX</span><span id="emergencyPercent">0%</span></div>
      <div class="progress-bar"><div class="progress-fill amber" id="emergencyProgress" style="width:0%;"></div></div>
    </div>
    <div class="card"><div class="card-title">Spending by Category</div><div id="categoryBars"></div></div>
    <div class="card"><div class="card-title">Recent Transactions</div><div id="recentTxs"></div></div>
  </div>

  <!-- SCREEN: Log Transaction -->
  <div id="screen-log" class="screen">
    <div class="flex-row" style="margin-bottom:16px;">
      <h2 style="font-weight:600; color:var(--text-primary);">Log Transaction</h2>
      <button id="cancelEditBtn" class="btn-outline" style="width:auto; padding:6px 16px; display:none;">Cancel</button>
    </div>
    <div class="card">
      <div class="card-title">Amount (UGX)</div>
      <input type="text" id="amountInput" class="auth-input" placeholder="0" readonly />
      <div class="num-pad" id="numPad">
        <button data-value="1">1</button><button data-value="2">2</button><button data-value="3">3</button>
        <button data-value="4">4</button><button data-value="5">5</button><button data-value="6">6</button>
        <button data-value="7">7</button><button data-value="8">8</button><button data-value="9">9</button>
        <button data-value="clear" class="clear-btn">⌫</button><button data-value="0">0</button>
        <button data-value="clear-all" class="clear-btn">C</button><button data-value="submit" class="submit-btn">✓</button>
      </div>
    </div>
    <div class="card"><div class="card-title">Category</div><div class="category-grid" id="categoryGrid"></div></div>
    <div class="card"><div class="card-title">Account</div><select id="accountSelect" class="auth-input"><option value="cash">Cash on Hand</option><option value="momo">MTN MoMo</option><option value="sanlam">Sanlam (savings)</option></select></div>
    <div class="card"><div class="card-title">Note (optional)</div><input type="text" id="noteInput" class="auth-input" placeholder="e.g. Lunch at Nakasero" /></div>
    <div class="card"><div class="card-title">Date</div><input type="date" id="dateInput" class="auth-input" /></div>
    <div id="logError" class="alert-banner danger" style="display:none;"></div>
    <button id="submitTxBtn" class="btn-primary">Submit Transaction</button>
  </div>

  <!-- SCREEN: Transactions -->
  <div id="screen-transactions" class="screen">
    <div class="flex-row"><h2 style="font-weight:600; color:var(--text-primary);">Transactions</h2><div><span class="badge" id="txCount">0</span></div></div>
    <div style="display:flex; gap:8px; margin:12px 0; flex-wrap:wrap;">
      <select id="filterCategory" class="auth-input" style="flex:1; padding:8px;"><option value="all">All Categories</option></select>
      <select id="filterMonth" class="auth-input" style="flex:1; padding:8px;"><option value="all">All Months</option></select>
    </div>
    <div id="txList"></div>
  </div>

  <!-- SCREEN: Report -->
  <div id="screen-report" class="screen">
    <h2 style="font-weight:600; color:var(--text-primary);">Monthly Report</h2>
    <div style="margin:12px 0; display:flex; gap:8px; align-items:center; flex-wrap:wrap;">
      <input type="month" id="reportMonth" class="auth-input" style="width:auto; flex:1; min-width:150px;" />
      <button id="loadReportBtn" class="btn-primary" style="width:auto; padding:10px 20px;">Load</button>
    </div>
    <div id="reportSummary" class="card">
      <div class="flex-row"><span style="color:var(--text-secondary);">Income</span><span class="amount" id="reportIncome">0</span></div>
      <div class="flex-row"><span style="color:var(--text-secondary);">Expenses</span><span class="amount" id="reportExpenses">0</span></div>
      <div class="flex-row"><span style="color:var(--text-secondary);">Savings (to Sanlam)</span><span class="amount" id="reportSavings">0</span></div>
      <div class="flex-row"><span style="color:var(--text-secondary);">Unaccounted</span><span class="amount" id="reportUnaccounted">0</span></div>
    </div>
    <div class="card"><div class="card-title">Category Breakdown</div><table class="report-table"><thead><tr><th>Category</th><th>Budget</th><th>Actual</th><th>Variance</th></tr></thead><tbody id="reportCategoryBody"></tbody></table></div>
  </div>

  <!-- SCREEN: Savings -->
  <div id="screen-savings" class="screen">
    <h2 style="font-weight:600; color:var(--text-primary);">Savings</h2>
    
    <!-- Sanlam Balance -->
    <div class="card">
      <div class="flex-row"><span style="color:var(--text-primary);"><strong>🏦 Sanlam Balance</strong></span><span class="amount" id="savingsSanlamBalance">0</span></div>
      <div style="display:flex; gap:8px; margin-top:12px;">
        <input type="number" id="savingsAmount" class="auth-input" placeholder="Amount" style="flex:2;" />
        <select id="savingsDirection" class="auth-input" style="flex:1;"><option value="deposit">Deposit</option><option value="withdrawal">Withdraw</option></select>
      </div>
      <div style="display:flex; gap:8px; margin-top:8px;">
        <select id="savingsReason" class="auth-input" style="flex:2;"><option value="regular">Regular</option><option value="emergency">Emergency</option><option value="discretionary">Discretionary</option></select>
        <button id="logSavingsBtn" class="btn-primary" style="flex:1; padding:8px;">Log</button>
      </div>
      <div id="savingsError" class="alert-banner danger" style="display:none;"></div>
    </div>

    <!-- Monthly Budget Card -->
    <div class="card" id="budgetCard">
      <div class="flex-row">
        <span style="color:var(--text-primary);"><strong>📊 Monthly Budget</strong></span>
        <span class="badge" id="budgetDisplay">300,000</span>
      </div>
      <div class="stipend-input-group">
        <span style="font-weight:500; color:var(--text-secondary);">Set Budget:</span>
        <input type="number" id="budgetAmountInput" value="300000" step="10000" min="0" />
        <button class="save-stipend-btn" id="saveBudgetBtn">Save</button>
      </div>
      <div style="margin-top:8px; font-size:12px; color:var(--text-muted);">
        This budget is used for the monthly spending tracker on your dashboard.
      </div>
    </div>

    <!-- Monthly Stipend Card -->
    <div class="card" id="stipendCard">
      <div class="flex-row"><span style="color:var(--text-primary);"><strong>📆 Monthly Stipend</strong></span><span id="stipendStatus" class="stipend-status amber">Not yet received ⏳</span></div>
      <div class="stipend-input-group">
        <span style="font-weight:500; color:var(--text-secondary);">Amount:</span>
        <input type="number" id="stipendAmountInput" value="300000" step="10000" />
        <button class="save-stipend-btn" id="saveStipendBtn">Save</button>
      </div>
      <button id="markStipendBtn" class="btn-primary" style="margin-top:10px; padding:10px;">Mark Stipend as Received</button>
    </div>

    <!-- Emergency Buffer -->
    <div class="card">
      <div class="card-title">Emergency Buffer</div>
      <div class="flex-row"><span style="color:var(--text-secondary);">Balance</span><span class="amount" id="savingsEmergencyBalance">0</span></div>
      <div class="progress-bar"><div class="progress-fill amber" id="savingsEmergencyProgress" style="width:0%;"></div></div>
      <div class="text-muted" style="font-size:13px;">Goal: 100,000 UGX</div>
    </div>
    
    <div class="card"><div class="card-title">Savings History</div><div id="savingsHistory"></div></div>
    <div class="card"><div class="card-title">Month-on-Month Growth</div><canvas id="savingsChart" width="300" height="120"></canvas></div>
  </div>

  <!-- CALENDAR SCREEN -->
  <div id="screen-calendar" class="screen">
    <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:16px;">
      <button id="calPrev" class="btn-outline" style="width:auto; padding:6px 16px; background:transparent; border:2px solid var(--plum); border-radius:30px; font-weight:600; cursor:pointer;">‹</button>
      <h2 id="calMonthYear" style="font-weight:600; text-align:center; flex:1; color:var(--text-primary);">Month Year</h2>
      <button id="calNext" class="btn-outline" style="width:auto; padding:6px 16px; background:transparent; border:2px solid var(--plum); border-radius:30px; font-weight:600; cursor:pointer;">›</button>
    </div>
    <div id="calendarGrid" style="display:grid; grid-template-columns:repeat(7,1fr); gap:4px; margin-bottom:16px;"></div>
    <div id="dayTransactions" class="card" style="display:none;">
      <div class="flex-row"><span class="card-title" id="selectedDayLabel">Transactions for DD/MM/YYYY</span><span class="badge" id="selectedDayCount">0</span></div>
      <div id="dayTxList"></div>
    </div>
  </div>

  <!-- BOTTOM NAV -->
  <nav class="bottom-nav">
    <button class="nav-item active" data-screen="dashboard"><i class="fas fa-home"></i><span>Home</span></button>
    <button class="nav-item" data-screen="log"><i class="fas fa-plus-circle"></i><span>Log</span></button>
    <button class="nav-item" data-screen="transactions"><i class="fas fa-list-ul"></i><span>Txns</span></button>
    <button class="nav-item" data-screen="report"><i class="fas fa-chart-pie"></i><span>Report</span></button>
    <button class="nav-item" data-screen="savings"><i class="fas fa-piggy-bank"></i><span>Savings</span></button>
    <button class="nav-item" data-screen="calendar"><i class="fas fa-calendar-alt"></i><span>Calendar</span></button>
  </nav>

  <!-- FAB -->
  <button class="fab" id="fabLog"><i class="fas fa-pen"></i></button>
</div>

<!-- ==================== JAVASCRIPT ==================== -->
<script>
  // -------------------- FINGERPRINT AUTH (WebAuthn) --------------------
  (function() {
    // Store credential info in localStorage
    const STORAGE_KEY = 'easesave_webauthn';

    function getCredentialData() {
      try {
        return JSON.parse(localStorage.getItem(STORAGE_KEY));
      } catch { return null; }
    }

    function saveCredentialData(data) {
      localStorage.setItem(STORAGE_KEY, JSON.stringify(data));
    }

    // Helper: Convert ArrayBuffer to base64
    function bufferToBase64(buffer) {
      return btoa(String.fromCharCode(...new Uint8Array(buffer)));
    }

    // Helper: Convert base64 to ArrayBuffer
    function base64ToBuffer(base64) {
      const binary = atob(base64);
      const bytes = new Uint8Array(binary.length);
      for (let i = 0; i < binary.length; i++) {
        bytes[i] = binary.charCodeAt(i);
      }
      return bytes.buffer;
    }

    // Generate a random challenge (32 bytes)
    function generateChallenge() {
      const bytes = new Uint8Array(32);
      window.crypto.getRandomValues(bytes);
      return bytes;
    }

    // Register a new credential
    async function registerFingerprint(username) {
      if (!username || username.trim() === '') {
        setLoginStatus('Please enter a username.', 'error');
        return;
      }
      username = username.trim();

      // Check if already registered
      const existing = getCredentialData();
      if (existing && existing.username === username) {
        setLoginStatus('Username already registered. Try logging in.', 'error');
        return;
      }

      const challenge = generateChallenge();
      const userId = new TextEncoder().encode(username);

      const publicKey = {
        challenge: challenge,
        rp: { name: 'EaseSave' },
        user: {
          id: userId,
          name: username,
          displayName: username,
        },
        pubKeyCredParams: [
          { alg: -7, type: 'public-key' },  // ES256
          { alg: -257, type: 'public-key' } // RS256
        ],
        authenticatorSelection: {
          authenticatorAttachment: 'platform', // force built-in (fingerprint)
          userVerification: 'required',
          residentKey: 'preferred',
        },
        timeout: 60000,
        attestation: 'none',
      };

      try {
        const credential = await navigator.credentials.create({ publicKey });

        // Store credential data
        const credData = {
          username: username,
          credentialId: bufferToBase64(credential.id ? new TextEncoder().encode(credential.id) : credential.rawId),
          publicKey: bufferToBase64(credential.response.getPublicKey ? credential.response.getPublicKey() : new Uint8Array(0)),
          // We also store a static challenge for login (for simplicity, we'll use a fixed challenge).
          // In real app, you'd generate a new challenge per login.
        };
        saveCredentialData(credData);
        setLoginStatus(`✅ Registered ${username} successfully! You can now login.`, 'success');
        // Auto-login after registration?
        // We'll let user click Login button.
      } catch (err) {
        console.error('Registration error:', err);
        setLoginStatus('❌ Registration failed: ' + (err.message || 'Unknown error'), 'error');
      }
    }

    // Login with fingerprint
    async function loginFingerprint(username) {
      if (!username || username.trim() === '') {
        setLoginStatus('Please enter your username.', 'error');
        return;
      }
      username = username.trim();

      const credData = getCredentialData();
      if (!credData || credData.username !== username) {
        setLoginStatus('❌ No registered fingerprint for this username.', 'error');
        return;
      }

      // Reconstruct credential ID as ArrayBuffer
      const credentialIdBuffer = base64ToBuffer(credData.credentialId);
      const challenge = generateChallenge();

      const publicKey = {
        challenge: challenge,
        allowCredentials: [{
          id: credentialIdBuffer,
          type: 'public-key',
        }],
        userVerification: 'required',
        timeout: 60000,
      };

      try {
        const assertion = await navigator.credentials.get({ publicKey });
        // For a real app, you'd verify the signature on server.
        // For this demo, we just check if we got a valid assertion.
        if (assertion && assertion.response) {
          setLoginStatus(`✅ Login successful! Welcome ${username}.`, 'success');
          // Hide login, show app
          showApp();
        } else {
          setLoginStatus('❌ Login failed: invalid response.', 'error');
        }
      } catch (err) {
        console.error('Login error:', err);
        setLoginStatus('❌ Login failed: ' + (err.message || 'Unknown error'), 'error');
      }
    }

    // UI helpers for login screen
    const loginScreen = document.getElementById('loginScreen');
    const loginStatus = document.getElementById('loginStatus');
    const loginUsername = document.getElementById('loginUsername');
    const loginRegisterBtn = document.getElementById('loginRegisterBtn');
    const loginAuthBtn = document.getElementById('loginAuthBtn');

    function setLoginStatus(msg, type = 'info') {
      loginStatus.textContent = msg;
      loginStatus.className = 'login-status';
      if (type === 'success') loginStatus.classList.add('success');
      else if (type === 'error') loginStatus.classList.add('error');
      else if (type === 'loading') loginStatus.classList.add('loading');
    }

    // Show app and hide login
    function showApp() {
      loginScreen.classList.add('hidden');
      document.getElementById('appShell').classList.add('visible');
      // Initialize app if not already done
      if (!window._appInitialized) {
        initApp();
        window._appInitialized = true;
      }
      // Switch to dashboard
      switchScreen('dashboard');
    }

    // Check if user already logged in? We'll just show login always.

    // Event listeners
    loginRegisterBtn.addEventListener('click', () => {
      const username = loginUsername.value.trim();
      registerFingerprint(username);
    });

    loginAuthBtn.addEventListener('click', () => {
      const username = loginUsername.value.trim();
      loginFingerprint(username);
    });

    // Allow Enter key on username field to trigger login
    loginUsername.addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        loginAuthBtn.click();
      }
    });

    // Expose functions globally for debugging
    window.__webauthn = { registerFingerprint, loginFingerprint, getCredentialData };
  })();

  // ============================================================
  // YOUR ORIGINAL APP CODE (with minor adjustments)
  // ============================================================

  // -------------------- STATE --------------------
  let allTransactions = [];
  let allSavings = [];
  let categoryLimits = {};
  let currentMonth = new Date().toISOString().slice(0, 7);
  let emergencyBalance = 0;
  let sanlamBalance = 0;
  let monthlyStipend = 300000;
  let monthlyBudget = 300000;
  let editingTxId = null;

  const CATEGORIES = [
    { id: 'breakfast', label: 'Breakfast', icon: 'fa-egg', type: 'expense' },
    { id: 'lunch', label: 'Lunch', icon: 'fa-utensils', type: 'expense' },
    { id: 'supper', label: 'Supper', icon: 'fa-moon', type: 'expense' },
    { id: 'social', label: 'Social / Sport', icon: 'fa-futbol', type: 'expense' },
    { id: 'household', label: 'Household', icon: 'fa-soap', type: 'expense' },
    { id: 'airtime', label: 'Airtime & Data', icon: 'fa-wifi', type: 'expense' },
    { id: 'unaccounted', label: 'Unaccounted', icon: 'fa-question-circle', type: 'expense' },
    { id: 'income_stipend', label: 'Stipend', icon: 'fa-hand-holding-usd', type: 'income' },
    { id: 'income_government', label: 'Govt Fund', icon: 'fa-university', type: 'income' },
    { id: 'income_family', label: 'Family Top-Up', icon: 'fa-users', type: 'income' },
  ];

  const EXPENSE_CATEGORIES = CATEGORIES.filter(c => c.type === 'expense');
  const DEFAULT_BUDGETS = {
    breakfast: 30000,
    lunch: 40000,
    supper: 40000,
    social: 50000,
    household: 20000,
    airtime: 15000,
    unaccounted: 10000,
  };

  // -------------------- DOM REFS --------------------
  const $ = (sel) => document.querySelector(sel);
  const $$ = (sel) => document.querySelectorAll(sel);

  const screens = {
    dashboard: $('#screen-dashboard'),
    log: $('#screen-log'),
    transactions: $('#screen-transactions'),
    report: $('#screen-report'),
    savings: $('#screen-savings'),
    calendar: $('#screen-calendar'),
  };

  const navItems = $$('.nav-item');
  const fabLog = $('#fabLog');

  // -------------------- UI HELPERS --------------------
  function formatMoney(amount) {
    return Math.round(amount).toLocaleString('en-UG');
  }

  function getCategoryIcon(id) {
    const cat = CATEGORIES.find(c => c.id === id);
    return cat ? cat.icon : 'fa-circle';
  }

  function getCategoryLabel(id) {
    const cat = CATEGORIES.find(c => c.id === id);
    return cat ? cat.label : id;
  }

  function updateAllScreens() {
    updateDashboard();
    updateTransactions();
    updateReport();
    updateSavingsUI();
    updateCalendar();
    updateStipendUI();
    updateBudgetUI();
  }

  // -------------------- BUDGET SETTINGS --------------------
  function loadBudget() {
    const saved = localStorage.getItem('easesave_budget');
    if (saved) {
      monthlyBudget = parseFloat(saved);
    } else {
      monthlyBudget = 300000;
      localStorage.setItem('easesave_budget', monthlyBudget.toString());
    }
  }

  function saveBudget(amount) {
    if (amount && amount > 0) {
      monthlyBudget = amount;
      localStorage.setItem('easesave_budget', monthlyBudget.toString());
      updateAllScreens();
      showAlert(`Budget updated to ${formatMoney(monthlyBudget)} UGX`, 'success');
      return true;
    }
    return false;
  }

  function updateBudgetUI() {
    const input = $('#budgetAmountInput');
    if (input) input.value = monthlyBudget;
    const display = $('#budgetDisplay');
    if (display) display.textContent = formatMoney(monthlyBudget);
  }

  function setupBudget() {
    loadBudget();
    updateBudgetUI();
    
    $('#saveBudgetBtn').addEventListener('click', () => {
      const val = parseFloat($('#budgetAmountInput').value);
      if (val && val > 0) {
        saveBudget(val);
      } else {
        showAlert('Please enter a valid budget amount.', 'danger');
      }
    });
    
    $('#budgetAmountInput').addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        $('#saveBudgetBtn').click();
      }
    });
  }

  // -------------------- SAMPLE DATA --------------------
  function seedSampleData() {
    const now = new Date();
    const today = now.toISOString().slice(0, 10);
    const month = now.toISOString().slice(0, 7);
    const yesterday = new Date(now);
    yesterday.setDate(now.getDate() - 1);
    const yestStr = yesterday.toISOString().slice(0, 10);

    const sampleTxs = [
      { id: '1', date: today, amount: 5000, type: 'expense', category: 'breakfast', account: 'cash', note: 'Breakfast at Nakasero', created_at: new Date().toISOString() },
      { id: '2', date: today, amount: 12000, type: 'expense', category: 'lunch', account: 'momo', note: 'Lunch with colleagues', created_at: new Date().toISOString() },
      { id: '3', date: yestStr, amount: 25000, type: 'expense', category: 'social', account: 'cash', note: 'Football game', created_at: new Date().toISOString() },
      { id: '4', date: yestStr, amount: 15000, type: 'expense', category: 'airtime', account: 'momo', note: 'Monthly data bundle', created_at: new Date().toISOString() },
      { id: '5', date: today, amount: 15000, type: 'expense', category: 'unaccounted', account: 'cash', note: 'Miscellaneous', created_at: new Date().toISOString() },
    ];

    const sampleSavings = [
      { id: 's1', date: today, amount: 25000, direction: 'deposit', reason: 'regular', sanlam_balance_after: 25000, note: 'Auto-save from stipend', created_at: new Date().toISOString() },
      { id: 's2', date: yestStr, amount: 10000, direction: 'deposit', reason: 'regular', sanlam_balance_after: 10000, note: 'Manual savings', created_at: new Date().toISOString() },
    ];

    if (allTransactions.length === 0) allTransactions = sampleTxs;
    if (allSavings.length === 0) allSavings = sampleSavings;

    computeBalances();
    emergencyBalance = 20000;
    categoryLimits = { ...DEFAULT_BUDGETS };
    saveLocalData();
  }

  function computeBalances() {
    let balance = 0;
    allSavings.forEach(s => {
      if (s.direction === 'deposit') balance += s.amount;
      else balance -= s.amount;
    });
    sanlamBalance = balance;
  }

  function saveLocalData() {
    localStorage.setItem('easesave_txs', JSON.stringify(allTransactions));
    localStorage.setItem('easesave_savings', JSON.stringify(allSavings));
    localStorage.setItem('emergencyBalance', emergencyBalance.toString());
    localStorage.setItem('monthlyStipend', monthlyStipend.toString());
    localStorage.setItem('easesave_budget', monthlyBudget.toString());
  }

  function loadLocalData() {
    const localTxs = localStorage.getItem('easesave_txs');
    allTransactions = localTxs ? JSON.parse(localTxs) : [];
    const localSavings = localStorage.getItem('easesave_savings');
    allSavings = localSavings ? JSON.parse(localSavings) : [];
    const emg = localStorage.getItem('emergencyBalance');
    emergencyBalance = emg ? parseFloat(emg) : 0;
    const stip = localStorage.getItem('monthlyStipend');
    monthlyStipend = stip ? parseFloat(stip) : 300000;
    loadBudget();
    categoryLimits = { ...DEFAULT_BUDGETS };
    computeBalances();
  }

  // -------------------- DASHBOARD --------------------
  function updateDashboard() {
    const now = new Date();
    const year = now.getFullYear();
    const month = now.getMonth();
    const daysInMonth = new Date(year, month + 1, 0).getDate();
    const dayOfMonth = now.getDate();
    const daysLeft = daysInMonth - dayOfMonth;

    const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    const dayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    $('#dateMain').textContent = dayNames[now.getDay()];
    $('#dateSub').textContent = `${monthNames[month]} ${dayOfMonth}, ${year}`;
    $('#dateDay').textContent = dayOfMonth;

    const monthStr = now.toISOString().slice(0, 7);
    const monthTxs = allTransactions.filter(t => t.date && t.date.startsWith(monthStr));
    const totalExpenses = monthTxs.filter(t => t.type === 'expense').reduce((sum, t) => sum + t.amount, 0);
    const budget = monthlyBudget;
    const remaining = Math.max(0, budget - totalExpenses);
    const percent = Math.min(100, (totalExpenses / budget) * 100);

    const canvas = $('#pulseCanvas');
    const ctx = canvas.getContext('2d');
    const w = 140, h = 140;
    ctx.clearRect(0, 0, w, h);
    const cx = w / 2, cy = h / 2, r = 56, lineWidth = 12;
    const startAngle = -Math.PI / 2;
    const endAngle = startAngle + (percent / 100) * 2 * Math.PI;
    ctx.beginPath();
    ctx.arc(cx, cy, r, 0, 2 * Math.PI);
    ctx.strokeStyle = '#1A2A2A';
    ctx.lineWidth = lineWidth;
    ctx.stroke();
    const color = percent < 70 ? '#5BA87A' : (percent < 90 ? '#F5A623' : '#E05C5C');
    ctx.beginPath();
    ctx.arc(cx, cy, r, startAngle, Math.min(endAngle, startAngle + 2 * Math.PI));
    ctx.strokeStyle = color;
    ctx.lineWidth = lineWidth;
    ctx.lineCap = 'round';
    ctx.stroke();

    $('#dialPercent').textContent = Math.round(percent) + '%';
    $('#remainingBudget').textContent = formatMoney(remaining);
    $('#daysLeft').textContent = daysLeft;
    const burnRate = daysLeft > 0 ? Math.round(remaining / daysLeft) : 0;
    $('#burnRate').textContent = formatMoney(burnRate);

    const monthSavings = allSavings.filter(s => s.date && s.date.startsWith(monthStr) && s.direction === 'deposit')
      .reduce((sum, s) => sum + s.amount, 0);
    $('#sanlamBalance').textContent = formatMoney(sanlamBalance);
    $('#monthlySaved').textContent = formatMoney(monthSavings);
    const savePercent = Math.min(100, (monthSavings / 25000) * 100);
    $('#sanlamProgress').style.width = savePercent + '%';

    const emgGoal = 100000;
    const emgPercent = Math.min(100, (emergencyBalance / emgGoal) * 100);
    $('#emergencyBalance').textContent = formatMoney(emergencyBalance);
    $('#emergencyPercent').textContent = Math.round(emgPercent) + '%';
    $('#emergencyProgress').style.width = emgPercent + '%';

    const container = $('#categoryBars');
    container.innerHTML = '';
    EXPENSE_CATEGORIES.forEach(cat => {
      const spent = monthTxs.filter(t => t.category === cat.id && t.type === 'expense')
        .reduce((sum, t) => sum + t.amount, 0);
      const limit = categoryLimits[cat.id] || 0;
      const pct = limit > 0 ? Math.min(100, (spent / limit) * 100) : 0;
      const color = pct < 80 ? '#5BA87A' : (pct < 100 ? '#F5A623' : '#E05C5C');
      container.innerHTML += `
          <div style="margin-bottom:6px;">
            <div class="flex-row">
              <span style="font-size:13px; color:var(--text-secondary);">${cat.label}</span>
              <span style="font-size:13px; color:var(--text-secondary);">${formatMoney(spent)} / ${formatMoney(limit)}</span>
            </div>
            <div class="progress-bar"><div class="progress-fill" style="width:${pct}%; background:${color};"></div></div>
          </div>
        `;
    });

    const recent = allTransactions.slice(0, 3);
    const recentContainer = $('#recentTxs');
    recentContainer.innerHTML = '';
    if (recent.length === 0) {
      recentContainer.innerHTML = '<div class="text-muted" style="padding:12px 0;">No transactions yet.</div>';
    } else {
      recent.forEach(tx => {
        const isExpense = tx.type === 'expense';
        const icon = getCategoryIcon(tx.category);
        const label = getCategoryLabel(tx.category);
        recentContainer.innerHTML += `
            <div class="tx-item">
              <div class="tx-icon"><i class="fas ${icon}"></i></div>
              <div class="tx-info">
                <div class="tx-note">${tx.note || label}</div>
                <div class="tx-meta">${tx.date ? tx.date.slice(0,10) : ''} · ${label}</div>
              </div>
              <div class="tx-amount ${isExpense ? 'expense' : 'income'}">${isExpense ? '-' : '+'}${formatMoney(tx.amount)}</div>
            </div>
          `;
      });
    }

    checkAlerts();
  }

  // -------------------- LOG TRANSACTION --------------------
  let selectedCategory = null;
  let amountString = '';

  function setupCategoryGrid() {
    const grid = $('#categoryGrid');
    grid.innerHTML = '';
    CATEGORIES.forEach(cat => {
      const div = document.createElement('div');
      div.className = `category-chip ${cat.type}`;
      div.dataset.id = cat.id;
      div.innerHTML = `<i class="fas ${cat.icon}"></i><span>${cat.label}</span>`;
      div.addEventListener('click', () => {
        document.querySelectorAll('.category-chip').forEach(el => el.classList.remove('selected'));
        div.classList.add('selected');
        selectedCategory = cat.id;
      });
      grid.appendChild(div);
    });
    const firstExpense = grid.querySelector('.category-chip.expense');
    if (firstExpense) {
      firstExpense.classList.add('selected');
      selectedCategory = firstExpense.dataset.id;
    }
  }

  function setupNumPad() {
    const pad = $('#numPad');
    pad.addEventListener('click', (e) => {
      const btn = e.target.closest('button');
      if (!btn) return;
      const val = btn.dataset.value;
      const input = $('#amountInput');
      if (val === 'clear') {
        amountString = amountString.slice(0, -1);
      } else if (val === 'clear-all') {
        amountString = '';
      } else if (val === 'submit') {
        submitTransaction();
        return;
      } else {
        amountString += val;
      }
      input.value = amountString ? formatMoney(parseFloat(amountString)) : '';
    });
  }

  function setupDateInput() {
    const now = new Date();
    const dateStr = now.toISOString().slice(0, 10);
    $('#dateInput').value = dateStr;
  }

  async function submitTransaction() {
    const amount = parseFloat(amountString);
    if (!amount || amount <= 0) {
      showLogError('Please enter a valid amount.');
      return;
    }
    if (!selectedCategory) {
      showLogError('Please select a category.');
      return;
    }

    const account = $('#accountSelect').value;
    const note = $('#noteInput').value.trim() || getCategoryLabel(selectedCategory);
    const date = $('#dateInput').value || new Date().toISOString().slice(0, 10);

    const cat = CATEGORIES.find(c => c.id === selectedCategory);
    const type = cat ? cat.type : 'expense';

    if (type === 'income' && !editingTxId) {
      if (selectedCategory === 'income_stipend') {
        const confirmSave = confirm('Stipend income detected. You must save 25,000 UGX to Sanlam. Continue?');
        if (!confirmSave) return;
        await logSavings(25000, 'deposit', 'regular', `Auto-save from stipend on ${date}`);
        showAlert('Reminder: 25k saved to Sanlam ✅', 'success');
      } else {
        const saveFirst = confirm('Irregular income detected. Would you like to save a portion to Sanlam? (Recommended)');
        if (saveFirst) {
          const amountToSave = prompt('Enter amount to save (UGX):', '25000');
          if (amountToSave && !isNaN(amountToSave) && parseFloat(amountToSave) > 0) {
            await logSavings(parseFloat(amountToSave), 'deposit', 'regular', `Savings from irregular income on ${date}`);
            showAlert('Savings logged ✅', 'success');
          }
        }
      }
    }

    const txData = {
      date: date,
      amount: amount,
      type: type,
      category: selectedCategory,
      account: account,
      note: note,
    };

    if (editingTxId) {
      const index = allTransactions.findIndex(t => t.id === editingTxId);
      if (index !== -1) allTransactions[index] = { ...allTransactions[index], ...txData };
    } else {
      const newTx = { id: Date.now().toString(), ...txData, created_at: new Date().toISOString() };
      allTransactions.unshift(newTx);
    }
    saveLocalData();

    editingTxId = null;
    $('#submitTxBtn').textContent = 'Submit Transaction';
    showCancelButton(false);

    amountString = '';
    $('#amountInput').value = '';
    $('#noteInput').value = '';
    selectedCategory = null;
    document.querySelectorAll('.category-chip').forEach(el => el.classList.remove('selected'));
    const firstExpense = document.querySelector('.category-chip.expense');
    if (firstExpense) {
      firstExpense.classList.add('selected');
      selectedCategory = firstExpense.dataset.id;
    }
    showLogError('', false);
    updateAllScreens();
    switchScreen('dashboard');
  }

  function showLogError(msg, show = true) {
    const el = $('#logError');
    if (show && msg) {
      el.textContent = msg;
      el.style.display = 'block';
    } else {
      el.style.display = 'none';
    }
  }

  function showCancelButton(show) {
    const cancelBtn = $('#cancelEditBtn');
    if (show) {
      cancelBtn.style.display = 'inline-block';
      if (!cancelBtn._listener) {
        cancelBtn.addEventListener('click', () => {
          editingTxId = null;
          $('#submitTxBtn').textContent = 'Submit Transaction';
          showCancelButton(false);
          amountString = '';
          $('#amountInput').value = '';
          $('#noteInput').value = '';
          const firstExpense = document.querySelector('.category-chip.expense');
          if (firstExpense) {
            firstExpense.classList.add('selected');
            selectedCategory = firstExpense.dataset.id;
          }
          switchScreen('dashboard');
        });
        cancelBtn._listener = true;
      }
    } else {
      cancelBtn.style.display = 'none';
    }
  }

  function editTransaction(id) {
    const tx = allTransactions.find(t => t.id === id);
    if (!tx) return;
    amountString = tx.amount.toString();
    $('#amountInput').value = formatMoney(tx.amount);
    selectedCategory = tx.category;
    document.querySelectorAll('.category-chip').forEach(el => {
      el.classList.toggle('selected', el.dataset.id === tx.category);
    });
    $('#accountSelect').value = tx.account || 'cash';
    $('#noteInput').value = tx.note || '';
    $('#dateInput').value = tx.date || new Date().toISOString().slice(0, 10);
    editingTxId = id;
    $('#submitTxBtn').textContent = 'Update Transaction';
    showCancelButton(true);
    switchScreen('log');
  }

  async function deleteTransaction(id) {
    if (!confirm('Delete this transaction?')) return;
    allTransactions = allTransactions.filter(t => t.id !== id);
    saveLocalData();
    updateAllScreens();
  }

  // -------------------- TRANSACTIONS LIST --------------------
  function updateTransactions() {
    const container = $('#txList');
    const categoryFilter = $('#filterCategory').value;
    const monthFilter = $('#filterMonth').value;

    let filtered = allTransactions;
    if (categoryFilter !== 'all') filtered = filtered.filter(t => t.category === categoryFilter);
    if (monthFilter !== 'all') filtered = filtered.filter(t => t.date && t.date.startsWith(monthFilter));

    $('#txCount').textContent = filtered.length;

    if (filtered.length === 0) {
      container.innerHTML = '<div class="text-muted" style="padding:20px 0; text-align:center;">No transactions found.</div>';
      return;
    }

    let html = '';
    filtered.forEach(tx => {
      const isExpense = tx.type === 'expense';
      const icon = getCategoryIcon(tx.category);
      const label = getCategoryLabel(tx.category);
      html += `
          <div class="tx-item">
            <div class="tx-icon"><i class="fas ${icon}"></i></div>
            <div class="tx-info">
              <div class="tx-note">${tx.note || label}</div>
              <div class="tx-meta">${tx.date ? tx.date.slice(0,10) : ''} · ${label} · ${tx.account || ''}</div>
            </div>
            <div class="tx-amount ${isExpense ? 'expense' : 'income'}">${isExpense ? '-' : '+'}${formatMoney(tx.amount)}</div>
            <div class="tx-actions">
              <button class="edit-btn" data-id="${tx.id}" title="Edit"><i class="fas fa-pen"></i></button>
              <button class="delete-btn" data-id="${tx.id}" title="Delete"><i class="fas fa-trash"></i></button>
            </div>
          </div>
        `;
    });
    container.innerHTML = html;

    container.querySelectorAll('.edit-btn').forEach(btn => {
      btn.addEventListener('click', () => editTransaction(btn.dataset.id));
    });
    container.querySelectorAll('.delete-btn').forEach(btn => {
      btn.addEventListener('click', () => deleteTransaction(btn.dataset.id));
    });
  }

  function setupFilters() {
    const categorySelect = $('#filterCategory');
    categorySelect.innerHTML = '<option value="all">All Categories</option>';
    CATEGORIES.forEach(cat => {
      const opt = document.createElement('option');
      opt.value = cat.id;
      opt.textContent = cat.label;
      categorySelect.appendChild(opt);
    });
    categorySelect.addEventListener('change', updateTransactions);

    const monthSelect = $('#filterMonth');
    monthSelect.innerHTML = '<option value="all">All Months</option>';
    const months = new Set();
    allTransactions.forEach(t => { if (t.date) months.add(t.date.slice(0, 7)); });
    [...months].sort().forEach(m => {
      const opt = document.createElement('option');
      opt.value = m;
      const [year, month] = m.split('-');
      const date = new Date(year, month - 1);
      opt.textContent = date.toLocaleString('default', { month: 'long', year: 'numeric' });
      monthSelect.appendChild(opt);
    });
    monthSelect.addEventListener('change', updateTransactions);
  }

  // -------------------- REPORT --------------------
  function setupReport() {
    const reportMonth = $('#reportMonth');
    reportMonth.value = currentMonth;
    $('#loadReportBtn').addEventListener('click', updateReport);
    updateReport();
  }

  function updateReport() {
    const month = $('#reportMonth').value || currentMonth;
    const monthTxs = allTransactions.filter(t => t.date && t.date.startsWith(month));

    const totalIncome = monthTxs.filter(t => t.type === 'income').reduce((sum, t) => sum + t.amount, 0);
    const totalExpenses = monthTxs.filter(t => t.type === 'expense').reduce((sum, t) => sum + t.amount, 0);
    const savings = allSavings.filter(s => s.date && s.date.startsWith(month) && s.direction === 'deposit')
      .reduce((sum, s) => sum + s.amount, 0);
    const unaccounted = monthTxs.filter(t => t.category === 'unaccounted' && t.type === 'expense')
      .reduce((sum, t) => sum + t.amount, 0);

    $('#reportIncome').textContent = formatMoney(totalIncome);
    $('#reportExpenses').textContent = formatMoney(totalExpenses);
    $('#reportSavings').textContent = formatMoney(savings);
    $('#reportUnaccounted').textContent = formatMoney(unaccounted);

    const tbody = $('#reportCategoryBody');
    tbody.innerHTML = '';
    EXPENSE_CATEGORIES.forEach(cat => {
      const spent = monthTxs.filter(t => t.category === cat.id && t.type === 'expense')
        .reduce((sum, t) => sum + t.amount, 0);
      const budget = categoryLimits[cat.id] || 0;
      const variance = budget - spent;
      const varClass = variance >= 0 ? 'variance-positive' : 'variance-negative';
      tbody.innerHTML += `
          <tr>
            <td>${cat.label}</td>
            <td>${formatMoney(budget)}</td>
            <td>${formatMoney(spent)}</td>
            <td class="${varClass}">${formatMoney(variance)}</td>
          </tr>
        `;
    });
  }

  // -------------------- SAVINGS --------------------
  function setupSavings() {
    $('#logSavingsBtn').addEventListener('click', async () => {
      const amount = parseFloat($('#savingsAmount').value);
      if (!amount || amount <= 0) {
        showSavingsError('Enter a valid amount.');
        return;
      }
      const direction = $('#savingsDirection').value;
      const reason = $('#savingsReason').value;
      await logSavings(amount, direction, reason, 'Manual log');
      $('#savingsAmount').value = '';
      updateSavingsUI();
    });
  }

  async function logSavings(amount, direction, reason, note) {
    const date = new Date().toISOString().slice(0, 10);
    const newEntry = {
      id: Date.now().toString(),
      date: date,
      amount: amount,
      direction: direction,
      reason: reason,
      sanlam_balance_after: sanlamBalance + (direction === 'deposit' ? amount : -amount),
      note: note || '',
      created_at: new Date().toISOString(),
    };

    allSavings.unshift(newEntry);
    saveLocalData();
    if (direction === 'deposit') sanlamBalance += amount;
    else sanlamBalance -= amount;

    updateSavingsUI();
    updateDashboard();
  }

  function updateSavingsUI() {
    $('#savingsSanlamBalance').textContent = formatMoney(sanlamBalance);
    const emgGoal = 100000;
    const emgPercent = Math.min(100, (emergencyBalance / emgGoal) * 100);
    $('#savingsEmergencyBalance').textContent = formatMoney(emergencyBalance);
    $('#savingsEmergencyProgress').style.width = emgPercent + '%';

    const container = $('#savingsHistory');
    container.innerHTML = '';
    if (allSavings.length === 0) {
      container.innerHTML = '<div class="text-muted">No savings logs.</div>';
    } else {
      allSavings.slice(0, 20).forEach(s => {
        const dir = s.direction === 'deposit' ? '+' : '-';
        const cls = s.direction === 'deposit' ? 'dir-deposit' : 'dir-withdrawal';
        container.innerHTML += `
            <div class="savings-item">
              <span>${s.date ? s.date.slice(0,10) : ''} ${s.reason || ''} ${s.note ? '· '+s.note : ''}</span>
              <span class="${cls}">${dir}${formatMoney(s.amount)}</span>
            </div>
          `;
      });
    }

    drawSavingsChart();
    updateStipendUI();
  }

  function drawSavingsChart() {
    const canvas = $('#savingsChart');
    const ctx = canvas.getContext('2d');
    const w = canvas.width, h = canvas.height;
    ctx.clearRect(0, 0, w, h);

    const monthlyNet = {};
    allSavings.forEach(s => {
      const month = s.date ? s.date.slice(0, 7) : '';
      if (!month) return;
      if (!monthlyNet[month]) monthlyNet[month] = 0;
      monthlyNet[month] += (s.direction === 'deposit' ? s.amount : -s.amount);
    });
    const months = Object.keys(monthlyNet).sort();
    if (months.length === 0) {
      ctx.fillStyle = '#8B949E';
      ctx.font = '12px DM Sans';
      ctx.fillText('No data yet', 10, 60);
      return;
    }
    const values = months.map(m => monthlyNet[m]);
    const maxVal = Math.max(0, ...values, 1000);
    const barWidth = Math.min(40, (w - 20) / months.length - 4);
    const startX = 10;

    values.forEach((val, i) => {
      const x = startX + i * (barWidth + 4);
      const height = (val / maxVal) * (h - 20);
      const y = h - 10 - height;
      ctx.fillStyle = val >= 0 ? '#5BA87A' : '#E05C5C';
      ctx.fillRect(x, y, barWidth, height);
      ctx.fillStyle = '#8B949E';
      ctx.font = '8px DM Sans';
      const label = months[i].slice(5);
      ctx.fillText(label, x, h - 2);
    });
  }

  function showSavingsError(msg) {
    const el = $('#savingsError');
    el.textContent = msg;
    el.style.display = 'block';
    setTimeout(() => el.style.display = 'none', 3000);
  }

  // -------------------- STIPEND TRACKER (editable) --------------------
  function setupStipend() {
    $('#stipendAmountInput').value = monthlyStipend;
    updateStipendUI();

    $('#saveStipendBtn').addEventListener('click', () => {
      const val = parseFloat($('#stipendAmountInput').value);
      if (val && val > 0) {
        monthlyStipend = val;
        saveLocalData();
        updateStipendUI();
        showAlert(`Stipend amount updated to ${formatMoney(monthlyStipend)} UGX`, 'success');
      } else {
        showAlert('Please enter a valid amount.', 'danger');
      }
    });

    $('#markStipendBtn').addEventListener('click', markStipendReceived);
  }

  function updateStipendUI() {
    const now = new Date();
    const monthStr = now.toISOString().slice(0, 7);
    const stipendTx = allTransactions.find(t =>
      t.category === 'income_stipend' && t.date && t.date.startsWith(monthStr)
    );
    const statusEl = $('#stipendStatus');
    const btn = $('#markStipendBtn');
    const input = $('#stipendAmountInput');

    if (stipendTx) {
      statusEl.textContent = `${formatMoney(monthlyStipend)} UGX received this month ✅`;
      statusEl.className = 'stipend-status sage';
      btn.textContent = 'Stipend received this month ✅';
      btn.disabled = true;
      btn.style.opacity = '0.6';
      btn.style.cursor = 'default';
    } else {
      statusEl.textContent = `Not yet received ⏳ (${formatMoney(monthlyStipend)} UGX)`;
      statusEl.className = 'stipend-status amber';
      btn.textContent = 'Mark Stipend as Received';
      btn.disabled = false;
      btn.style.opacity = '1';
      btn.style.cursor = 'pointer';
    }

    input.value = monthlyStipend;
  }

  async function markStipendReceived() {
    const now = new Date();
    const monthStr = now.toISOString().slice(0, 7);
    const existing = allTransactions.find(t =>
      t.category === 'income_stipend' && t.date && t.date.startsWith(monthStr)
    );
    if (existing) {
      updateStipendUI();
      return;
    }

    const date = now.toISOString().slice(0, 10);
    const txData = {
      date: date,
      amount: monthlyStipend,
      type: 'income',
      category: 'income_stipend',
      account: 'cash',
      note: 'Monthly stipend',
    };

    const newTx = { id: Date.now().toString(), ...txData, created_at: new Date().toISOString() };
    allTransactions.unshift(newTx);
    saveLocalData();
    await logSavings(25000, 'deposit', 'regular', `Auto-save from stipend on ${date}`);
    showAlert(`Stipend (${formatMoney(monthlyStipend)} UGX) logged and 25k saved to Sanlam ✅`, 'success');
    updateAllScreens();
  }

  // -------------------- ALERTS --------------------
  function checkAlerts() {
    const container = $('#alertContainer');
    container.innerHTML = '';
    const now = new Date();
    const monthStr = now.toISOString().slice(0, 7);
    const monthTxs = allTransactions.filter(t => t.date && t.date.startsWith(monthStr));
    const totalExpenses = monthTxs.filter(t => t.type === 'expense').reduce((sum, t) => sum + t.amount, 0);
    const budget = monthlyBudget;
    const remaining = budget - totalExpenses;

    const socialSpent = monthTxs.filter(t => t.category === 'social' && t.type === 'expense')
      .reduce((sum, t) => sum + t.amount, 0);
    if (socialSpent >= 40000 && socialSpent < 50000) {
      showAlert(`Social spending at ${formatMoney(socialSpent)} (80% of cap)`, 'warning');
    }
    if (socialSpent >= 50000) {
      showAlert(`Social spending exceeded cap of 50,000!`, 'danger');
    }

    const daysInMonth = new Date(now.getFullYear(), now.getMonth() + 1, 0).getDate();
    const daysLeft = daysInMonth - now.getDate();
    if (remaining < 50000 && daysLeft > 10) {
      showAlert(`Cash on hand low (${formatMoney(remaining)}) with ${daysLeft} days left.`, 'danger');
    }

    if (now.getDate() === daysInMonth) {
      const unaccounted = monthTxs.filter(t => t.category === 'unaccounted' && t.type === 'expense')
        .reduce((sum, t) => sum + t.amount, 0);
      if (unaccounted > 20000) {
        showAlert(`Unaccounted expenses this month: ${formatMoney(unaccounted)}. Please review.`, 'danger');
      }
    }
  }

  function showAlert(message, type = 'warning') {
    const container = $('#alertContainer');
    const div = document.createElement('div');
    div.className = `alert-banner ${type === 'danger' ? 'danger' : (type === 'success' ? 'success' : '')}`;
    div.textContent = message;
    container.appendChild(div);
  }

  // -------------------- CALENDAR --------------------
  let calYear = new Date().getFullYear();
  let calMonth = new Date().getMonth();
  let selectedDate = null;

  function renderCalendar(year, month) {
    const grid = $('#calendarGrid');
    const monthNames = ['January','February','March','April','May','June','July','August','September','October','November','December'];
    $('#calMonthYear').textContent = `${monthNames[month]} ${year}`;

    let html = '';
    const weekdays = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    weekdays.forEach(w => { html += `<div style="font-weight:600; color:var(--text-secondary); text-align:center; font-size:13px; padding:4px 0;">${w}</div>`; });

    const firstDay = new Date(year, month, 1).getDay();
    const daysInMonth = new Date(year, month + 1, 0).getDate();
    let startOffset = (firstDay === 0) ? 6 : firstDay - 1;
    let dayCount = 1;

    for (let i = 0; i < 42; i++) {
      if (i < startOffset || dayCount > daysInMonth) {
        html += `<div style="padding:6px 0;"></div>`;
        continue;
      }
      const dateStr = `${year}-${String(month+1).padStart(2,'0')}-${String(dayCount).padStart(2,'0')}`;
      const hasTx = allTransactions.some(t => t.date && t.date.startsWith(dateStr));
      const isToday = (new Date().toISOString().slice(0,10) === dateStr);
      const classes = ['cal-day'];
      if (hasTx) classes.push('has-tx');
      if (isToday) classes.push('today');
      html += `
        <div class="${classes.join(' ')}" data-date="${dateStr}">
          ${dayCount}
          ${hasTx ? '<div class="dot"></div>' : ''}
        </div>
      `;
      dayCount++;
    }

    grid.innerHTML = html;

    grid.querySelectorAll('.cal-day').forEach(el => {
      if (el.dataset.date) {
        el.addEventListener('click', () => {
          selectedDate = el.dataset.date;
          showDayTransactions(selectedDate);
        });
      }
    });

    if (selectedDate) {
      showDayTransactions(selectedDate);
    } else {
      const today = new Date().toISOString().slice(0,10);
      if (today.startsWith(`${year}-${String(month+1).padStart(2,'0')}`)) {
        selectedDate = today;
        showDayTransactions(today);
      }
    }
  }

  function showDayTransactions(dateStr) {
    const container = $('#dayTransactions');
    const list = $('#dayTxList');
    const label = $('#selectedDayLabel');
    const count = $('#selectedDayCount');

    const txs = allTransactions.filter(t => t.date && t.date.startsWith(dateStr));
    if (txs.length === 0) {
      container.style.display = 'none';
      return;
    }

    container.style.display = 'block';
    label.textContent = `Transactions for ${dateStr}`;
    count.textContent = txs.length;

    list.innerHTML = '';
    txs.forEach(tx => {
      const isExpense = tx.type === 'expense';
      const icon = getCategoryIcon(tx.category);
      const catLabel = getCategoryLabel(tx.category);
      list.innerHTML += `
        <div class="tx-item">
          <div class="tx-icon"><i class="fas ${icon}"></i></div>
          <div class="tx-info">
            <div class="tx-note">${tx.note || catLabel}</div>
            <div class="tx-meta">${catLabel}</div>
          </div>
          <div class="tx-amount ${isExpense ? 'expense' : 'income'}">${isExpense ? '-' : '+'}${formatMoney(tx.amount)}</div>
        </div>
      `;
    });

    document.querySelectorAll('.cal-day').forEach(el => {
      const isSelected = el.dataset.date === dateStr;
      el.style.background = isSelected ? 'rgba(124,92,191,0.12)' : (el.classList.contains('has-tx') ? 'rgba(91,168,122,0.06)' : 'transparent');
      el.style.fontWeight = isSelected ? '700' : (el.classList.contains('today') ? '700' : '400');
    });
  }

  function setupCalendarNav() {
    $('#calPrev').addEventListener('click', () => {
      calMonth--;
      if (calMonth < 0) { calMonth = 11; calYear--; }
      renderCalendar(calYear, calMonth);
    });
    $('#calNext').addEventListener('click', () => {
      calMonth++;
      if (calMonth > 11) { calMonth = 0; calYear++; }
      renderCalendar(calYear, calMonth);
    });
  }

  function updateCalendar() {
    const now = new Date();
    if (calYear !== now.getFullYear() || calMonth !== now.getMonth()) {
      calYear = now.getFullYear();
      calMonth = now.getMonth();
    }
    renderCalendar(calYear, calMonth);
  }

  // -------------------- NAVIGATION --------------------
  function setupNav() {
    navItems.forEach(item => {
      item.addEventListener('click', () => {
        const screen = item.dataset.screen;
        switchScreen(screen);
      });
    });

    fabLog.addEventListener('click', () => {
      switchScreen('log');
    });

    setupCalendarNav();

    // Logout button
    $('#logoutBtn').addEventListener('click', () => {
      if (confirm('Logout?')) {
        document.getElementById('appShell').classList.remove('visible');
        document.getElementById('loginScreen').classList.remove('hidden');
        // Reset login status
        document.getElementById('loginStatus').textContent = 'Enter username, then register or login.';
        document.getElementById('loginStatus').className = 'login-status';
        document.getElementById('loginUsername').value = '';
      }
    });
  }

  function switchScreen(screenId) {
    Object.values(screens).forEach(el => el.classList.remove('active'));
    screens[screenId].classList.add('active');
    navItems.forEach(item => {
      item.classList.toggle('active', item.dataset.screen === screenId);
    });
    if (screenId === 'transactions') updateTransactions();
    if (screenId === 'report') updateReport();
    if (screenId === 'savings') { updateSavingsUI(); updateStipendUI(); updateBudgetUI(); }
    if (screenId === 'dashboard') updateDashboard();
    if (screenId === 'calendar') updateCalendar();
  }

  // -------------------- INIT (called after login) --------------------
  function initApp() {
    loadLocalData();
    if (allTransactions.length === 0 && allSavings.length === 0) {
      seedSampleData();
    } else {
      computeBalances();
    }

    setupCategoryGrid();
    setupNumPad();
    setupDateInput();
    setupNav();
    setupFilters();
    setupReport();
    setupSavings();
    setupStipend();
    setupBudget();
    updateDashboard();
    updateTransactions();
    updateReport();
    updateSavingsUI();
    updateCalendar();
    updateBudgetUI();
    checkAlerts();

    // Expose for debugging
    window.__easesave = {
      allTransactions,
      allSavings,
      monthlyStipend,
      monthlyBudget,
      updateDashboard,
      updateTransactions,
      updateReport,
      updateSavingsUI,
      updateCalendar,
      updateStipendUI,
      updateBudgetUI,
    };
  }

  // The app will be initialized when user logs in.
  console.log('EaseSave loaded with fingerprint login.');
</script>
</body>
</html>
