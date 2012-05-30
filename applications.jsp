<!DOCTYPE html>
<%@page import="java.sql.*, javax.naming.*, javax.sql.*, support.*, java.util.*, gradstudent.*" %>
<html>
<head>
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
    <link rel="stylesheet" href="css/bootstrap-responsive.css" type="text/css">    
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">
    </script>
<script>
$(document).ready(function () {

$(".studRow").click(function (event) {
    if ($(this).next('.studDetails').length) {
        $(this).next('.studDetails').remove();
    }
    $(this).after('<tr class="studDetails"><td colspan="2"><button class="close">&times;</button><div class="progress"> <div class="bar" style="width: 0%;"> </div> </div></td></tr>');
    $(".close").click(function (event) {
        $(this).parent().parent().remove();
    });
    $('.bar').animate({ width: '+=100%'}, 2000, function () {
        $(this).parent().parent().append('<p class="error">Failure retrieving application data.</p>');
        $(this).parent().remove();
        });
    $.get("getapplication.jsp?studid=" + $(this).attr('id'), function (resJSON) {
        var res = $.parseJSON(resJSON);
        var deghtml = '';
        $.each(res.degrees, function (index, value) {
            deghtml += '<dt>' + index + '. ' + value.uname + ', ' + value.ustate + '</dt>';
            deghtml += '<dd>Degree in ' + value.major + '<br />Graduated in '
                    + value.month + '/' + value.year + ' with an avg GPA of '
                    + value.gpa + '</dt>';
        });
        var html = '<td><p>Citizen of: ' + res.citizenship + '</p><p>Resident of: '
                 + res.residence + '</p><address><strong>Address</strong><br/>'
                 + res.street + '<br/>' + res.city + ',' + res.statecode + ' '
                 + res.zipcode + '<br/> (' + res.areacode + ') ' + res.phonenumber
                 + '<br></address></td><td><button class="close">&times;</button>Specialization : '
                 + res.specialization + '<h3>Degrees</h3><dl>' + deghtml + '</dl></td>';
          $('#' + res.id).next('.studDetails').empty().append(html);
          $(".close").click(function (event) {
              $(this).parent().parent().remove();
          });
          });
        
      })
});
</script>
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
        pstmt = conn.prepareStatement("SELECT s_id, first_name, last_name FROM students WHERE specialization=?");
        pstmt.setInt(1, specialization);
    }
    else if (major != 0) {
        pstmt = conn.prepareStatement("SELECT students.s_id, students.first_name, students.last_name FROM students JOIN degrees ON students.s_id = degrees.student WHERE degrees.major=? GROUP BY students.first_name, students.last_name");
        pstmt.setInt(1, major);
    }
    else {
        pstmt = conn.prepareStatement("SELECT s_id, first_name, last_name FROM students");
    }
    rs = pstmt.executeQuery();
%>
<div class="span9">
<table class="table" style="table-layout: fixed;">
    <thead>
        <tr><th>Firstname</th><th style="width: 60%;">Lastname</th></tr>
    </thead>
    <tbody>
    <% while(rs.next()) { %>
    <tr class="studRow" id="<%=rs.getString(1)%>">
        <td><%= rs.getString(2) %></td>
        <td> <%= rs.getString(3) %> </td>
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
