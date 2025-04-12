<%@ page import="java.sql.*" %>
<%@ page import="db.DBConnection" %>
<%@ page session="true" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student & Academic Details</title>
    <!-- Google Fonts for Lora -->
    <link href="https://fonts.googleapis.com/css2?family=Lora:wght@400;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<head>
    <!-- Importing Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
</head>

<head>
    <!-- Importing Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&family=Lobster&family=Playfair+Display:wght@400;500&display=swap" rel="stylesheet">
</head>
<head>
    <!-- Importing Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;700&family=Lobster&family=Playfair+Display:wght@400;500&display=swap" rel="stylesheet">
</head>
<style>
    /* Styling */
    body {
        font-family: 'Lora', serif;
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        margin: 0;
        padding: 0;
        color: #333;
    }

    .container {
        margin-top: 10px; /* Reduced margin at the top */
        background-color: rgba(255, 255, 255, 0.7);
        padding: 20px; /* Reduced padding inside the container */
        border-radius: 15px;
        box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
        max-width: 750px; /* Slightly reduced max-width for tighter fit */
        margin-left: auto;
        margin-right: auto;
    }

    /* Main Heading styling */
    h2 {
        text-align: center;
        color: #0056b3;
        margin-bottom: 15px; /* Reduced bottom margin */
        font-size: 30px; /* Slightly reduced font size */
        font-weight: bold;
        text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.2);
    }

    /* Form labels */
    label {
        font-weight: bold;
        color: #0056b3;
        margin-bottom: 5px; /* Reduced spacing between labels and inputs */
    }

    input[type="text"], input[type="date"] {
        width: 100%;
        padding: 6px; /* Further reduced padding inside inputs */
        margin-bottom: 8px; /* Further reduced bottom margin */
        border: 1px solid #ced4da;
        border-radius: 5px;
        font-size: 16px;
    }

    input[type="text"]:focus, input[type="date"]:focus {
        border-color: #0056b3;
        box-shadow: 0 0 5px rgba(0, 123, 255, 0.2); /* Reduced shadow size */
    }

    button {
        display: inline-block;
        width: 100%;
        padding: 10px; /* Reduced button padding */
        font-size: 16px; /* Reduced button font size */
        color: white;
        background-color: #0056b3;
        border: none;
        border-radius: 5px;
        transition: background-color 0.3s ease;
        margin-top: 8px; /* Reduced margin above the button */
    }

    button:hover {
        background-color: #003f7f;
        cursor: pointer;
    }

    /* Table styling */
    table {
        width: 100%;
        margin-top: 10px; /* Further reduced margin for the table */
        border-collapse: collapse;
        background-color: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
    }

    table th {
        background-color: #0056b3 !important;
        color: white !important;
        font-size: 16px;
        padding: 8px; /* Reduced padding */
        text-align: left;
        border-bottom: 1px solid #dddddd;
    }

    table td {
        font-size: 14px; /* Reduced font size */
        padding: 8px; /* Reduced padding */
        text-align: left;
        border-bottom: 1px solid #dddddd;
        color: #333;
    }

    .logout-link, .download-link {
        text-align: center;
        margin-top: 15px; /* Reduced margin */
    }

    .logout-link a, .download-link a {
        color: #007bff;
        font-size: 16px; /* Reduced font size */
        text-decoration: none;
        font-weight: bold;
    }

    .logout-link a:hover, .download-link a:hover {
        text-decoration: underline;
        color: #0056b3;
    }

    .student-header {
        margin-bottom: 5px; /* Further reduced margin */
        font-size: 20px; /* Reduced font size */
        color: #333;
        font-weight: bold;
        border-bottom: 2px solid #0056b3;
        padding-bottom: 5px;
    }

    .footer {
        text-align: center;
        margin-top: 15px; /* Reduced margin */
        color: #666;
        font-size: 12px; /* Reduced font size */
    }
</style>

    <script>
        function showSuccessMessage(message) {
            alert(message);
        }
    </script>
</head>
<body>
<%
    String newUsername = request.getParameter("username");

    if (newUsername != null && !newUsername.trim().isEmpty()) {
        session.invalidate();
        session = request.getSession(true);
        session.setAttribute("username", newUsername);
    }

    String username = (String) session.getAttribute("username");

    if (username == null) {
        out.println("<p class='error'>No user logged in!</p>");
    } else {
        out.println("<h2>Username: " + username + "</h2>");
    }

    String action = request.getParameter("action"); // Declare and initialize action here
%>

<% if (username != null) { %>
    <div class="form-container">
        <!-- Personal Details Form -->
        <h3>Personal Details</h3>
        <form method="post" action="Student.jsp">
            <table>
                <tr><td>Student Name:</td><td><input type="text" name="studentName" required></td></tr>
                <tr><td>Father Name:</td><td><input type="text" name="fatherName" required></td></tr>
                <tr><td>Mother Name:</td><td><input type="text" name="motherName" required></td></tr>
                <tr><td>Date of Birth:</td><td><input type="date" name="dob" required></td></tr>
                <tr><td>SSLC Marks:</td><td><input type="number" name="sslcMarks" required></td></tr>
                <tr><td>HSC Marks:</td><td><input type="number" name="hscMarks" required></td></tr>
                <tr><td>Student Mobile No:</td><td><input type="text" name="studentMobileNo" required></td></tr>
                <tr><td>Father Mobile No:</td><td><input type="text" name="fatherMobileNo" required></td></tr>
                <tr><td>Email Address:</td><td><input type="email" name="emailAddress" required></td></tr>
            </table>
            <input type="submit" name="action" value="Submit Personal Details" class="btn btn-primary">
        </form>
    </div>

    <% 
        // Handle Personal Details Submission
        if ("Submit Personal Details".equals(action)) {
            String studentName = request.getParameter("studentName");
            String fatherName = request.getParameter("fatherName");
            String motherName = request.getParameter("motherName");
            String dob = request.getParameter("dob");
            String sslcMarks = request.getParameter("sslcMarks");
            String hscMarks = request.getParameter("hscMarks");
            String studentMobileNo = request.getParameter("studentMobileNo");
            String fatherMobileNo = request.getParameter("fatherMobileNo");
            String emailAddress = request.getParameter("emailAddress");

            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            try {
                con = DBConnection.getConnection();
                
                // Check if the record already exists
                String checkQuery = "SELECT COUNT(*) FROM personaldetails WHERE username = ?";
                ps = con.prepareStatement(checkQuery);
                ps.setString(1, username);
                rs = ps.executeQuery();
                rs.next();

                if (rs.getInt(1) == 0) { // If no existing record
                    // Insert new record
                    String insertQuery = "INSERT INTO personaldetails (username, student_name, father_name, mother_name, dob, sslc_marks, hsc_marks, student_mobile_no, father_mobile_no, email_address) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    ps = con.prepareStatement(insertQuery);
                    ps.setString(1, username);
                    ps.setString(2, studentName);
                    ps.setString(3, fatherName);
                    ps.setString(4, motherName);
                    ps.setDate(5, Date.valueOf(dob));
                    ps.setInt(6, Integer.parseInt(sslcMarks));
                    ps.setInt(7, Integer.parseInt(hscMarks));
                    ps.setString(8, studentMobileNo);
                    ps.setString(9, fatherMobileNo);
                    ps.setString(10, emailAddress);
                } else { // If record exists, update it
                    String updateQuery = "UPDATE personaldetails SET student_name = ?, father_name = ?, mother_name = ?, dob = ?, sslc_marks = ?, hsc_marks = ?, student_mobile_no = ?, father_mobile_no = ?, email_address = ? WHERE username = ?";
                    ps = con.prepareStatement(updateQuery);
                    ps.setString(1, studentName);
                    ps.setString(2, fatherName);
                    ps.setString(3, motherName);
                    ps.setDate(4, Date.valueOf(dob));
                    ps.setInt(5, Integer.parseInt(sslcMarks));
                    ps.setInt(6, Integer.parseInt(hscMarks));
                    ps.setString(7, studentMobileNo);
                    ps.setString(8, fatherMobileNo);
                    ps.setString(9, emailAddress);
                    ps.setString(10, username);
                }
                
                // Execute the appropriate query
                ps.executeUpdate();
                out.println("<script>showSuccessMessage('Personal details submitted successfully.');</script>");
            } catch (NumberFormatException e) {
                out.println("<script>alert('Invalid number format: " + e.getMessage() + "');</script>");
                e.printStackTrace();
            } catch (SQLException e) {
                out.println("<script>alert('Database error: " + e.getMessage() + "');</script>");
                e.printStackTrace();
            } finally {
                if (rs != null) { try { rs.close(); } catch (SQLException ignore) {} }
                if (ps != null) { try { ps.close(); } catch (SQLException ignore) {} }
                if (con != null) { try { con.close(); } catch (SQLException ignore) {} }
            }
        }
    %>

    <!-- Display Personal Details -->
    <h3>Your Personal Details</h3>
    <div class="details-container">
        <div class="table-container">
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    con = DBConnection.getConnection();
                    String query = "SELECT * FROM personaldetails WHERE username = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, username);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        out.println("<table class='table table-bordered'>");
                        out.println("<tr><th>Field</th><th>Value</th></tr>");
                        out.println("<tr><td>Student Name</td><td>" + rs.getString("student_name") + "</td></tr>");
                        out.println("<tr><td>Father Name</td><td>" + rs.getString("father_name") + "</td></tr>");
                        out.println("<tr><td>Mother Name</td><td>" + rs.getString("mother_name") + "</td></tr>");
                        out.println("<tr><td>Date of Birth</td><td>" + rs.getDate("dob") + "</td></tr>");
                        out.println("<tr><td>SSLC Marks</td><td>" + rs.getInt("sslc_marks") + "</td></tr>");
                        out.println("<tr><td>HSC Marks</td><td>" + rs.getInt("hsc_marks") + "</td></tr>");
                        out.println("<tr><td>Student Mobile No</td><td>" + rs.getString("student_mobile_no") + "</td></tr>");
                        out.println("<tr><td>Father Mobile No</td><td>" + rs.getString("father_mobile_no") + "</td></tr>");
                        out.println("<tr><td>Email Address</td><td>" + rs.getString("email_address") + "</td></tr>");
                        out.println("</table>");
                    } else {
                        out.println("<p>No personal details found.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<script>alert('Error fetching personal details: " + e.getMessage() + "');</script>");
                    e.printStackTrace();
                } finally {
                    if (rs != null) { try { rs.close(); } catch (SQLException ignore) {} }
                    if (ps != null) { try { ps.close(); } catch (SQLException ignore) {} }
                    if (con != null) { try { con.close(); } catch (SQLException ignore) {} }
                }
            %>
        </div>
    </div>
<% } %>
</body>
</html>


<div class="container mt-5">
    <h3 class="text-center">Semester Details</h3>

    <!-- Semester Selection Form -->
    <form method="post" action="Student.jsp" class="form-inline mb-4">
        <div class="form-group mr-2">
            <label for="semester" class="mr-2">Select Semester:</label>
            <select id="semester" name="semester" class="form-control" required onchange="this.form.submit()">
                <option value="">-- Select Semester --</option>
                <option value="1">Semester 1</option>
                <option value="2">Semester 2</option>
                <option value="3">Semester 3</option>
                <option value="4">Semester 4</option>
                <option value="5">Semester 5</option>
                <option value="6">Semester 6</option>
                <option value="7">Semester 7</option>
                <option value="8">Semester 8</option>
            </select>
        </div>
    </form>

    <%
        String semester = request.getParameter("semester");
        // Define the maximum subjects for each semester
        int[] maxSubjects = {0, 8, 10, 10, 9, 9, 8, 10,10}; // Example: max subjects for Semester 1 to 8

        if (semester != null && username != null) {
    %>
    <form method="post" action="Student.jsp" class="mb-4">
        <input type="hidden" name="semester" value="<%= semester %>">
        <h4>Semester <%= semester %> Academic Details</h4>
        <table class="table table-bordered">
            <thead class="thead-light">
                <tr>
                    <th>Subject Code</th>
                    <th>Subject Name</th>
                    <th>IAT 1 Marks</th>
                    <th>IAT 2 Marks</th>
                    <th>Grade</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int subjects = maxSubjects[Integer.parseInt(semester)]; // Get max subjects for selected semester
                    for (int i = 1; i <= subjects; i++) {
                        out.println("<tr>");
                        out.println("<td><input type='text' name='subjectCode_" + i + "' class='form-control' required></td>");
                        out.println("<td><input type='text' name='subjectName_" + i + "' class='form-control' required></td>");
                        out.println("<td><input type='number' name='iat1Marks_" + i + "' min='0' class='form-control' required></td>");
                        out.println("<td><input type='number' name='iat2Marks_" + i + "' min='0' class='form-control' required></td>");
                        out.println("<td><input type='text' name='grade_" + i + "' class='form-control' required></td>");
                        out.println("</tr>");
                    }
                %>
            </tbody>
        </table>
        <br>
        <!-- New Fields for CGPA, GPA, and Arrear Count -->
        <div class="form-group">
            <label>CGPA:</label>
            <input type="number" step="0.01" name="cgpa" class="form-control" required>
        </div>
        <div class="form-group">
            <label>GPA:</label>
            <input type="number" step="0.01" name="gpa" class="form-control" required>
        </div>
        <div class="form-group">
            <label>Arrear Count:</label>
            <input type="number" name="arrearCount" min="0" class="form-control" required>
        </div>
        <input type="submit" name="action" value="Submit Semester <%= semester %> Details" class="btn btn-teal">
    </form>

    <!-- Displaying Existing Semester Details -->
    <h4>Existing Semester <%= semester %> Academic Details</h4>
    <table class="table table-bordered">
        <thead class="thead-light">
            <tr>
                <th>Subject Code</th>
                <th>Subject Name</th>
                <th>IAT 1 Marks</th>
                <th>IAT 2 Marks</th>
                <th>Grade</th>
            </tr>
        </thead>
        <tbody>
        <%
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;

            double cgpa = 0;
            double gpa = 0;
            int arrearCount = 0;

            try {
                con = DBConnection.getConnection();

                // Query to retrieve existing semester details
                String query = "SELECT subject_code, subject_name, iat1_marks, iat2_marks, grade, cgpa, gpa, arrear_count FROM sem" + semester + " WHERE username = ?";
                ps = con.prepareStatement(query);
                ps.setString(1, username);
                rs = ps.executeQuery();

                boolean firstRow = true; // To retrieve CGPA, GPA, and Arrear Count only once
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("subject_code") + "</td>");
                    out.println("<td>" + rs.getString("subject_name") + "</td>");
                    out.println("<td>" + rs.getInt("iat1_marks") + "</td>");
                    out.println("<td>" + rs.getInt("iat2_marks") + "</td>");
                    out.println("<td>" + rs.getString("grade") + "</td>");
                    out.println("</tr>");

                    // Retrieve CGPA, GPA, and Arrear Count only once (from the first row)
                    if (firstRow) {
                        cgpa = rs.getDouble("cgpa");
                        gpa = rs.getDouble("gpa");
                        arrearCount = rs.getInt("arrear_count");
                        firstRow = false;
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<tr><td colspan='5'>Error retrieving details.</td></tr>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        </tbody>
    </table>

    <!-- Display CGPA, GPA, and Arrear Count Separately -->
    <h5>CGPA: <%= cgpa %></h5>
    <h5>GPA: <%= gpa %></h5>
    <h5>Arrear Count: <%= arrearCount %></h5>

    <%
        }

        if (action != null && action.startsWith("Submit Semester")) {
            Connection con = null;
            PreparedStatement ps = null;

            try {
                con = DBConnection.getConnection();

                // Get semester number
                String selectedSemester = request.getParameter("semester");

                // First delete existing semester records
                String deleteQuery = "DELETE FROM sem" + selectedSemester + " WHERE username = ?";
                ps = con.prepareStatement(deleteQuery);
                ps.setString(1, username);
                ps.executeUpdate();
                ps.close(); // Close before reusing

                // Retrieve CGPA, GPA, and Arrear Count
                double cgpa = Double.parseDouble(request.getParameter("cgpa"));
                double gpa = Double.parseDouble(request.getParameter("gpa"));
                int arrearCount = Integer.parseInt(request.getParameter("arrearCount"));

                // Insert the new semester details without inserting a separate row for CGPA, GPA, Arrear Count in every row
                String insertQuery = "INSERT INTO sem" + selectedSemester + " (username, subject_code, subject_name, iat1_marks, iat2_marks, grade, cgpa, gpa, arrear_count) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(insertQuery);

                for (int i = 1; i <= maxSubjects[Integer.parseInt(selectedSemester)]; i++) {
                    String subjectCode = request.getParameter("subjectCode_" + i);
                    String subjectName = request.getParameter("subjectName_" + i);
                    int iat1Marks = Integer.parseInt(request.getParameter("iat1Marks_" + i));
                    int iat2Marks = Integer.parseInt(request.getParameter("iat2Marks_" + i));
                    String grade = request.getParameter("grade_" + i);

                    ps.setString(1, username);
                    ps.setString(2, subjectCode);
                    ps.setString(3, subjectName);
                    ps.setInt(4, iat1Marks);
                    ps.setInt(5, iat2Marks);
                    ps.setString(6, grade);
                    ps.setDouble(7, cgpa);
                    ps.setDouble(8, gpa);
                    ps.setInt(9, arrearCount);

                    ps.executeUpdate();
                }

                out.println("<script>Semester " + selectedSemester + " details submitted successfully!");
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>

</div>
</body>
</html>
