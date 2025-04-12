<%@ page import="java.sql.*, db.DBConnection" %>
<%@ page session="true" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Mentor Dashboard</title>
    <!-- Google Fonts for Lora -->
    <link href="https://fonts.googleapis.com/css2?family=Lora:wght@400;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        /* Styling */
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
        .logout-link, .download-link {
            text-align: center;
            margin-bottom: 20px;
        }
        .logout-link a, .download-link a {
            color: #007bff;
            font-size: 18px;
            text-decoration: none;
            font-weight: bold;
        }
        .logout-link a:hover, .download-link a:hover {
            text-decoration: underline;
            color: #0056b3;
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
    </style>
</head>
<body>
    <div class="container">
       <%
            String mentorUsername = (String) session.getAttribute("username");
            if (mentorUsername != null) {
                out.println("<h2>Welcome, " + mentorUsername + "!</h2>");
            } else {
                out.println("<h2>Welcome!</h2>");
            }
        %>

        <!-- Form to select a student -->
        <form method="POST">
            <label for="student">Select a Student:</label>
            <select name="studentUsername" id="student" class="form-select" required>
                <option value="">--Select Student--</option>
                <%
                    // Fetch students allocated to this mentor from the 'USERS' table
                    try {
                        Connection conn = DBConnection.getConnection();
                        PreparedStatement psStudents = conn.prepareStatement("SELECT USERNAME FROM USERS WHERE MENTOR_NAME = ?");
                        psStudents.setString(1, mentorUsername);

                        ResultSet rsStudents = psStudents.executeQuery();

                        while (rsStudents.next()) {
                            String studentUsername = rsStudents.getString("USERNAME");
                            out.println("<option value='" + studentUsername + "'>" + studentUsername + "</option>");
                        }
                    } catch (SQLException e) {
                        out.println("<option>Error fetching students</option>");
                    }
                %>
            </select>
            <button type="submit" class="btn btn-primary">View Student Details</button>
        </form>

        <%
            // Display details of the selected student
            String selectedStudent = request.getParameter("studentUsername");

            if (selectedStudent != null && !selectedStudent.isEmpty()) {
                out.println("<div class='student-header'>Details for " + selectedStudent + ":</div>");

                try {
                    Connection conn = DBConnection.getConnection();

                    // Fetch personal details
                    PreparedStatement psPersonal = conn.prepareStatement("SELECT * FROM PERSONALDETAILS WHERE USERNAME = ?");
                    psPersonal.setString(1, selectedStudent);
                    ResultSet rsPersonal = psPersonal.executeQuery();

                    if (rsPersonal.next()) {
                        out.println("<p><strong>Student Name:</strong> " + rsPersonal.getString("STUDENT_NAME") + "</p>");
                        out.println("<p><strong>Father Name:</strong> " + rsPersonal.getString("FATHER_NAME") + "</p>");
                        out.println("<p><strong>Mother Name:</strong> " + rsPersonal.getString("MOTHER_NAME") + "</p>");
                        out.println("<p><strong>DOB:</strong> " + rsPersonal.getString("DOB") + "</p>");
                        out.println("<p><strong>SSLC Marks:</strong> " + rsPersonal.getString("SSLC_MARKS") + "</p>");
                        out.println("<p><strong>HSC Marks:</strong> " + rsPersonal.getString("HSC_MARKS") + "</p>");
                    } else {
                        out.println("<p>No personal details found for this student.</p>");
                    }

                    // Fetch semester details
                    String[] semesters = {"SEM1", "SEM2", "SEM3", "SEM4","SEM5","SEM6","SEM7","SEM8"};
                    for (String semester : semesters) {
                        PreparedStatement psSem = conn.prepareStatement("SELECT * FROM " + semester + " WHERE USERNAME = ?");
                        psSem.setString(1, selectedStudent);
                        ResultSet rsSem = psSem.executeQuery();

                        out.println("<h5 class='achievements-header'>" + semester + " Details</h5>");
                        out.println("<table class='table table-striped'><thead><tr><th>Subject Code</th><th>Subject Name</th><th>IAT1 Marks</th><th>IAT2 Marks</th><th>Grade</th></tr></thead><tbody>");

                        while (rsSem.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rsSem.getString("SUBJECT_CODE") + "</td>");
                            out.println("<td>" + rsSem.getString("SUBJECT_NAME") + "</td>");
                            out.println("<td>" + rsSem.getString("IAT1_MARKS") + "</td>");
                            out.println("<td>" + rsSem.getString("IAT2_MARKS") + "</td>");
                            out.println("<td>" + rsSem.getString("GRADE") + "</td>");
                            out.println("</tr>");
                        }
                        out.println("</tbody></table>");
                    }

                    // Link to download the student's details as CSV
                    out.println("<div class='download-link'><a href='downloadCSV.jsp?studentUsername=" + selectedStudent + "'><i class='fas fa-download'></i> Download " + selectedStudent + "'s Details</a></div>");
                    
                } catch (SQLException e) {
                    out.println("<p>Error retrieving student's details: " + e.getMessage() + "</p>");
                }
            }
        %>

        <div class="logout-link">
            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>