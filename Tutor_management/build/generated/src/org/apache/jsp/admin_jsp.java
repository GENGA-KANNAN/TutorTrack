package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import db.DBConnection;

public final class admin_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>Admin Dashboard</title>\n");
      out.write("    <!-- Google Fonts for Lora -->\n");
      out.write("    <link href=\"https://fonts.googleapis.com/css2?family=Lora:wght@400;700&display=swap\" rel=\"stylesheet\">\n");
      out.write("    <!-- Bootstrap CSS -->\n");
      out.write("    <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\n");
      out.write("    <!-- Font Awesome for icons -->\n");
      out.write("    <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css\">\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: 'Lora', serif;\n");
      out.write("            background-color: #e6f2ff;\n");
      out.write("            margin: 0;\n");
      out.write("            padding: 0;\n");
      out.write("            color: #333;\n");
      out.write("        }\n");
      out.write("        .container {\n");
      out.write("            margin-top: 30px;\n");
      out.write("            background-color: rgba(255, 255, 255, 0.95);\n");
      out.write("            padding: 30px;\n");
      out.write("            border-radius: 10px;\n");
      out.write("            box-shadow: 0px 0px 30px rgba(0, 0, 0, 0.2);\n");
      out.write("        }\n");
      out.write("        h2 {\n");
      out.write("            text-align: center;\n");
      out.write("            color: #0056b3;\n");
      out.write("            margin-bottom: 20px;\n");
      out.write("            font-size: 32px;\n");
      out.write("            font-weight: bold;\n");
      out.write("            text-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);\n");
      out.write("        }\n");
      out.write("        .student-header {\n");
      out.write("            margin-bottom: 15px;\n");
      out.write("            font-size: 24px;\n");
      out.write("            color: #333;\n");
      out.write("            font-weight: bold;\n");
      out.write("            border-bottom: 3px solid #0056b3;\n");
      out.write("            padding-bottom: 10px;\n");
      out.write("        }\n");
      out.write("        .footer {\n");
      out.write("            text-align: center;\n");
      out.write("            margin-top: 40px;\n");
      out.write("            color: #666;\n");
      out.write("            font-size: 14px;\n");
      out.write("        }\n");
      out.write("        .form-select {\n");
      out.write("            margin-bottom: 20px;\n");
      out.write("        }\n");
      out.write("        .logout-link a {\n");
      out.write("            color: #007bff;\n");
      out.write("            font-size: 18px;\n");
      out.write("            text-decoration: none;\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("        .logout-link a:hover {\n");
      out.write("            text-decoration: underline;\n");
      out.write("            color: #0056b3;\n");
      out.write("        }\n");
      out.write("        .table-wrapper {\n");
      out.write("            overflow-x: auto;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("    <div class=\"container\">\n");
      out.write("        <h2>Admin Dashboard</h2>\n");
      out.write("\n");
      out.write("<!-- Mentor dropdown list -->\n");
      out.write("<form method=\"get\" action=\"admin.jsp\">\n");
      out.write("    <label for=\"mentorName\" class=\"form-label\">Select Mentor:</label>\n");
      out.write("    <select name=\"mentorName\" id=\"mentorName\" class=\"form-select\" onchange=\"this.form.submit()\">\n");
      out.write("        <option value=\"\">All Students</option>\n");
      out.write("        ");

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
        
      out.write("\n");
      out.write("    </select>\n");
      out.write("</form>\n");
      out.write("\n");
      out.write("\n");
      out.write("        <!-- Student dropdown based on the selected mentor -->\n");
      out.write("        ");

            String selectedMentor = request.getParameter("mentorName");
            if (selectedMentor != null && !selectedMentor.trim().isEmpty()) {
        
      out.write("\n");
      out.write("        <form method=\"get\" action=\"admin.jsp\">\n");
      out.write("            <input type=\"hidden\" name=\"mentorName\" value=\"");
      out.print( selectedMentor );
      out.write("\">\n");
      out.write("            <label for=\"studentName\" class=\"form-label\">Select Student:</label>\n");
      out.write("            <select name=\"studentName\" id=\"studentName\" class=\"form-select\" onchange=\"this.form.submit()\">\n");
      out.write("                <option value=\"\">Select Student</option>\n");
      out.write("                ");

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
                
      out.write("\n");
      out.write("            </select>\n");
      out.write("        </form>\n");
      out.write("        ");

            }
        
      out.write("\n");
      out.write("\n");
      out.write("        <!-- Displaying personal details of the selected student -->\n");
      out.write("        <div class=\"student-header\">Student Personal Details</div>\n");
      out.write("        <div class=\"table-wrapper\">\n");
      out.write("            <table class=\"table table-striped\">\n");
      out.write("                <thead>\n");
      out.write("                    <tr>\n");
      out.write("                        <th>Username</th>\n");
      out.write("                        <th>Student Name</th>\n");
      out.write("                        <th>Father Name</th>\n");
      out.write("                        <th>Mother Name</th>\n");
      out.write("                        <th>DOB</th>\n");
      out.write("                        <th>SSLC Marks</th>\n");
      out.write("                        <th>HSC Marks</th>\n");
      out.write("                        <th>Mobile Number</th>\n");
      out.write("                        <th>Email</th>\n");
      out.write("                    </tr>\n");
      out.write("                </thead>\n");
      out.write("                <tbody>\n");
      out.write("                ");

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
                
      out.write("\n");
      out.write("                </tbody>\n");
      out.write("            </table>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <!-- Display academic details for the selected student -->\n");
      out.write("        <div class=\"student-header\">Academic Details</div>\n");
      out.write("        <div class=\"table-wrapper\">\n");
      out.write("            <table class=\"table table-striped\">\n");
      out.write("                <thead>\n");
      out.write("                    <tr>\n");
      out.write("                        <th>Semester</th>\n");
      out.write("                        <th>Subject Code</th>\n");
      out.write("                        <th>Subject Name</th>\n");
      out.write("                        <th>IAT1 Marks</th>\n");
      out.write("                        <th>IAT2 Marks</th>\n");
      out.write("                        <th>Grade</th>\n");
      out.write("                    </tr>\n");
      out.write("                </thead>\n");
      out.write("                <tbody>\n");
      out.write("                ");

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
                
      out.write("\n");
      out.write("                </tbody>\n");
      out.write("            </table>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <!-- Logout link -->\n");
      out.write("        <div class=\"logout-link\">\n");
      out.write("            <a href=\"logout.jsp\">Logout</a>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
