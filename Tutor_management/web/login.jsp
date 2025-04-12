<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Lobster&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: url('https://cache.careers360.mobi/media/presets/720X480/colleges/social-media/media-gallery/3666/2019/3/20/Campus%20View%20of%20National%20Engineering%20College%20Kovilpatti_Campus-View.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #343a40;
            backdrop-filter: blur(5px);
        }
        .container {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 20px;
            box-shadow: 0 4px 40px rgba(0, 0, 0, 0.2);
            padding: 40px;
            width: 350px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            animation: fadeIn 0.5s;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .container:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 60px rgba(0, 0, 0, 0.3);
        }
        h1 {
            text-align: center;
            font-size: 48px;
            margin-bottom: 30px;
            font-family: 'Lobster', cursive;
            color: #007bff;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #495057;
            font-size: 24px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 2px solid #ced4da;
            border-radius: 10px;
            box-sizing: border-box;
            transition: border 0.3s, box-shadow 0.3s;
        }
        input[type="text"]:focus,
        input[type="password"]:focus,
        select:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }
        #mentorNameContainer {
            display: none;
        }
        .btn {
            background: linear-gradient(45deg, #007bff, #0056b3);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 10px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            transition: background 0.3s, transform 0.3s;
            box-shadow: 0 4px 20px rgba(0, 123, 255, 0.3);
        }
        .btn:hover {
            background: linear-gradient(45deg, #0056b3, #007bff);
            transform: translateY(-2px);
        }
        .error {
            color: red;
            text-align: center;
        }
        .signup {
            margin-top: 20px;
            text-align: center;
            color: #495057;
        }
        .signup a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }
        .signup a:hover {
            text-decoration: underline;
        }
    </style>
    <script>
        function toggleMentorName() {
            const role = document.getElementById('roleSelect').value;
            const mentorNameContainer = document.getElementById('mentorNameContainer');
            mentorNameContainer.style.display = role === 'student' ? 'block' : 'none';
        }

        function submitLoginForm() {
            const role = document.getElementById('roleSelect').value;
            const mentor = document.getElementById('mentor').value;

            if (!role) {
                alert("Please select a role.");
                return false;
            }
            if (role === 'student' && mentor.trim() === "") {
                alert("Please enter the mentor's name.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>

<h1 style="background: linear-gradient(to right, #007bff, #28a745); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
    Tutor Management System
</h1>

<div class="container">
    <h2>Login</h2>
    <form name="loginForm" method="post" onsubmit="return submitLoginForm()">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" required>
        
        <select id="roleSelect" name="role" onchange="toggleMentorName()" required>
            <option value="">Select Role</option>
            <option value="student">Student</option>
            <option value="mentor">Mentor</option>
        </select>

        <div id="mentorNameContainer">
            <input type="text" id="mentor" name="mentor" placeholder="Mentor Name">
        </div>

        <button type="submit" class="btn">Login</button>
    </form>

    <% 
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");
            String mentor = request.getParameter("mentor");

            try {
                Connection conn = DBConnection.getConnection();
                String sql = "SELECT * FROM users WHERE username=? AND password=? AND role=?";
                if ("student".equalsIgnoreCase(role)) {
                    sql += " AND mentor_name=?";
                }

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, role);
                if ("student".equalsIgnoreCase(role)) {
                    ps.setString(4, mentor);
                }

                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);
                    
                    if ("mentor".equalsIgnoreCase(role)) {
                        String mentorName = rs.getString("mentor_name");
                        session.setAttribute("mentorName", mentorName);
                        response.sendRedirect("mentor.jsp");
                    } else if ("student".equalsIgnoreCase(role)) {
                        response.sendRedirect("Student.jsp");
                    }
                } else {
                    out.println("<p class='error'>Invalid login credentials or mentor name mismatch!</p>");
                }
                conn.close();
            } catch (Exception e) {
                out.println("<p class='error'>An error occurred: " + e.getMessage() + "</p>");
            }
        }
    %>

    <div class="signup">
        <p>Don't have an account? <a href="signup.jsp">Sign up</a></p>
    </div>
</div>
</body>
</html>
