<%@ page import="com.example.atscv.model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - ATS CV Builder</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        body {
            background:
                    radial-gradient(circle at top left, rgba(59,130,246,0.15), transparent 25%),
                    linear-gradient(135deg, #0f172a, #111827 45%, #1e293b 100%);
            color: #ffffff;
            min-height: 100vh;
        }

        .dashboard-layout {
            display: grid;
            grid-template-columns: 280px 1fr;
            min-height: 100vh;
        }

        .sidebar {
            background: rgba(15, 23, 42, 0.95);
            border-right: 1px solid rgba(148, 163, 184, 0.12);
            padding: 28px 20px;
        }

        .brand {
            display: inline-block;
            padding: 8px 14px;
            border-radius: 999px;
            background: rgba(59, 130, 246, 0.15);
            border: 1px solid rgba(96, 165, 250, 0.28);
            color: #93c5fd;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 26px;
        }

        .user-box {
            background: rgba(30, 41, 59, 0.78);
            border: 1px solid rgba(148, 163, 184, 0.12);
            border-radius: 18px;
            padding: 18px;
            margin-bottom: 28px;
        }

        .user-box h3 {
            font-size: 18px;
            margin-bottom: 6px;
            color: #f8fafc;
        }

        .user-box p {
            color: #94a3b8;
            font-size: 13px;
            line-height: 1.5;
            word-break: break-word;
        }

        .menu-title {
            font-size: 12px;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: #64748b;
            margin-bottom: 12px;
            padding-left: 6px;
        }

        .menu {
            display: grid;
            gap: 10px;
        }

        .menu a {
            display: block;
            text-decoration: none;
            color: #e2e8f0;
            background: rgba(30, 41, 59, 0.65);
            border: 1px solid rgba(148, 163, 184, 0.10);
            padding: 14px 16px;
            border-radius: 14px;
            transition: all 0.2s ease;
            font-size: 14px;
            font-weight: 600;
        }

        .menu a:hover,
        .menu a.active {
            background: linear-gradient(135deg, rgba(37,99,235,0.28), rgba(59,130,246,0.22));
            border-color: rgba(96, 165, 250, 0.35);
            transform: translateX(2px);
        }

        .main-content {
            padding: 30px;
        }

        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 28px;
        }

        .topbar h1 {
            font-size: 32px;
            margin-bottom: 6px;
        }

        .topbar p {
            color: #94a3b8;
            font-size: 14px;
        }

        .logout-btn {
            text-decoration: none;
            color: white;
            background: linear-gradient(135deg, #dc2626, #ef4444);
            padding: 12px 18px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 700;
            box-shadow: 0 10px 20px rgba(239, 68, 68, 0.22);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            white-space: nowrap;
        }

        .logout-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 14px 24px rgba(239, 68, 68, 0.30);
        }

        .hero-card {
            background: linear-gradient(135deg, rgba(37,99,235,0.22), rgba(30,41,59,0.82));
            border: 1px solid rgba(96, 165, 250, 0.18);
            border-radius: 24px;
            padding: 30px;
            margin-bottom: 24px;
            box-shadow: 0 18px 40px rgba(0, 0, 0, 0.22);
        }

        .hero-card h2 {
            font-size: 28px;
            margin-bottom: 12px;
        }

        .hero-card p {
            color: #cbd5e1;
            font-size: 15px;
            line-height: 1.7;
            max-width: 780px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 18px;
            margin-bottom: 26px;
        }

        .stat-card {
            background: rgba(15, 23, 42, 0.82);
            border: 1px solid rgba(148, 163, 184, 0.12);
            border-radius: 20px;
            padding: 22px;
            box-shadow: 0 14px 30px rgba(0, 0, 0, 0.16);
        }

        .stat-card .label {
            color: #94a3b8;
            font-size: 13px;
            margin-bottom: 10px;
        }

        .stat-card .value {
            font-size: 30px;
            font-weight: 800;
            margin-bottom: 8px;
        }

        .stat-card .hint {
            color: #cbd5e1;
            font-size: 13px;
            line-height: 1.5;
        }

        .content-grid {
            display: grid;
            grid-template-columns: 1.2fr 0.8fr;
            gap: 20px;
        }

        .panel {
            background: rgba(15, 23, 42, 0.84);
            border: 1px solid rgba(148, 163, 184, 0.12);
            border-radius: 22px;
            padding: 24px;
            box-shadow: 0 14px 30px rgba(0, 0, 0, 0.16);
        }

        .panel h3 {
            font-size: 20px;
            margin-bottom: 8px;
        }

        .panel .panel-subtitle {
            color: #94a3b8;
            font-size: 14px;
            margin-bottom: 20px;
            line-height: 1.6;
        }

        .action-list {
            display: grid;
            gap: 14px;
        }

        .action-card {
            display: block;
            text-decoration: none;
            background: rgba(30, 41, 59, 0.75);
            border: 1px solid rgba(148, 163, 184, 0.10);
            border-radius: 16px;
            padding: 18px;
            transition: all 0.2s ease;
        }

        .action-card:hover {
            transform: translateY(-2px);
            border-color: rgba(96, 165, 250, 0.28);
            background: rgba(37, 99, 235, 0.12);
        }

        .action-card h4 {
            color: #f8fafc;
            font-size: 16px;
            margin-bottom: 6px;
        }

        .action-card p {
            color: #94a3b8;
            font-size: 14px;
            line-height: 1.6;
        }

        .progress-list {
            display: grid;
            gap: 16px;
        }

        .progress-item {
            background: rgba(30, 41, 59, 0.7);
            border-radius: 16px;
            padding: 16px;
            border: 1px solid rgba(148, 163, 184, 0.10);
        }

        .progress-item .title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 14px;
            margin-bottom: 10px;
            color: #e2e8f0;
            gap: 12px;
        }

        .bar {
            height: 10px;
            background: #1e293b;
            border-radius: 999px;
            overflow: hidden;
            margin-bottom: 8px;
        }

        .fill {
            height: 100%;
            border-radius: 999px;
            background: linear-gradient(135deg, #2563eb, #60a5fa);
        }

        .progress-item p {
            color: #94a3b8;
            font-size: 13px;
            line-height: 1.5;
        }

        @media (max-width: 1100px) {
            .stats-grid,
            .content-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 900px) {
            .dashboard-layout {
                grid-template-columns: 1fr;
            }

            .sidebar {
                border-right: none;
                border-bottom: 1px solid rgba(148, 163, 184, 0.12);
            }
        }

        @media (max-width: 650px) {
            .main-content {
                padding: 18px;
            }

            .topbar {
                flex-direction: column;
                align-items: flex-start;
            }

            .topbar h1 {
                font-size: 26px;
            }

            .hero-card,
            .panel,
            .stat-card {
                padding: 20px;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-layout">
    <aside class="sidebar">
        <div class="brand">ATS CV BUILDER</div>

        <div class="user-box">
            <h3><%= user.getFullName() %></h3>
            <p><%= user.getEmail() %></p>
        </div>

        <div class="menu-title">Navigation</div>
        <nav class="menu">
            <a href="dashboard.jsp" class="active">Dashboard</a>
            <a href="cvBuilder.jsp">Build CV</a>
            <a href="#">ATS Analysis</a>
            <a href="#">Results</a>
            <a href="logout">Logout</a>
        </nav>
    </aside>

    <main class="main-content">
        <div class="topbar">
            <div>
                <h1>Welcome back, <%= user.getFullName() %></h1>
                <p>Manage your CV, run ATS checks, and improve your application strength from one place.</p>
            </div>
            <a href="logout" class="logout-btn">Logout</a>
        </div>

        <section class="hero-card">
            <h2>Your ATS career toolkit starts here.</h2>
            <p>
                Build professional CVs, compare them against job descriptions, discover missing keywords,
                and improve your chances of passing applicant tracking systems used by employers.
            </p>
        </section>

        <section class="stats-grid">
            <div class="stat-card">
                <div class="label">Saved CVs</div>
                <div class="value">0</div>
                <div class="hint">You will see your created CVs here once the builder module is connected.</div>
            </div>

            <div class="stat-card">
                <div class="label">Latest ATS Score</div>
                <div class="value">--</div>
                <div class="hint">Your latest CV analysis score will appear here after running an ATS check.</div>
            </div>

            <div class="stat-card">
                <div class="label">Profile Status</div>
                <div class="value">New</div>
                <div class="hint">Complete your CV and run analysis to unlock stronger recommendations.</div>
            </div>
        </section>

        <section class="content-grid">
            <div class="panel">
                <h3>Quick Actions</h3>
                <p class="panel-subtitle">Use these shortcuts to move through the main features of the platform.</p>

                <div class="action-list">
                    <a href="#" class="action-card">
                        <h4>Build Your CV</h4>
                        <p>Create and structure your ATS-friendly CV with the right sections and formatting.</p>
                    </a>

                    <a href="#" class="action-card">
                        <h4>Analyze Against Job Description</h4>
                        <p>Paste a job description and compare it with your CV to identify missing keywords.</p>
                    </a>

                    <a href="#" class="action-card">
                        <h4>View ATS Results</h4>
                        <p>Check your score, matched terms, missing skills, and suggested improvements.</p>
                    </a>
                </div>
            </div>

            <div class="panel">
                <h3>Progress Overview</h3>
                <p class="panel-subtitle">Track the main parts of your ATS optimization journey.</p>

                <div class="progress-list">
                    <div class="progress-item">
                        <div class="title">
                            <span>Account Setup</span>
                            <span>100%</span>
                        </div>
                        <div class="bar"><div class="fill" style="width: 100%;"></div></div>
                        <p>Your registration, login, and dashboard access are working.</p>
                    </div>

                    <div class="progress-item">
                        <div class="title">
                            <span>CV Builder</span>
                            <span>0%</span>
                        </div>
                        <div class="bar"><div class="fill" style="width: 0%;"></div></div>
                        <p>This will increase once we create the CV form and save feature.</p>
                    </div>

                    <div class="progress-item">
                        <div class="title">
                            <span>ATS Analysis</span>
                            <span>0%</span>
                        </div>
                        <div class="bar"><div class="fill" style="width: 0%;"></div></div>
                        <p>This will become active after we build the job description analysis module.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>
</div>
</body>
</html>