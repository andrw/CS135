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

  pstmt = conn.prepareStatement("SELECT ");

  pstmt.setString(1, student.getFirstName());

  rs = pstmt.executeQuery();

 // commit transaction
 conn.commit();

 rs.next();
 int count = rs.getInt(1);

 conn.setAutoCommit(true);


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