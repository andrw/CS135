<%@page import="support.*, java.util.*, gradstudent.*" %>
<html>

<head>
<link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
</head>
<body>
    <div class="container" style="margin-top:20px">
    <div class="row-fluid">
        <div class="span12">
  <% 
GradStudent student = (GradStudent) application.getAttribute("student");
student.setCitizenship(request.getParameter("citizenship"));
application.setAttribute("student", student);
%>
Welcome <%= student.getFirstName() %> <%= student.getLastName() %>!<br>
citizenship: <%= student.getCitizenship() %>
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
    <a href="address.jsp?residence=<%= countries.get(i) %>"><%= countries.get(i) %>
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