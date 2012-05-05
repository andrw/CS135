<html>
<body>
  <%
  GradStudent student = (GradStudent) application.getAttribute("student");
%>
<%-- open connection --%>
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

  pstmt = conn.prepareStatement("INSERT INTO gradstudents (first_name, middle_name, last_name, citizenship, residence, streetNumber, streetName, city, stateCode, zipcode, areaCode, phoneNumber) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) returning id");
  
  pstmt.setString(1, student.getFirstName());
  pstmt.setString(2, student.getMiddleName());
  pstmt.setString(3, student.getLastName());
  pstmt.setString(4, student.getCitizenship());
  pstmt.setString(5, student.getResidence());
  pstmt.setString(6, student.getAddress().getStreetNumber());
  pstmt.setString(7, student.getAddress().getStreetName());
  pstmt.setString(8, student.getAddress().getCity());
  pstmt.setString(9, student.getAddress().getStateCode());
  pstmt.setString(10, student.getAddress().getZipcode());
  pstmt.setString(11, student.getAddress().getAreaCode());
  pstmt.setString(12, student.getAddress().getPhoneNumber());

rs = pstmt.executeQuery();

 // commit transaction
 conn.commit();

rs.next();
int count = rs.getInt(1);
ArrayList<Degree> degrees = student.getDegrees();
 

for(int i=0; i<degrees.size(); i++) {
  pstmt = conn.prepareStatement("INSERT INTO degrees ( loc, uni, discipline, month, year, gpa, gradstudent) VALUES (?, ?, ?, ?, ?, ?, ?)");
pstmt.setString(1, degrees.get(0).getLoc());
pstmt.setString(2, degrees.get(0).getUni());
pstmt.setString(3, degrees.get(0).getDiscipline());
pstmt.setString(4, degrees.get(0).getMonth());
pstmt.setString(5, degrees.get(0).getYear());
pstmt.setString(6, degrees.get(0).getGPA());
pstmt.setInt(7, count);
pstmt.executeUpdate();
 conn.commit();
}


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
</body>
</html>