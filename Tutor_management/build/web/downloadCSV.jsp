<%@ page import="java.sql.*, java.io.*, db.DBConnection" %>
<%
// Set the content type to CSV

response.setContentType("text/csv");
response.setHeader("Content-Disposition",
"attachment;filename=student_details.csv");
// Fetch mentor username from session
String mentorUsername = (String) session.getAttribute("username");
try {
Connection conn = DBConnection.getConnection();
PrintWriter writer = response.getWriter();
// Write the CSV header
writer.println("Student Username,Student Name,Father Name,MotherName,DOB,SSLC Marks,HSC Marks,Subject Code,Subject Name,IAT1Marks,IAT2 Marks,Grade");
// Fetch students allocated to this mentor
PreparedStatement psStudents = conn.prepareStatement("SELECT * FROMUSERS WHERE MENTOR_NAME = ?");
psStudents.setString(1, mentorUsername);
ResultSet rsStudents = psStudents.executeQuery();
// Iterate over each student
while (rsStudents.next()) {
String studentUsername = rsStudents.getString("USERNAME");
// Fetch personal details
PreparedStatement psPersonal = conn.prepareStatement("SELECT *FROM PERSONALDETAILS WHERE USERNAME = ?");
psPersonal.setString(1, studentUsername);
ResultSet rsPersonal = psPersonal.executeQuery();
String studentName = "", fatherName = "", motherName = "", dob = "",
sslcMarks = "", hscMarks = "";
if (rsPersonal.next()) {
studentName = rsPersonal.getString("STUDENT_NAME");
fatherName = rsPersonal.getString("FATHER_NAME");
motherName = rsPersonal.getString("MOTHER_NAME");
// Handling DOB to ensure it formats correctly
Date dobDate = rsPersonal.getDate("DOB");
if (dobDate != null) {

// Format the DOB in a standard YYYY-MM-DD format (which issafe for CSV and spreadsheets)

dob = new java.text.SimpleDateFormat("yyyy-MM-dd").format(dobDate);

} else {
dob = "N/A"; // If no DOB is found, show "N/A"
}
sslcMarks = rsPersonal.getString("SSLC_MARKS");
hscMarks = rsPersonal.getString("HSC_MARKS");
}

// Fetch semester details and append them to the CSV
String[] semesters = {"SEM1", "SEM2", "SEM3", "SEM4"};
for (String semester : semesters) {
PreparedStatement psSem = conn.prepareStatement("SELECT * FROM" + semester + " WHERE USERNAME = ?");
psSem.setString(1, studentUsername);
ResultSet rsSem = psSem.executeQuery();
while (rsSem.next()) {
String subjectCode = rsSem.getString("SUBJECT_CODE");
String subjectName = rsSem.getString("SUBJECT_NAME");
String iat1Marks = rsSem.getString("IAT1_MARKS");
String iat2Marks = rsSem.getString("IAT2_MARKS");
String grade = rsSem.getString("GRADE");
// Write the student data and their semester details to the CSV
writer.println(studentUsername + "," + studentName + "," +
fatherName + "," + motherName + "," + dob + "," + sslcMarks + "," + hscMarks +
"," + subjectCode + "," + subjectName + "," + iat1Marks + "," + iat2Marks + "," +
grade);
}
}
}
} catch (SQLException e) {
out.println("<p>Error fetching data: " + e.getMessage() + "</p>");
}
%>