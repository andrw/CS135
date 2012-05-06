<%@page import="support.*, java.util.*, gradstudent.*, java.sql.*" %>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
</head>
<body>
      <div class="container" style="margin-top:20px">
    <div class="row-fluid">
        <div class="span12">
  <% 
  // grab old info
  GradStudent student = (GradStudent) application.getAttribute("student");

  // SUBMIT/UPDATE STUDENT INFO WITH DEGREE
  student.newDegree((String)application.getAttribute("loc"), (String)application.getAttribute("uni"), (String)application.getAttribute("major"), (String)application.getAttribute("month"), (String)application.getAttribute("year"), (String)application.getAttribute("gpa"));
// record new info
  application.setAttribute("student", student);
  %>

<%-- display old info --%>
<h1>Welcome <%= student.getFirstName() %> <%= student.getLastName() %>!<br></h1>
citizenship: <%= student.getCitizenship() %><br>
residence: <%= student.getResidence() %><br>
address: <%= student.getAddress().getStreetNumber() %> <%= student.getAddress().getStreetName() %> <Br>
<%= student.getAddress().getCity() %>, <%= student.getAddress().getStateCode() %> <%= student.getAddress().getZipcode() %><br>
(<%= student.getAddress().getAreaCode() %>) <%= student.getAddress().getPhoneNumber() %><br>


<%-- display all degree info --%>
<% 
for(int i=0; i<student.getDegrees().size(); i++) {
%>
  Degree # <%= i %> <br>
  Degree Location: <%= student.getDegrees().get(i).getLoc() %><Br>
  University: <%= student.getDegrees().get(i).getUni() %><br><br>
<% 
}
%>

<!-- connecting to database -->

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

  pstmt = conn.prepareStatement("SELECT * FROM specializations");

  rs = pstmt.executeQuery();



 // commit transaction
 conn.commit();
 conn.setAutoCommit(true);


%>
 <form action="verification.jsp" method="POST">
  <select name="specialization">

      <%
while(rs.next()) {
  %>
  <option value="<%= rs.getString(2) %>"> <%= rs.getString(2) %></option>
    <%
    }    
    %>
    <input type="submit" value="submit">
  </form>
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


<%-- gather new info --%>
<%
support s = new support();   
Vector specializations = s.getSpecializations(config.getServletContext().getRealPath("specializations.txt"));




%>

  </div>
</div>
</div>
  </body>
  </html>