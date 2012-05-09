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

try {
    initCtx = new InitialContext();
    ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/ClassesDBPool");
    conn = ds.getConnection();
    pstmt = conn.prepareStatement("SELECT majors.m_id, COUNT(degrees.major) FROM majors LEFT JOIN degrees ON degrees.major = majors.m_id GROUP BY majors.m_id ORDER BY majors.m_id");
    rs = pstmt.executeQuery();

    Majors spec = new Majors();
%>
<div class="span7">
<table class="table table-bordered">
    <thead>
        <tr><th>Discipline</th><th>Applicants</th></tr>
    </thead>
    <tbody>
    <% while(rs.next()) { %>
    <tr>
        <td><%= spec.getMajor(rs.getInt(1)) %></td>
        <td><a href="applications.jsp?major=<%= rs.getString(1) %>">
            <%= rs.getString(2) %>
        </a></td>
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
