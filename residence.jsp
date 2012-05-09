<!DOCTYPE html>
<%@page import="support.*, java.util.*, gradstudent.*" %>
<html>
<head>
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
    <link rel="stylesheet" href="css/bootstrap-responsive.css" type="text/css">    
</head>
<body>
<section>
    <div class="container" style="margin-top:20px">
    <div class="row">

<% 
int citizenship = 0;
try {
    citizenship = Integer.parseInt((String)(request.getParameter("citizenship")));
}
catch (NumberFormatException e) { }

GradStudent student = (GradStudent)session.getAttribute("student");

if (citizenship == 0 && student != null)
    citizenship = student.getCitizenship();

if (citizenship == 0 || student == null) { %>
<p><strong>An error occured.</strong>You should consider restarting your application procedure. <a href="./">Restart now.</a></p>
<% 
}
else {
student.setCitizenship(citizenship);

Countries c = new Countries();
%>
    <div class="span12">
    <h1>Choose your country of residence.</h1>
    <p>Welcome <%= student.getFirstName() %> <%= student.getMiddleInitial() %> <%= student.getLastName() %>!</p>
    <p>You are a citizen of: <%= c.getCountry(citizenship) %></p>
    <p><a href="address.jsp?residence=<%= citizenship %>">Click here if your country of residence is the same as your country of citizenship.</a></p>
    <table class="table table-bordered">
    <tr>
    <%
    for (int i = 0; i < c.getCountriesNb(); i++) {
    if (i % 3 == 0 && i != 0) { %>
        </tr><tr>
    <% } %>
    <td>
        <a href="address.jsp?residence=<%= i + 1 %>"><%= c.getCountry(i + 1) %>
    </td>
    <% } %>
    </table>
<% } %>
    </div>
    </div>
    </div>
</section>
</body>
</html>
