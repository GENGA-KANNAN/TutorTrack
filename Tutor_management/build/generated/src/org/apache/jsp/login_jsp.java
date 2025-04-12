package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import db.DBConnection;

public final class login_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>Login Page</title>\n");
      out.write("    <link href=\"https://fonts.googleapis.com/css2?family=Lobster&family=Poppins:wght@300;400;600&display=swap\" rel=\"stylesheet\">\n");
      out.write("    <style>\n");
      out.write("        body {\n");
      out.write("            font-family: 'Poppins', sans-serif;\n");
      out.write("            background: url('https://cache.careers360.mobi/media/presets/720X480/colleges/social-media/media-gallery/3666/2019/3/20/Campus%20View%20of%20National%20Engineering%20College%20Kovilpatti_Campus-View.jpg') no-repeat center center fixed;\n");
      out.write("            background-size: cover;\n");
      out.write("            display: flex;\n");
      out.write("            flex-direction: column;\n");
      out.write("            justify-content: center;\n");
      out.write("            align-items: center;\n");
      out.write("            height: 100vh;\n");
      out.write("            margin: 0;\n");
      out.write("            color: #343a40;\n");
      out.write("            backdrop-filter: blur(5px);\n");
      out.write("        }\n");
      out.write("        .container {\n");
      out.write("            background: rgba(255, 255, 255, 0.9);\n");
      out.write("            border-radius: 20px;\n");
      out.write("            box-shadow: 0 4px 40px rgba(0, 0, 0, 0.2);\n");
      out.write("            padding: 40px;\n");
      out.write("            width: 350px;\n");
      out.write("            transition: transform 0.3s ease, box-shadow 0.3s ease;\n");
      out.write("            animation: fadeIn 0.5s;\n");
      out.write("        }\n");
      out.write("        @keyframes fadeIn {\n");
      out.write("            from { opacity: 0; }\n");
      out.write("            to { opacity: 1; }\n");
      out.write("        }\n");
      out.write("        .container:hover {\n");
      out.write("            transform: translateY(-5px);\n");
      out.write("            box-shadow: 0 8px 60px rgba(0, 0, 0, 0.3);\n");
      out.write("        }\n");
      out.write("        h1 {\n");
      out.write("            text-align: center;\n");
      out.write("            font-size: 48px;\n");
      out.write("            margin-bottom: 30px;\n");
      out.write("            font-family: 'Lobster', cursive;\n");
      out.write("            color: #007bff;\n");
      out.write("            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);\n");
      out.write("        }\n");
      out.write("        h2 {\n");
      out.write("            text-align: center;\n");
      out.write("            margin-bottom: 20px;\n");
      out.write("            color: #495057;\n");
      out.write("            font-size: 24px;\n");
      out.write("            text-transform: uppercase;\n");
      out.write("            letter-spacing: 1px;\n");
      out.write("        }\n");
      out.write("        input[type=\"text\"],\n");
      out.write("        input[type=\"password\"],\n");
      out.write("        select {\n");
      out.write("            width: 100%;\n");
      out.write("            padding: 12px;\n");
      out.write("            margin: 10px 0;\n");
      out.write("            border: 2px solid #ced4da;\n");
      out.write("            border-radius: 10px;\n");
      out.write("            box-sizing: border-box;\n");
      out.write("            transition: border 0.3s, box-shadow 0.3s;\n");
      out.write("        }\n");
      out.write("        input[type=\"text\"]:focus,\n");
      out.write("        input[type=\"password\"]:focus,\n");
      out.write("        select:focus {\n");
      out.write("            border-color: #007bff;\n");
      out.write("            outline: none;\n");
      out.write("            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);\n");
      out.write("        }\n");
      out.write("        #mentorNameContainer {\n");
      out.write("            display: none;\n");
      out.write("        }\n");
      out.write("        .btn {\n");
      out.write("            background: linear-gradient(45deg, #007bff, #0056b3);\n");
      out.write("            color: white;\n");
      out.write("            border: none;\n");
      out.write("            padding: 12px;\n");
      out.write("            border-radius: 10px;\n");
      out.write("            cursor: pointer;\n");
      out.write("            width: 100%;\n");
      out.write("            font-size: 16px;\n");
      out.write("            transition: background 0.3s, transform 0.3s;\n");
      out.write("            box-shadow: 0 4px 20px rgba(0, 123, 255, 0.3);\n");
      out.write("        }\n");
      out.write("        .btn:hover {\n");
      out.write("            background: linear-gradient(45deg, #0056b3, #007bff);\n");
      out.write("            transform: translateY(-2px);\n");
      out.write("        }\n");
      out.write("        .error {\n");
      out.write("            color: red;\n");
      out.write("            text-align: center;\n");
      out.write("        }\n");
      out.write("        .signup {\n");
      out.write("            margin-top: 20px;\n");
      out.write("            text-align: center;\n");
      out.write("            color: #495057;\n");
      out.write("        }\n");
      out.write("        .signup a {\n");
      out.write("            color: #007bff;\n");
      out.write("            text-decoration: none;\n");
      out.write("            font-weight: bold;\n");
      out.write("        }\n");
      out.write("        .signup a:hover {\n");
      out.write("            text-decoration: underline;\n");
      out.write("        }\n");
      out.write("    </style>\n");
      out.write("    <script>\n");
      out.write("        function toggleMentorName() {\n");
      out.write("            const role = document.getElementById('roleSelect').value;\n");
      out.write("            const mentorNameContainer = document.getElementById('mentorNameContainer');\n");
      out.write("            mentorNameContainer.style.display = role === 'student' ? 'block' : 'none';\n");
      out.write("        }\n");
      out.write("\n");
      out.write("        function submitLoginForm() {\n");
      out.write("            const role = document.getElementById('roleSelect').value;\n");
      out.write("            const mentor = document.getElementById('mentor').value;\n");
      out.write("\n");
      out.write("            if (!role) {\n");
      out.write("                alert(\"Please select a role.\");\n");
      out.write("                return false;\n");
      out.write("            }\n");
      out.write("            if (role === 'student' && mentor.trim() === \"\") {\n");
      out.write("                alert(\"Please enter the mentor's name.\");\n");
      out.write("                return false;\n");
      out.write("            }\n");
      out.write("            return true;\n");
      out.write("        }\n");
      out.write("    </script>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("<h1 style=\"background: linear-gradient(to right, #007bff, #28a745); -webkit-background-clip: text; -webkit-text-fill-color: transparent;\">\n");
      out.write("    Tutor Management System\n");
      out.write("</h1>\n");
      out.write("\n");
      out.write("<div class=\"container\">\n");
      out.write("    <h2>Login</h2>\n");
      out.write("    <form name=\"loginForm\" method=\"post\" onsubmit=\"return submitLoginForm()\">\n");
      out.write("        <input type=\"text\" name=\"username\" placeholder=\"Username\" required>\n");
      out.write("        <input type=\"password\" name=\"password\" placeholder=\"Password\" required>\n");
      out.write("        \n");
      out.write("        <select id=\"roleSelect\" name=\"role\" onchange=\"toggleMentorName()\" required>\n");
      out.write("            <option value=\"\">Select Role</option>\n");
      out.write("            <option value=\"student\">Student</option>\n");
      out.write("            <option value=\"mentor\">Mentor</option>\n");
      out.write("        </select>\n");
      out.write("\n");
      out.write("        <div id=\"mentorNameContainer\">\n");
      out.write("            <input type=\"text\" id=\"mentor\" name=\"mentor\" placeholder=\"Mentor Name\">\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <button type=\"submit\" class=\"btn\">Login</button>\n");
      out.write("    </form>\n");
      out.write("\n");
      out.write("    ");
 
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
    
      out.write("\n");
      out.write("\n");
      out.write("    <div class=\"signup\">\n");
      out.write("        <p>Don't have an account? <a href=\"signup.jsp\">Sign up</a></p>\n");
      out.write("    </div>\n");
      out.write("</div>\n");
      out.write("</body>\n");
      out.write("</html>\n");
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
