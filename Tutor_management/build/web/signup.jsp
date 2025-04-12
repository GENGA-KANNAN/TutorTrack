<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sign Up Page</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: url('https://i.ytimg.com/vi/y05CLRrEtLo/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLB0B3uMaHuqQHzDpnBsrZb7FxCebQ') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #343a40;
            backdrop-filter: blur(5px);
        }

        .signup-container {
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

        .signup-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 60px rgba(0, 0, 0, 0.3);
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

        .form-group {
            margin-bottom: 15px;
        }

        input[type="submit"] {
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

        input[type="submit"]:hover {
            background: linear-gradient(45deg, #0056b3, #007bff);
            transform: translateY(-2px);
        }

        .success-message {
            color: green;
            text-align: center;
        }

        .error-message {
            color: red;
            text-align: center;
        }

        #mentor-group {
            display: none;
        }

        @media (max-width: 400px) {
            .signup-container {
                width: 100%;
                padding: 20px;
                box-sizing: border-box;
            }
        }
    </style>
    <script>
        function updateForm() {
            var roleSelect = document.getElementById("role");
            var mentorField = document.getElementById("mentor-group");
            mentorField.style.display = roleSelect.value === "student" ? "block" : "none";
        }

        function validateForm() {
            var role = document.getElementById("role").value;
            var mentor = document.getElementById("mentor").value;
            if (role === "student" && mentor.trim() === "") {
                alert("Please enter the mentor's name if you're a student.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body onload="updateForm()">
    <div class="signup-container">
        <h2>Sign Up</h2>
        <form method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <input type="text" id="username" name="username" placeholder="Enter username" required>
            </div>

            <div class="form-group">
                <input type="password" id="password" name="password" placeholder="Enter password" required>
            </div>

            <div class="form-group">
                <select id="role" name="role" required onchange="updateForm()">
                    <option value="">Select Role</option>
                    <option value="student">Student</option>
                    <option value="mentor">Mentor</option>
                </select>
            </div>

            <div class="form-group" id="mentor-group">
                <input type="text" id="mentor" name="mentor" placeholder="Enter mentor's name">
            </div>

            <div class="form-group">
                <input type="submit" value="Sign Up">
            </div>
        </form>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                String mentor = request.getParameter("mentor");

                try {
                    Connection conn = DBConnection.getConnection();
                    String sql = "INSERT INTO users (username, password, role, mentor_name) VALUES (?, ?, ?, ?)";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    ps.setString(3, role);
                    ps.setString(4, mentor.isEmpty() ? null : mentor);
                    
                    int rows = ps.executeUpdate();
                    if (rows > 0) {
                        out.println("<p class='success-message'>Sign Up successful! You can now <a href='login.jsp'>login</a>.</p>");
                    } else {
                        out.println("<p class='error-message'>Sign Up failed. Please try again.</p>");
                    }
                    conn.close();
                } catch (Exception e) {
                    out.println("<p class='error-message'>An error occurred: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>