<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>ATS CV Builder</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(90deg, #081224, #0b1730, #0d1a35);
            color: #ffffff;
            min-height: 100vh;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        .layout {
            display: grid;
            grid-template-columns: 250px 230px 1fr 330px;
            min-height: 100vh;
        }

        .sidebar {
            background: #0d1730;
            border-right: 1px solid rgba(255,255,255,0.05);
            padding: 28px 16px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .logo h1 {
            font-size: 34px;
            font-weight: 800;
            letter-spacing: 1px;
        }

        .logo p {
            margin-top: 4px;
            font-size: 12px;
            color: #94a3b8;
            letter-spacing: 1px;
        }

        .menu {
            margin-top: 45px;
        }

        .menu a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 16px;
            border-radius: 14px;
            margin-bottom: 10px;
            color: #cbd5e1;
            font-size: 14px;
            transition: 0.2s ease;
        }

        .menu a:hover {
            background: rgba(37,99,235,0.12);
        }

        .menu a.active {
            background: rgba(37,99,235,0.25);
            border: 1px solid rgba(59,130,246,0.5);
            color: #ffffff;
        }

        .profile-box {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px;
        }

        .avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            background: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }

        .profile-text .name {
            font-size: 15px;
            font-weight: 600;
        }

        .profile-text .plan {
            font-size: 12px;
            color: #94a3b8;
        }

        .sections-panel {
            background: rgba(2,6,23,0.25);
            border-right: 1px solid rgba(255,255,255,0.05);
            padding: 26px 18px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .sections-title {
            font-size: 13px;
            color: #94a3b8;
            margin-bottom: 18px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .section-link {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 10px;
            border-radius: 12px;
            margin-bottom: 8px;
            color: #dbeafe;
            font-size: 15px;
        }

        .section-link.active {
            background: rgba(59,130,246,0.12);
            color: #ffffff;
            font-weight: 600;
        }

        .dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: #22c55e;
        }

        .dot.current {
            background: #60a5fa;
        }

        .score-box {
            background: rgba(255,255,255,0.06);
            border-radius: 16px;
            padding: 18px;
        }

        .score-box h4 {
            font-size: 13px;
            color: #cbd5e1;
            margin-bottom: 12px;
            letter-spacing: 1px;
        }

        .bar {
            height: 8px;
            background: rgba(255,255,255,0.08);
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 10px;
        }

        .bar-fill {
            width: 72%;
            height: 100%;
            background: linear-gradient(90deg, #2563eb, #60a5fa);
        }

        .main {
            padding: 28px;
            overflow-y: auto;
        }

        .topbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 22px;
        }

        .topbar h2 {
            font-size: 20px;
            font-weight: 700;
        }

        .subtitle {
            color: #94a3b8;
            font-size: 14px;
            margin-top: 6px;
        }

        .builder-form {
            display: flex;
            flex-direction: column;
            gap: 22px;
        }

        .card {
            background: rgba(255,255,255,0.06);
            border-radius: 22px;
            padding: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.18);
        }

        .card h3 {
            font-size: 26px;
            margin-bottom: 8px;
        }

        .card p.card-sub {
            color: #94a3b8;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .grid-3 {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 16px;
        }

        .field {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 14px;
        }

        .field label {
            font-size: 12px;
            font-weight: 700;
            color: #a5b4fc;
            letter-spacing: 0.8px;
            text-transform: uppercase;
        }

        .field input,
        .field textarea,
        .field select {
            width: 100%;
            background: #16233f;
            border: 1px solid rgba(255,255,255,0.05);
            color: #ffffff;
            border-radius: 14px;
            padding: 14px 14px;
            font-size: 14px;
            outline: none;
        }

        .field textarea {
            min-height: 110px;
            resize: vertical;
        }

        .small-card {
            background: rgba(255,255,255,0.04);
            border-radius: 18px;
            padding: 18px;
            margin-top: 12px;
        }

        .small-card h4 {
            margin-bottom: 14px;
            font-size: 16px;
        }

        .inline-actions {
            display: flex;
            gap: 12px;
            margin-top: 14px;
            flex-wrap: wrap;
        }

        .btn {
            border: none;
            border-radius: 14px;
            padding: 14px 22px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(90deg, #2563eb, #3b82f6);
            color: white;
        }

        .btn-secondary {
            background: rgba(255,255,255,0.08);
            color: white;
        }

        .btn-danger {
            background: rgba(239,68,68,0.12);
            color: #fca5a5;
        }

        .bottom-actions {
            display: flex;
            justify-content: space-between;
            gap: 14px;
            margin-top: 8px;
        }

        .preview-panel {
            background: rgba(2,6,23,0.25);
            border-left: 1px solid rgba(255,255,255,0.05);
            padding: 28px 20px;
        }

        .preview-title {
            color: #94a3b8;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 18px;
        }

        .resume-preview {
            background: #ffffff;
            color: #111827;
            border-radius: 8px;
            padding: 24px;
            min-height: 630px;
        }

        .resume-preview h1 {
            font-size: 22px;
            margin-bottom: 6px;
        }

        .resume-preview .muted {
            color: #6b7280;
            font-size: 13px;
            margin-bottom: 18px;
        }

        .preview-section {
            margin-top: 18px;
        }

        .preview-section h4 {
            font-size: 12px;
            text-transform: uppercase;
            margin-bottom: 8px;
            padding-bottom: 6px;
            border-bottom: 1px solid #e5e7eb;
            color: #374151;
        }

        .preview-section p,
        .preview-section li {
            font-size: 12px;
            line-height: 1.5;
            color: #374151;
        }

        .preview-section ul {
            padding-left: 16px;
        }

        @media (max-width: 1200px) {
            .layout {
                grid-template-columns: 220px 200px 1fr;
            }

            .preview-panel {
                display: none;
            }
        }

        @media (max-width: 900px) {
            .layout {
                grid-template-columns: 1fr;
            }

            .sidebar,
            .sections-panel {
                display: none;
            }

            .grid-2,
            .grid-3 {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<%
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<% if (successMessage != null) { %>
<div style="margin:15px; padding:12px; background:#14532d; color:white; border-radius:8px;">
    <%= successMessage %>
</div>
<% } %>

<% if (errorMessage != null) { %>
<div style="margin:15px; padding:12px; background:#7f1d1d; color:white; border-radius:8px;">
    <%= errorMessage %>
</div>
<% } %>
<body>

<div class="layout">

    <div class="sidebar">
        <div>
            <div class="logo">
                <h1>ATSCV</h1>
                <p>PRECISION INTAKE</p>
            </div>

            <div class="menu">
                <a href="dashboard.jsp">⬛ Dashboard</a>
                <a href="cv-builder" class="active">📄 CV Builder</a>
                <a href="atsanalysis">📊 ATS Analysis</a>
                <a href="results">✅ Results</a>
                <a href="profile">👤 Profile</a>
            </div>
        </div>

        <div class="profile-box">
            <div class="avatar">JD</div>
            <div class="profile-text">
                <div class="name">Jane Doe</div>
                <div class="plan">Professional Plan</div>
            </div>
        </div>
    </div>

    <div class="sections-panel">
        <div>
            <div class="sections-title">CV Sections</div>

            <div class="section-link"><span>Personal Info</span><span class="dot"></span></div>
            <div class="section-link"><span>Summary</span><span class="dot"></span></div>
            <div class="section-link"><span>Education</span><span class="dot"></span></div>
            <div class="section-link active"><span>Experience</span><span class="dot current"></span></div>
            <div class="section-link"><span>Skills</span><span class="dot"></span></div>
            <div class="section-link"><span>Projects</span><span class="dot"></span></div>
            <div class="section-link"><span>Certifications</span><span class="dot"></span></div>
        </div>

        <div class="score-box">
            <h4>ATS SCORE STRENGTH</h4>
            <div class="bar">
                <div class="bar-fill"></div>
            </div>
            <div>72% Optimized</div>
        </div>
    </div>

    <div class="main">
        <div class="topbar">
            <div>
                <h2>CV Builder • Standard Software Engineer Resume</h2>
                <div class="subtitle">Build every section of the resume in one premium dashboard page.</div>
            </div>
        </div>

        <form action="buildCV" method="post" class="builder-form">

            <div class="card">
                <h3>Personal Information</h3>
                <p class="card-sub">Add the main resume details that identify the candidate and target role.</p>

                <div class="grid-2">
                    <div class="field">
                        <label>Resume Title</label>
                        <input type="text" name="resumeTitle" placeholder="Standard Software Engineer Resume">
                    </div>
                    <div class="field">
                        <label>Target Job Title</label>
                        <input type="text" name="targetJobTitle" placeholder="Software Engineer">
                    </div>
                </div>

                <div class="grid-2">
                    <div class="field">
                        <label>First Name</label>
                        <input type="text" name="firstName" placeholder="Jane">
                    </div>
                    <div class="field">
                        <label>Last Name</label>
                        <input type="text" name="lastName" placeholder="Doe">
                    </div>
                </div>

                <div class="grid-2">
                    <div class="field">
                        <label>Phone</label>
                        <input type="text" name="phone" placeholder="+27 71 234 5678">
                    </div>
                    <div class="field">
                        <label>Address</label>
                        <input type="text" name="address" placeholder="Nelspruit, Mpumalanga">
                    </div>
                </div>

                <div class="grid-3">
                    <div class="field">
                        <label>LinkedIn URL</label>
                        <input type="text" name="linkedinUrl" placeholder="https://linkedin.com/in/...">
                    </div>
                    <div class="field">
                        <label>GitHub URL</label>
                        <input type="text" name="githubUrl" placeholder="https://github.com/...">
                    </div>
                    <div class="field">
                        <label>Portfolio URL</label>
                        <input type="text" name="portfolioUrl" placeholder="https://portfolio.com">
                    </div>
                </div>
            </div>

            <div class="card">
                <h3>Professional Summary</h3>
                <p class="card-sub">Write a strong ATS-friendly summary aligned with the target job.</p>

                <div class="field">
                    <label>Summary</label>
                    <textarea name="professionalSummary" placeholder="Results-driven software engineer with experience in Java, web applications, databases, and scalable systems..."></textarea>
                </div>
            </div>

            <div class="card">
                <h3>Education</h3>
                <p class="card-sub">Add academic background and qualifications.</p>

                <div class="small-card">
                    <h4>Education Entry</h4>

                    <div class="grid-2">
                        <div class="field">
                            <label>Institution Name</label>
                            <input type="text" name="institutionName" placeholder="University of Mpumalanga">
                        </div>
                        <div class="field">
                            <label>Qualification</label>
                            <input type="text" name="qualification" placeholder="BICT">
                        </div>
                    </div>

                    <div class="grid-2">
                        <div class="field">
                            <label>Field of Study</label>
                            <input type="text" name="fieldOfStudy" placeholder="Computer Science">
                        </div>
                        <div class="field">
                            <label>Grade</label>
                            <input type="text" name="grade" placeholder="Final Year">
                        </div>
                    </div>

                    <div class="grid-2">
                        <div class="field">
                            <label>Start Date</label>
                            <input type="date" name="educationStartDate">
                        </div>
                        <div class="field">
                            <label>End Date</label>
                            <input type="date" name="educationEndDate">
                        </div>
                    </div>

                    <div class="field">
                        <label>Description</label>
                        <textarea name="educationDescription" placeholder="Relevant coursework, achievements, leadership, projects..."></textarea>
                    </div>
                </div>
            </div>

            <div class="card">
                <h3>Professional Experience</h3>
                <p class="card-sub">List relevant work history, impact, and measurable achievements.</p>

                <div class="small-card">
                    <h4>Experience Entry</h4>

                    <div class="grid-2">
                        <div class="field">
                            <label>Job Title</label>
                            <input type="text" name="jobTitle" placeholder="Junior Software Developer">
                        </div>
                        <div class="field">
                            <label>Company Name</label>
                            <input type="text" name="companyName" placeholder="TechNova Solutions">
                        </div>
                    </div>

                    <div class="grid-2">
                        <div class="field">
                            <label>Location</label>
                            <input type="text" name="jobLocation" placeholder="Johannesburg">
                        </div>
                        <div class="field">
                            <label>Currently Working</label>
                            <select name="currentlyWorking">
                                <option value="false">No</option>
                                <option value="true">Yes</option>
                            </select>
                        </div>
                    </div>

                    <div class="grid-2">
                        <div class="field">
                            <label>Start Date</label>
                            <input type="date" name="experienceStartDate">
                        </div>
                        <div class="field">
                            <label>End Date</label>
                            <input type="date" name="experienceEndDate">
                        </div>
                    </div>

                    <div class="field">
                        <label>Responsibilities</label>
                        <textarea name="responsibilities" placeholder="Developed web applications, collaborated with teams, maintained systems..."></textarea>
                    </div>

                    <div class="field">
                        <label>Achievements</label>
                        <textarea name="achievements" placeholder="Reduced response time by 35%, built internal tools, improved reliability..."></textarea>
                    </div>

                    <div class="inline-actions">
                        <button type="button" class="btn btn-secondary">+ Add Another Position</button>
                        <button type="button" class="btn btn-secondary">✨ Auto-Optimize with AI</button>
                    </div>
                </div>
            </div>

            <div class="card">
                <h3>Skills</h3>
                <p class="card-sub">Add technical and soft skills in a structured ATS-friendly format.</p>

                <div class="small-card">
                    <h4>Skill Entry</h4>

                    <div class="grid-3">
                        <div class="field">
                            <label>Skill Name</label>
                            <input type="text" name="skillName" placeholder="Java">
                        </div>
                        <div class="field">
                            <label>Skill Category</label>
                            <input type="text" name="skillCategory" placeholder="Programming Language">
                        </div>
                        <div class="field">
                            <label>Proficiency Level</label>
                            <select name="proficiencyLevel">
                                <option>Beginner</option>
                                <option>Intermediate</option>
                                <option>Advanced</option>
                                <option>Expert</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <h3>Projects</h3>
                <p class="card-sub">Show projects that demonstrate problem-solving, tools, and outcomes.</p>

                <div class="small-card">
                    <h4>Project Entry</h4>

                    <div class="grid-2">
                        <div class="field">
                            <label>Project Title</label>
                            <input type="text" name="projectTitle" placeholder="ATS CV Builder">
                        </div>
                        <div class="field">
                            <label>Project Link</label>
                            <input type="text" name="projectLink" placeholder="https://github.com/...">
                        </div>
                    </div>

                    <div class="field">
                        <label>Technologies Used</label>
                        <input type="text" name="technologiesUsed" placeholder="Java, JSP, Servlets, MySQL, GlassFish">
                    </div>

                    <div class="field">
                        <label>Description</label>
                        <textarea name="projectDescription" placeholder="Designed and developed a web-based ATS CV Builder that helps users create optimized resumes..."></textarea>
                    </div>
                </div>
            </div>

            <div class="card">
                <h3>Certifications</h3>
                <p class="card-sub">Include short courses, certificates, and industry credentials.</p>

                <div class="small-card">
                    <h4>Certification Entry</h4>

                    <div class="grid-2">
                        <div class="field">
                            <label>Certificate Name</label>
                            <input type="text" name="certificateName" placeholder="AWS Cloud Practitioner">
                        </div>
                        <div class="field">
                            <label>Issuing Organization</label>
                            <input type="text" name="issuingOrganization" placeholder="Amazon Web Services">
                        </div>
                    </div>

                    <div class="grid-2">
                        <div class="field">
                            <label>Issue Date</label>
                            <input type="date" name="issueDate">
                        </div>
                        <div class="field">
                            <label>Expiry Date</label>
                            <input type="date" name="expiryDate">
                        </div>
                    </div>

                    <div class="grid-2">
                        <div class="field">
                            <label>Credential ID</label>
                            <input type="text" name="credentialId" placeholder="ABC12345">
                        </div>
                        <div class="field">
                            <label>Credential URL</label>
                            <input type="text" name="credentialUrl" placeholder="https://credential-link.com">
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <h3>Job Description for ATS Matching</h3>
                <p class="card-sub">Paste the target job description so the system can later compare keywords and calculate ATS fit.</p>

                <div class="field">
                    <label>Job Description</label>
                    <textarea name="jobDescription" placeholder="Paste the full job description here..."></textarea>
                </div>
            </div>

            <div class="bottom-actions">
                <button type="button" class="btn btn-secondary">← Back</button>
                <div style="display:flex; gap:12px;">
                    <button type="submit" class="btn btn-primary">Save CV</button>
                    <button type="button" class="btn btn-primary">Continue →</button>
                </div>
            </div>

        </form>
    </div>

    <div class="preview-panel">
        <div class="preview-title">Live Preview</div>

        <div class="resume-preview">
            <h1>JANE DOE</h1>
            <div class="muted">Nelspruit, Mpumalanga • +27 71 234 5678 • jane.doe@email.com</div>

            <div class="preview-section">
                <h4>Professional Summary</h4>
                <p>Results-driven software engineer with experience in Java, backend development, databases, and building student-focused digital systems.</p>
            </div>

            <div class="preview-section">
                <h4>Education</h4>
                <p><strong>University of Mpumalanga</strong></p>
                <p>BICT in Computer Science</p>
            </div>

            <div class="preview-section">
                <h4>Experience</h4>
                <p><strong>TechNova Solutions</strong> — Junior Software Developer</p>
                <ul>
                    <li>Built and maintained Java-based web applications.</li>
                    <li>Improved performance and usability of internal systems.</li>
                </ul>
            </div>

            <div class="preview-section">
                <h4>Skills</h4>
                <p>Java, JSP, Servlets, MySQL, HTML, CSS, Git, Problem-Solving</p>
            </div>

            <div class="preview-section">
                <h4>Projects</h4>
                <p><strong>ATS CV Builder</strong> — Web application for building ATS-optimized resumes.</p>
            </div>

            <div class="preview-section">
                <h4>Certifications</h4>
                <p>AWS Cloud Practitioner</p>
            </div>
        </div>
    </div>

</div>

</body>
</html>