<!DOCTYPE html>
<%@page import="java.sql.*, javax.naming.*, javax.sql.*, support.*, java.util.*, gradstudent.*" %>
<html>
<head>
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
    <link rel="stylesheet" href="css/bootstrap-responsive.css" type="text/css">    
</head>
<body>
<section>
    <div class="container" style="margin-top:20px">

<% 
Context initCtx = null;
DataSource ds = null;
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

int specialization = 0;
try {
    specialization = Integer.parseInt((String)(request.getParameter("specialization")));
}
catch (NumberFormatException e) { }

int major = 0;
try {
    major = Integer.parseInt((String)(request.getParameter("major")));
}
catch (NumberFormatException e) { }


try {
    initCtx = new InitialContext();
    ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/ClassesDBPool");
    conn = ds.getConnection();
    if (specialization != 0) {
        pstmt = conn.prepareStatement("SELECT first_name, last_name FROM students WHERE specialization=?");
        pstmt.setInt(1, specialization);
    }
    else if (major != 0) {
        pstmt = conn.prepareStatement("SELECT students.first_name, students.last_name FROM students JOIN degrees ON students.s_id = degrees.student WHERE degrees.major=? GROUP BY students.first_name, students.last_name");
        pstmt.setInt(1, major);
    }
    else {
        pstmt = conn.prepareStatement("SELECT first_name, last_name FROM students");
    }
    rs = pstmt.executeQuery();
%>
<div class="span7">
<table class="table table-bordered">
    <thead>
        <tr><th>Firstname</th><th>Lastname</th></tr>
    </thead>
    <tbody>
    <% while(rs.next()) { %>
    <tr>
        <td><%= rs.getString(1) %></td>
        <td> <%= rs.getString(2) %> </td>
    </tr>
    <% } %>
    </tbody>
</table>
</div>
<% } catch (SQLException e) { %>
<p><strong>An SQL error occured "<%= e %>".</strong>
You should consider restarting your application procedure. <a href="./">Restart now.</a></p>
<% }
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
    </div>
</section>
</body>
</html>
