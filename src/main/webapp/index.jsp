<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ATSCV - Resume Optimizer</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            scroll-behavior: smooth;
        }

        body {
            background:
                    radial-gradient(circle at top left, rgba(59,130,246,0.18), transparent 25%),
                    radial-gradient(circle at bottom right, rgba(139,92,246,0.14), transparent 22%),
                    linear-gradient(135deg, #020817, #06122f 45%, #0f172a 100%);
            color: #ffffff;
            min-height: 100vh;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        .container {
            width: 100%;
            max-width: 1380px;
            margin: 0 auto;
            padding: 0 34px;
        }

        .navbar {
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(12px);
            background: rgba(2, 8, 23, 0.70);
            border-bottom: 1px solid rgba(148, 163, 184, 0.10);
        }

        .nav-inner {
            min-height: 86px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .brand-icon {
            width: 52px;
            height: 52px;
            border-radius: 16px;
            background: linear-gradient(135deg, #2563eb, #8b5cf6);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            font-weight: 800;
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.25);
        }

        .brand-text h1 {
            font-size: 22px;
            line-height: 1;
            margin-bottom: 5px;
        }

        .brand-text p {
            color: #94a3b8;
            font-size: 14px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 30px;
            font-size: 17px;
            color: #dbeafe;
        }

        .nav-links a {
            transition: color 0.2s ease;
        }

        .nav-links a:hover {
            color: #60a5fa;
        }

        .hero {
            padding: 48px 0 90px;
        }

        .hero-grid {
            display: grid;
            grid-template-columns: 1.15fr 0.85fr;
            gap: 50px;
            align-items: center;
        }

        .badge {
            display: inline-block;
            background: rgba(30, 41, 59, 0.80);
            border: 1px solid rgba(148, 163, 184, 0.12);
            color: #dbeafe;
            padding: 12px 18px;
            border-radius: 999px;
            font-size: 15px;
            margin-bottom: 26px;
        }

        .hero-content h2 {
            font-size: 72px;
            line-height: 1.02;
            max-width: 760px;
            margin-bottom: 26px;
            letter-spacing: -2px;
        }

        .hero-content p {
            color: #cbd5e1;
            font-size: 20px;
            line-height: 1.8;
            max-width: 860px;
            margin-bottom: 34px;
        }

        .hero-buttons {
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
        }

        .primary-btn,
        .secondary-btn {
            padding: 18px 34px;
            border-radius: 18px;
            font-size: 16px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.25s ease;
        }

        .primary-btn {
            background: linear-gradient(135deg, #2563eb, #7c3aed);
            color: white;
            box-shadow: 0 18px 36px rgba(59, 130, 246, 0.24);
        }

        .primary-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 24px 40px rgba(59, 130, 246, 0.30);
        }

        .secondary-btn {
            background: rgba(15, 23, 42, 0.60);
            border: 1px solid rgba(148, 163, 184, 0.16);
            color: #f8fafc;
        }

        .secondary-btn:hover {
            border-color: rgba(96, 165, 250, 0.30);
            color: #dbeafe;
        }

        .hero-card {
            background: linear-gradient(180deg, rgba(30,41,59,0.95), rgba(30,41,59,0.82));
            border: 1px solid rgba(148, 163, 184, 0.10);
            border-radius: 30px;
            padding: 34px 30px;
            box-shadow: 0 24px 50px rgba(0, 0, 0, 0.30);
            max-width: 430px;
            margin-left: auto;
        }

        .hero-card .small-title {
            color: #cbd5e1;
            font-size: 16px;
            margin-bottom: 14px;
        }

        .hero-card .big-score {
            font-size: 74px;
            font-weight: 800;
            line-height: 1;
            margin-bottom: 18px;
        }

        .pill {
            display: inline-block;
            padding: 10px 18px;
            border-radius: 999px;
            background: rgba(34, 197, 94, 0.18);
            color: #86efac;
            font-weight: 700;
            font-size: 15px;
            margin-bottom: 26px;
        }

        .metric {
            margin-bottom: 18px;
        }

        .metric-label {
            display: flex;
            justify-content: space-between;
            font-size: 15px;
            color: #dbeafe;
            margin-bottom: 8px;
        }

        .metric-bar {
            width: 100%;
            height: 13px;
            border-radius: 999px;
            background: rgba(71, 85, 105, 0.45);
            overflow: hidden;
        }

        .metric-fill {
            height: 100%;
            border-radius: 999px;
            background: linear-gradient(135deg, #3b82f6, #8b5cf6);
        }

        .section {
            padding: 44px 0 90px;
        }

        .section-header {
            text-align: center;
            max-width: 980px;
            margin: 0 auto 48px;
        }

        .section-tag {
            display: inline-block;
            background: rgba(30, 41, 59, 0.80);
            border: 1px solid rgba(148, 163, 184, 0.12);
            color: #dbeafe;
            padding: 10px 18px;
            border-radius: 999px;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .section-header h3 {
            font-size: 62px;
            line-height: 1.1;
            margin-bottom: 18px;
            letter-spacing: -1.5px;
        }

        .section-header p {
            color: #cbd5e1;
            font-size: 19px;
            line-height: 1.8;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 70px;
        }

        .feature-card {
            background: linear-gradient(180deg, rgba(30,41,59,0.92), rgba(30,41,59,0.74));
            border: 1px solid rgba(148, 163, 184, 0.10);
            border-radius: 28px;
            padding: 34px 26px;
            min-height: 240px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.18);
            transition: transform 0.25s ease, border-color 0.25s ease;
        }

        .feature-card:hover {
            transform: translateY(-4px);
            border-color: rgba(96, 165, 250, 0.26);
        }

        .feature-icon {
            font-size: 34px;
            margin-bottom: 18px;
        }

        .feature-card h4 {
            font-size: 24px;
            margin-bottom: 14px;
            line-height: 1.3;
        }

        .feature-card p {
            color: #cbd5e1;
            font-size: 16px;
            line-height: 1.8;
        }

        .cta-box {
            max-width: 980px;
            margin: 0 auto;
            background: linear-gradient(135deg, rgba(37,99,235,0.30), rgba(124,58,237,0.32));
            border: 1px solid rgba(148, 163, 184, 0.12);
            border-radius: 34px;
            padding: 52px 34px;
            text-align: center;
            box-shadow: 0 26px 52px rgba(0, 0, 0, 0.22);
        }

        .cta-box h3 {
            font-size: 56px;
            line-height: 1.15;
            margin-bottom: 18px;
        }

        .cta-box p {
            color: #dbeafe;
            font-size: 20px;
            line-height: 1.8;
            max-width: 760px;
            margin: 0 auto 28px;
        }

        .footer-space {
            height: 40px;
        }

        @media (max-width: 1200px) {
            .hero-content h2 {
                font-size: 58px;
            }

            .section-header h3,
            .cta-box h3 {
                font-size: 46px;
            }

            .features-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 980px) {
            .hero-grid {
                grid-template-columns: 1fr;
            }

            .hero-card {
                margin-left: 0;
                max-width: 100%;
            }

            .nav-links {
                gap: 18px;
                font-size: 15px;
            }

            .hero-content h2 {
                font-size: 50px;
            }

            .section-header h3,
            .cta-box h3 {
                font-size: 40px;
            }
        }

        @media (max-width: 700px) {
            .container {
                padding: 0 18px;
            }

            .nav-inner {
                flex-direction: column;
                align-items: flex-start;
                padding: 18px 0;
            }

            .nav-links {
                flex-wrap: wrap;
                gap: 14px;
            }

            .hero-content h2 {
                font-size: 40px;
                letter-spacing: -1px;
            }

            .hero-content p,
            .section-header p,
            .cta-box p {
                font-size: 17px;
            }

            .section-header h3,
            .cta-box h3 {
                font-size: 34px;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }

            .primary-btn,
            .secondary-btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<header class="navbar">
    <div class="container nav-inner">
        <div class="brand">
            <div class="brand-icon">A</div>
            <div class="brand-text">
                <h1>ATSCV</h1>
                <p>Resume Optimizer</p>
            </div>
        </div>

        <nav class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="#features">Features</a>
            <a href="#about">About</a>
            <a href="login.jsp">Dashboard</a>
        </nav>
    </div>
</header>

<section class="hero">
    <div class="container hero-grid">
        <div class="hero-content">
            <div class="badge">Smart ATS Resume Platform</div>
            <h2>Build a Resume That Passes ATS Screening</h2>
            <p>
                Create, improve, and optimize your CV with a modern ATS-friendly system.
                Track your score, strengthen your resume, and increase your chances of
                getting shortlisted for interviews.
            </p>

            <div class="hero-buttons">
                <a href="register.jsp" class="primary-btn">Join Us</a>
                <a href="#features" class="secondary-btn">Learn More</a>
            </div>
        </div>

        <div class="hero-card">
            <div class="small-title">Resume Performance</div>
            <div class="big-score">85%</div>
            <div class="pill">Top Tier CV</div>

            <div class="metric">
                <div class="metric-label">
                    <span>Keyword Match</span>
                    <span>90%</span>
                </div>
                <div class="metric-bar">
                    <div class="metric-fill" style="width: 90%;"></div>
                </div>
            </div>

            <div class="metric">
                <div class="metric-label">
                    <span>Formatting</span>
                    <span>84%</span>
                </div>
                <div class="metric-bar">
                    <div class="metric-fill" style="width: 84%;"></div>
                </div>
            </div>

            <div class="metric">
                <div class="metric-label">
                    <span>Section Completion</span>
                    <span>92%</span>
                </div>
                <div class="metric-bar">
                    <div class="metric-fill" style="width: 92%;"></div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section" id="features">
    <div class="container">
        <div class="section-header">
            <div class="section-tag">Main Features</div>
            <h3>Everything You Need to Improve Your CV</h3>
            <p>
                A clean and modern system built to help students and jobseekers create stronger,
                recruiter-ready resumes.
            </p>
        </div>

        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">📄</div>
                <h4>CV Builder</h4>
                <p>Create a professional resume using structured sections and clean formatting.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">📊</div>
                <h4>ATS Score Analysis</h4>
                <p>Analyze your CV and see how well it performs against ATS screening standards.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">🎯</div>
                <h4>Keyword Optimization</h4>
                <p>Improve your keyword density and match your resume to target job roles.</p>
            </div>

            <div class="feature-card">
                <div class="feature-icon">🚀</div>
                <h4>Career Readiness</h4>
                <p>Get actionable suggestions that make your CV stronger and more competitive.</p>
            </div>
        </div>

        <div class="cta-box" id="about">
            <h3>Start Building a Stronger Resume Today</h3>
            <p>
                Take the next step toward better job opportunities with a smarter ATS-friendly CV.
            </p>
            <a href="register.jsp" class="primary-btn">Join Us</a>
        </div>
    </div>
</section>

<div class="footer-space"></div>

</body>
</html>