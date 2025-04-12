<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page session="true" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <!-- Google Fonts for Lora -->
    <link href="https://fonts.googleapis.com/css2?family=Lora:wght@400;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Lora', serif;
            background-color: #e6f2ff;
            margin: 0;
            padding: 0;
            color: #333;
        }
        .container {
            margin-top: 30px;
            background-color: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.2);
        }
        h2 {
            text-align: center;
            color: #0056b3;
            margin-bottom: 20px;
            font-size: 32px;
            font-weight: bold;
            text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);
        }
        .student-header {
            margin-bottom: 15px;
            font-size: 24px;
            color: #333;
            font-weight: bold;
            border-bottom: 3px solid #0056b3;
            padding-bottom: 10px;
        }
        .footer {
            text-align: center;
            margin-top: 40px;
            color: #666;
            font-size: 14px;
        }
        .form-select {
            margin-bottom: 20px;
        }
        .logout-link a {
            color: #007bff;
            font-size: 18px;
            text-decoration: none;
            font-weight: bold;
        }
        .logout-link a:hover {
            text-decoration: underline;
            color: #0056b3;
        }
        .table-wrapper {
            overflow-x: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Admin Dashboard</h2>

<!-- Mentor dropdown list -->
<form method="get" action="admin.jsp">
    <label for="mentorName" class="form-label">Select Mentor:</label>
    <select name="mentorName" id="mentorName" class="form-select" onchange="this.form.submit()">
        <option value="">All Students</option>
        <%
            // Fetch and populate mentor names from the database
            try {
                Connection conn = DBConnection.getConnection();
                PreparedStatement psMentors = conn.prepareStatement(
                    "SELECT DISTINCT mentor_name FROM USERS WHERE mentor_name IS NOT NULL AND mentor_name <> ''");
                ResultSet rsMentors = psMentors.executeQuery();

                while (rsMentors.next()) {
                    String mentorName = rsMentors.getString("mentor_name");

                    // Only include non-null and non-empty mentor names
                    if (mentorName != null && !mentorName.trim().isEmpty() && !mentorName.equals("null")) {
                        out.println("<option value='" + mentorName + "'"
                                    + (mentorName.equals(request.getParameter("mentorName")) ? " selected" : "")
                                    + ">" + mentorName + "</option>");
                    }
                }

                rsMentors.close();
                psMentors.close();
                conn.close();
            } catch (SQLException e) {
                out.println("<p>Error fetching mentor names: " + e.getMessage() + "</p>");
            }
        %>
    </select>
</form>


        <!-- Student dropdown based on the selected mentor -->
        <%
            String selectedMentor = request.getParameter("mentorName");
            if (selectedMentor != null && !selectedMentor.trim().isEmpty()) {
        %>
        <form method="get" action="admin.jsp">
            <input type="hidden" name="mentorName" value="<%= selectedMentor %>">
            <label for="studentName" class="form-label">Select Student:</label>
            <select name="studentName" id="studentName" class="form-select" onchange="this.form.submit()">
                <option value="">Select Student</option>
                <%
                    try {
                        Connection conn = DBConnection.getConnection();
                        String query = "SELECT PERSONALDETAILS.STUDENT_NAME, PERSONALDETAILS.USERNAME "
                                    + "FROM USERS JOIN PERSONALDETAILS ON USERS.username = PERSONALDETAILS.username "
                                    + "WHERE USERS.mentor_name = ?";
                        PreparedStatement psStudents = conn.prepareStatement(query);
                        psStudents.setString(1, selectedMentor);
                        ResultSet rsStudents = psStudents.executeQuery();

                        while (rsStudents.next()) {
                            String studentName = rsStudents.getString("STUDENT_NAME");
                            String studentUsername = rsStudents.getString("USERNAME");

                            out.println("<option value='" + studentUsername + "'"
                                        + (studentUsername.equals(request.getParameter("studentName")) ? " selected" : "")
                                        + ">" + studentName + "</option>");
                        }

                        rsStudents.close();
                        psStudents.close();
                        conn.close();
                    } catch (SQLException e) {
                        out.println("<p>Error fetching students for the mentor: " + e.getMessage() + "</p>");
                    }
                %>
            </select>
        </form>
        <%
            }
        %>

        <!-- Displaying personal details of the selected student -->
        <div class="student-header">Student Personal Details</div>
        <div class="table-wrapper">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Student Name</th>
                        <th>Father Name</th>
                        <th>Mother Name</th>
                        <th>DOB</th>
                        <th>SSLC Marks</th>
                        <th>HSC Marks</th>
                        <th>Mobile Number</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    String selectedStudent = request.getParameter("studentName");

                    if (selectedStudent != null && !selectedStudent.trim().isEmpty()) {
                        try {
                            Connection conn = DBConnection.getConnection();
                            String query = "SELECT * FROM PERSONALDETAILS WHERE username = ?";
                            PreparedStatement psPersonal = conn.prepareStatement(query);
                            psPersonal.setString(1, selectedStudent);
                            ResultSet rsPersonal = psPersonal.executeQuery();

                            if (rsPersonal.next()) {
                                out.println("<tr>");
                                out.println("<td>" + rsPersonal.getString("USERNAME") + "</td>");
                                out.println("<td>" + rsPersonal.getString("STUDENT_NAME") + "</td>");
                                out.println("<td>" + rsPersonal.getString("FATHER_NAME") + "</td>");
                                out.println("<td>" + rsPersonal.getString("MOTHER_NAME") + "</td>");
                                out.println("<td>" + rsPersonal.getString("DOB") + "</td>");
                                out.println("<td>" + rsPersonal.getString("SSLC_MARKS") + "</td>");
                                out.println("<td>" + rsPersonal.getString("HSC_MARKS") + "</td>");
                                out.println("<td>" + rsPersonal.getString("STUDENT_MOBILE_NO") + "</td>");
                                out.println("<td>" + rsPersonal.getString("EMAIL_ADDRESS") + "</td>");
                                out.println("</tr>");
                            }

                            rsPersonal.close();
                            psPersonal.close();
                            conn.close();
                        } catch (SQLException e) {
                            out.println("<p>Error fetching student's personal details: " + e.getMessage() + "</p>");
                        }
                    }
                %>
                </tbody>
            </table>
        </div>

        <!-- Display academic details for the selected student -->
        <div class="student-header">Academic Details</div>
        <div class="table-wrapper">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>Semester</th>
                        <th>Subject Code</th>
                        <th>Subject Name</th>
                        <th>IAT1 Marks</th>
                        <th>IAT2 Marks</th>
                        <th>Grade</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (selectedStudent != null && !selectedStudent.trim().isEmpty()) {
                        String[] semesters = {"SEM1", "SEM2", "SEM3", "SEM4", "SEM5", "SEM6", "SEM7", "SEM8"};

                        try {
                            Connection conn = DBConnection.getConnection();

                            for (String semester : semesters) {
                                String querySem = "SELECT * FROM " + semester + " WHERE username = ?";
                                PreparedStatement psSem = conn.prepareStatement(querySem);
                                psSem.setString(1, selectedStudent);
                                ResultSet rsSem = psSem.executeQuery();

                                while (rsSem.next()) {
                                    out.println("<tr>");
                                    out.println("<td>" + semester + "</td>");
                                    out.println("<td>" + rsSem.getString("SUBJECT_CODE") + "</td>");
                                    out.println("<td>" + rsSem.getString("SUBJECT_NAME") + "</td>");
                                    out.println("<td>" + rsSem.getString("IAT1_MARKS") + "</td>");
                                    out.println("<td>" + rsSem.getString("IAT2_MARKS") + "</td>");
                                    out.println("<td>" + rsSem.getString("GRADE") + "</td>");
                                    out.println("</tr>");
                                }

                                rsSem.close();
                                psSem.close();
                            }

                            conn.close();
                        } catch (SQLException e) {
                            out.println("<p>Error fetching student's academic details: " + e.getMessage() + "</p>");
                        }
                    }
                %>
                </tbody>
            </table>
        </div>

        <!-- Logout link -->
        <div class="logout-link">
            <a href="logout.jsp">Logout</a>
        </div>
    </div>
</body>
</html>