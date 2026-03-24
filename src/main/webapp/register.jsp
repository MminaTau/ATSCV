<!DOCTYPE html>
<html>
<head>
    <title>Register - ATS CV Builder</title>
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
                    radial-gradient(circle at top right, rgba(59,130,246,0.22), transparent 30%),
                    radial-gradient(circle at bottom left, rgba(96,165,250,0.18), transparent 28%),
                    linear-gradient(135deg, #0f172a, #111827 45%, #1e293b 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 30px;
            color: #ffffff;
        }

        .page-wrapper {
            width: 100%;
            max-width: 1220px;
            display: grid;
            grid-template-columns: 0.95fr 1.05fr;
            background: rgba(15, 23, 42, 0.8);
            border: 1px solid rgba(148, 163, 184, 0.15);
            border-radius: 28px;
            overflow: hidden;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.45);
            backdrop-filter: blur(12px);
        }

        .left-panel {
            padding: 60px 42px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(15, 23, 42, 0.92);
        }

        .register-card {
            width: 100%;
            max-width: 470px;
            background: rgba(15, 23, 42, 0.96);
            border: 1px solid rgba(148, 163, 184, 0.12);
            border-radius: 24px;
            padding: 34px 30px;
            box-shadow: 0 14px 35px rgba(0, 0, 0, 0.25);
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
            margin-bottom: 18px;
        }

        .register-card h2 {
            font-size: 30px;
            margin-bottom: 8px;
        }

        .register-card .subtitle {
            color: #94a3b8;
            font-size: 14px;
            line-height: 1.6;
            margin-bottom: 26px;
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

        .register-btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 14px;
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: white;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 6px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            box-shadow: 0 10px 20px rgba(37, 99, 235, 0.28);
        }

        .register-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 14px 24px rgba(37, 99, 235, 0.34);
        }

        .login-link {
            text-align: center;
            margin-top: 18px;
            color: #cbd5e1;
            font-size: 14px;
        }

        .login-link a {
            color: #60a5fa;
            text-decoration: none;
            font-weight: 700;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .message {
            min-height: 22px;
            text-align: center;
            font-size: 14px;
            margin-top: 14px;
            color: #f8fafc;
        }

        .right-panel {
            padding: 70px 60px;
            background: linear-gradient(160deg, rgba(30,41,59,0.95), rgba(15,23,42,0.92));
        }

        .right-panel h1 {
            font-size: 42px;
            line-height: 1.15;
            margin-bottom: 18px;
        }

        .right-panel p.description {
            color: #cbd5e1;
            font-size: 16px;
            line-height: 1.7;
            max-width: 540px;
            margin-bottom: 34px;
        }

        .benefits {
            display: grid;
            gap: 16px;
        }

        .benefit-card {
            background: rgba(30, 41, 59, 0.72);
            border: 1px solid rgba(148, 163, 184, 0.12);
            border-radius: 18px;
            padding: 18px 20px;
        }

        .benefit-card h3 {
            font-size: 16px;
            margin-bottom: 8px;
            color: #f8fafc;
        }

        .benefit-card p {
            color: #94a3b8;
            font-size: 14px;
            line-height: 1.6;
        }

        @media (max-width: 980px) {
            .page-wrapper {
                grid-template-columns: 1fr;
            }

            .left-panel {
                order: 2;
                padding: 25px 20px 35px;
            }

            .right-panel {
                order: 1;
                padding: 45px 30px 30px;
            }

            .right-panel h1 {
                font-size: 34px;
            }
        }

        @media (max-width: 600px) {
            body {
                padding: 16px;
            }

            .register-card {
                padding: 28px 20px;
            }

            .right-panel,
            .left-panel {
                padding-left: 20px;
                padding-right: 20px;
            }

            .right-panel h1 {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <div class="left-panel">
        <div class="register-card">
            <div class="brand">ATS CV BUILDER</div>
            <h2>Create Account</h2>
            <p class="subtitle">Start building professional ATS-friendly CVs and improve your job application success.</p>

            <form action="register" method="post">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email address" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Create a password" required>
                </div>

                <button type="submit" class="register-btn">Create Account</button>
            </form>

            <div class="message">${message}</div>

            <div class="login-link">
                Already have an account?
                <a href="login.jsp">Login here</a>
            </div>
        </div>
    </div>

    <div class="right-panel">
        <h1>Start your journey to smarter job applications.</h1>
        <p class="description">
            Join the ATS CV Builder platform to create optimized resumes, analyze job descriptions,
            and understand how well your profile matches what employers are searching for.
        </p>

        <div class="benefits">
            <div class="benefit-card">
                <h3>Professional CV Creation</h3>
                <p>Build a modern, structured CV with the right sections and formatting for ATS systems.</p>
            </div>

            <div class="benefit-card">
                <h3>Resume Match Insights</h3>
                <p>See how your CV compares against job descriptions and identify what needs improvement.</p>
            </div>

            <div class="benefit-card">
                <h3>Actionable Recommendations</h3>
                <p>Receive practical suggestions to improve keywords, clarity, and relevance for applications.</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>