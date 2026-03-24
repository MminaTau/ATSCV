<%
    String registered = request.getParameter("registered");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - ATS CV Builder</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            background:
                    radial-gradient(circle at top left, rgba(59,130,246,0.22), transparent 30%),
                    radial-gradient(circle at bottom right, rgba(96,165,250,0.18), transparent 28%),
                    linear-gradient(135deg, #0f172a, #111827 45%, #1e293b 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
            color: #ffffff;
        }

        .page-wrapper {
            width: 100%;
            max-width: 1200px;
            display: grid;
            grid-template-columns: 1.1fr 0.9fr;
            background: rgba(15, 23, 42, 0.78);
            border: 1px solid rgba(148, 163, 184, 0.15);
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.45);
            backdrop-filter: blur(12px);
        }

        .left-panel {
            padding: 70px 60px;
            background: linear-gradient(160deg, rgba(30,41,59,0.95), rgba(15,23,42,0.92));
        }

        .logo-badge {
            display: inline-block;
            padding: 8px 14px;
            border-radius: 999px;
            background: rgba(59, 130, 246, 0.15);
            border: 1px solid rgba(96, 165, 250, 0.28);
            color: #93c5fd;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
            margin-bottom: 24px;
        }

        .left-panel h1 {
            font-size: 42px;
            line-height: 1.15;
            margin-bottom: 18px;
        }

        .left-panel p.description {
            color: #cbd5e1;
            font-size: 16px;
            line-height: 1.7;
            max-width: 520px;
            margin-bottom: 36px;
        }

        .feature-list {
            display: grid;
            gap: 16px;
        }

        .feature-item {
            background: rgba(30, 41, 59, 0.72);
            border: 1px solid rgba(148, 163, 184, 0.12);
            border-radius: 18px;
            padding: 18px 20px;
        }

        .feature-item h3 {
            font-size: 16px;
            margin-bottom: 8px;
            color: #f8fafc;
        }

        .feature-item p {
            color: #94a3b8;
            font-size: 14px;
            line-height: 1.6;
        }

        .right-panel {
            padding: 55px 42px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(15, 23, 42, 0.92);
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            background: rgba(15, 23, 42, 0.94);
            border: 1px solid rgba(148, 163, 184, 0.12);
            border-radius: 24px;
            padding: 36px 30px;
            box-shadow: 0 14px 35px rgba(0, 0, 0, 0.25);
        }

        .login-card h2 {
            font-size: 28px;
            margin-bottom: 8px;
            text-align: center;
        }

        .login-card .subtitle {
            text-align: center;
            color: #94a3b8;
            font-size: 14px;
            margin-bottom: 28px;
            line-height: 1.6;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            color: #e2e8f0;
            font-weight: 600;
        }

        .form-group input {
            width: 100%;
            padding: 14px 15px;
            border-radius: 14px;
            border: 1px solid #334155;
            background: #0f172a;
            color: white;
            font-size: 14px;
            outline: none;
            transition: all 0.25s ease;
        }

        .form-group input:focus {
            border-color: #3b82f6;
            box-shadow: 0 0 0 4px rgba(59,130,246,0.14);
        }

        .login-btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 14px;
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: white;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 8px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            box-shadow: 0 10px 20px rgba(37, 99, 235, 0.28);
        }

        .login-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 14px 24px rgba(37, 99, 235, 0.34);
        }

        .success-message {
            background: rgba(34, 197, 94, 0.12);
            border: 1px solid rgba(34, 197, 94, 0.35);
            color: #86efac;
            padding: 12px 14px;
            border-radius: 12px;
            text-align: center;
            font-size: 14px;
            margin-bottom: 16px;
        }

        .error-message {
            min-height: 22px;
            color: #fca5a5;
            font-size: 14px;
            text-align: center;
            margin-top: 14px;
        }

        .register-link {
            text-align: center;
            margin-top: 18px;
            color: #cbd5e1;
            font-size: 14px;
        }

        .register-link a {
            color: #60a5fa;
            text-decoration: none;
            font-weight: 700;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 950px) {
            .page-wrapper {
                grid-template-columns: 1fr;
            }

            .left-panel {
                padding: 45px 30px 30px;
            }

            .left-panel h1 {
                font-size: 34px;
            }

            .right-panel {
                padding: 20px 20px 35px;
            }
        }

        @media (max-width: 600px) {
            body {
                padding: 16px;
            }

            .left-panel,
            .right-panel {
                padding-left: 20px;
                padding-right: 20px;
            }

            .login-card {
                padding: 28px 20px;
            }

            .left-panel h1 {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <div class="left-panel">
        <div class="logo-badge">ATS CV BUILDER</div>
        <h1>Build smarter CVs. Pass ATS systems with confidence.</h1>
        <p class="description">
            Create professional, ATS-friendly resumes, analyze job descriptions,
            identify missing keywords, and improve your chances of getting shortlisted.
        </p>

        <div class="feature-list">
            <div class="feature-item">
                <h3>ATS-Friendly CV Building</h3>
                <p>Create clean, structured CVs designed to work well with modern applicant tracking systems.</p>
            </div>

            <div class="feature-item">
                <h3>Keyword Analysis</h3>
                <p>Compare your CV against job descriptions and discover which important keywords are missing.</p>
            </div>

            <div class="feature-item">
                <h3>Career-Ready Dashboard</h3>
                <p>Manage your CVs, track analysis results, and improve your job application strategy in one place.</p>
            </div>
        </div>
    </div>

    <div class="right-panel">
        <div class="login-card">
            <h2>Welcome Back</h2>
            <p class="subtitle">Log in to continue building and optimizing your CV</p>

            <% if ("success".equals(registered)) { %>
            <div class="success-message">
                Account created successfully. Please log in.
            </div>
            <% } %>

            <form action="login" method="post">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email address" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required>
                </div>

                <button type="submit" class="login-btn">Login</button>
            </form>

            <p class="error-message">${errorMessage}</p>

            <div class="register-link">
                Dont have an account?
                <a href="register.jsp">Create one here</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>