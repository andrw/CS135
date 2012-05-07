<html>
<body>

<%@ page import="java.sql.*, support.*, java.util.*, gradstudent.*" %>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
  // Registering Postgresql JDBC driver with the DriverManager
  Class.forName("org.postgresql.Driver");

  // Open a connection to the database using DriverManager
  conn = DriverManager.getConnection(
  "jdbc:postgresql://localhost/andrewmini?" +
  "user=andrewmini&password=password");

  conn.setAutoCommit(false);

  pstmt = conn.prepareStatement("SELECT specializations.specialization s1, COUNT(gradstudents.specialization) FROM specializations LEFT JOIN gradstudents ON gradstudents.specialization = specializations.specialization group by specializations.specialization");

  rs = pstmt.executeQuery();




 // commit transaction
 conn.commit();
 conn.setAutoCommit(true);
 %>
<table>
  <tr><th>Specialization</th><th>Applicants</th></tr>
    <%
while(rs.next()) {
  %>
  <tr><td>
<%= rs.getString(1) %></td><td>   <a href="applications.jsp?action=specializations&special=<%= rs.getString(1) %>"><%= rs.getString(2) %></a></td></tr>
  <%
}
%>
</table>
<%
  // Close the Connection
  conn.close();

} catch (SQLException e) {
  // Wrap the SQL exception in a runtime exception to propagate
  // it upwards
  throw new RuntimeException(e);

}
  finally {
  // Release resources in a finally block in reverse-order of
  // their creation

  if (rs != null) {
  try {
  rs.close();
      } catch (SQLException e) { } // Ignore
      rs = null;
    }
    if (pstmt != null) {
    try {
    pstmt.close();
      } catch (SQLException e) { } // Ignore
      pstmt = null;
    }
    if (conn != null) {
    try {
    conn.close();
      } catch (SQLException e) { } // Ignore
      conn = null;
    }
  }


  %>
</body>
</html>