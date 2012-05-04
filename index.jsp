<h1><%@page import="java.util.*, gradstudent.*" %>
</h1>
<% if(application.getAttribute("students") == null) {
ArrayList students = new ArrayList();
application.setAttribute("students", students);
}
%>

<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
</head>
<body>
    <div class="container" style="margin-top:20px">
    <div class="row-fluid">
        <h1><div class="span12">
            <h1>Graduate Student Application Form</h1></h1>
            <br>
    <form action="citizenship.jsp" method="POST">
    <table>
        <tr>
            <td>First Name</td>
            <td><input value="" name="firstName" size="10"/></td>
        </tr>
        <tr>
            <td>Middle Name</td>
            <td><input value="" name="middleName" size="10"/></td>
        </tr>
        <tr>
            <td>Last Name</td>
            <td><input value="" name="lastName" size="10"/></td>
        </tr>
    </table>
    <Br>
    <input type="submit" value="Submit" />
</form>
</div>
</div>
</div>
</body>
</html>