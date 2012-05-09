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

<% 
GradStudent student = (GradStudent)session.getAttribute("student");
Degree curDegree = null;
if (student != null) {
    try {
        curDegree = student.getLastDegree();
    }
    catch (NoSuchElementException e) { }
}

if (student == null || curDegree == null || student.getAddress() == null) { %>
<p><strong>An error occured.</strong>You should consider restarting your application procedure. <a href="./">Restart now.</a></p>
<% 
}
else {

Countries c = new Countries();
Specializations spec = new Specializations();

%>
    <div class="row">
    <div class="span6">
    <p>Choose your specialization.</p>
    <form action="verification.jsp" method="POST" class="well form-inline">
        <select name="specialization" class="span3">
        <% for (int i = 0; i < spec.getSpecializationsNb(); i++) { %>
            <option value="<%= i + 1 %>"><%= spec.getSpecialization(i + 1) %></option>
        <% } %>
        </select>
        <button type="submit" class="btn">Submit</button>
    </form>
    </div>

    <div class="span3">
    <h3> Your informations </h3>
    <p></p>
    <p>Name: <%= student.getFirstName() %>  <%= student.getMiddleInitial() %> <%= student.getLastName() %></p>
    <p>Citizen of: <%= c.getCountry(student.getCitizenship()) %></p>
    <p>Resident of: <%= c.getCountry(student.getResidence()) %></p>
    <address>
    <strong>Address</strong>
    <br/>
     <%= student.getAddress().getStreet() %><br/>
    <%= student.getAddress().getCity() %>, <%= student.getAddress().getStateCode() %> <%= student.getAddress().getZipcode() %><br/>
    <%= student.getAddress().getCountryCode() %> (<%= student.getAddress().getAreaCode() %>) <%= student.getAddress().getPhoneNumber() %><br>
    </address>
    </div>

    </div>
<% } %>
    </div>
</section>
</body>
</html>
