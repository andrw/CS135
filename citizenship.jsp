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
String firstName = (String)(request.getParameter("firstName"));
String lastName = (String)(request.getParameter("lastName"));
String middleInitial = (String)(request.getParameter("middleInitial"));
GradStudent student = (GradStudent)session.getAttribute("student");

if (firstName == null && student != null)
        firstName = student.getFirstName();
if (lastName == null && student != null)
        lastName = student.getLastName();
if (middleInitial == null && student != null)
        middleInitial = student.getMiddleInitial();
if (firstName == null || lastName == null || middleInitial == null) { %>
<p><strong>An error occured.</strong>You should consider restarting your application procedure. <a href="./">Restart now.</a></p>
<% 
}
else {
if (student == null) {
    student = new GradStudent(firstName, middleInitial, lastName);
    session.setAttribute("student", student);
}
else {
    student.setFirstName(firstName);
    student.setLastName(lastName);
    student.setMiddleInitial(middleInitial);
}

Countries c = new Countries();
%>
    <div class="span12">
    <h1>Choose your country of citizenship.</h1>
    <p>Welcome <%= student.getFirstName() %> <%= student.getMiddleInitial() %> <%= student.getLastName() %>!</p>
    <table class="table table-bordered">
    <tr>
    <%
    for (int i = 0; i < c.getCountriesNb(); i++) {
    if (i % 3 == 0 && i != 0) { %>
        </tr><tr>
    <% } %>
    <td>
        <a href="residence.jsp?citizenship=<%= i + 1 %>"><%= c.getCountry(i + 1) %>
    </td>
    <% } %>
<% } %>
    </div>
    </div>
    </div>
</section>
</body>
</html>
