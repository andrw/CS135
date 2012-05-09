<!DOCTYPE html>
<%@page import="gradstudent.*" %>
<html>
<head>
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
    <link rel="stylesheet" href="css/bootstrap-responsive.css" type="text/css">    
</head>
<body>
<%
GradStudent student = (GradStudent)session.getAttribute("student");
String firstName = "";
String middleInitial = "";
String lastName = "";
if (student != null) {
    firstName = student.getFirstName();
    middleInitial = student.getMiddleInitial();
    lastName = student.getLastName();
}
%>
<section>
    <div class="container" style="margin-top:20px">
    <div class="row">
    <div class="span6">
            <h1>Graduate Student Application Form</h1>
            <p></p>
    <form action="citizenship.jsp" method="POST" class="well">
        <label>First Name</label>
        <input value="<%= firstName %>" type="text" class="span2" name="firstName"/>
        <label>Middle Initial</label>
        <input value="<%= middleInitial %>" name="middleInitial" class="span1" maxlength=1 />
        <label>Last Name</label>
        <input value="<%= lastName %>" name="lastName" class="span2"/>
        <br>
        <input type="submit" value="Submit" />
    </form>
    </div>
    </div>
    </div>
</section>
</body>
</html>
