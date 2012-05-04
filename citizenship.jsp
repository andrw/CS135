<%@page import="support.*, java.util.*, gradstudent.*" %>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
</head>

<% 
GradStudent student = new GradStudent(request.getParameter("firstName"), request.getParameter("middleName"), request.getParameter("lastName"));
application.setAttribute("student", student);
%>

<body>
      <div class="container" style="margin-top:20px">
    <div class="row-fluid">
        <div class="span12">
<h1>Welcome <%= student.getFirstName() %> <%= student.getLastName() %>!</h1>
  <%
  support s = new support();
  Vector countries = s.getCountries(config.getServletContext().getRealPath("countries.txt"));
  %>
  <table border=1>
    <tr>
      <%
      for(int i=0; i< countries.size(); i++) {
      if(i%3 == 0 && i!=0) {
      %>
    </tr><tr>
    <%
  }
  %>
  <td>
    <a href="residence.jsp?citizenship=<%= countries.get(i) %>"><%= countries.get(i) %>
  </td>
  <% 
}
%>
</tr>
</table>
</div>
</div>
</div>
</body>

</html>