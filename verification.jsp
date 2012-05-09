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
if (student != null)
    curDegree = student.getLastDegree();

int specialization = 0;
try {
    specialization = Integer.parseInt((String)(request.getParameter("specialization")));
}
catch (NumberFormatException e) { }

if (student != null && specialization == 0)
    specialization = student.getSpecialization();

if (student == null || curDegree == null || student.getAddress() == null || specialization == 0) { %>
<p><strong>An error occured.</strong> You should consider restarting your application procedure. <a href="./">Restart now.</a></p>
<% 
}
else {
student.setSpecialization(specialization);

Countries c = new Countries();
Specializations spec = new Specializations();
Universities univ = new Universities();   
Majors majors = new Majors();
%>
    <h2>
        Review your application
        <small>Please take care that all the informations displayed are correct</small>
    </h2>
    <div class="row">
    <div class="span6">
    <h3>Your degrees</h3>
    <dl>
    <%
    Vector allDegrees = student.getDegrees();
    String uniName = null;
    String majName = null;
    int id = -1;
    for (int i = 0; i < allDegrees.size(); i++) {
        curDegree = (Degree)allDegrees.get(i);
        id = curDegree.getUni();
        if (id == -1) {
            uniName = curDegree.getCustomUni();
        }
        else {
            uniName = univ.getUnivById(id);
        }
        id = curDegree.getMajor();
        if (id == -1) {
            majName = curDegree.getCustomMajor();
        }
        else {
            majName = majors.getMajor(id);
        }
    %>
    <dt><%= i %>. <%= uniName %>, <%= univ.getUnivState(curDegree.getLoc()) %></dt>
    <dd>
        <%= curDegree.getTitle() %> in <%= majName %></br>
        Graduated in <%= curDegree.getMonth() %>/<%= curDegree.getYear() %> with an avg GPA of <%= curDegree.getGPA() %>
    </dd>
    <% } %>
    </dl>
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
    <div class="span12">
    <p>Your specialization is <strong><%= spec.getSpecialization(specialization) %></strong></p>
    </div>
    <div class="span6">
    <input type="button" onclick="window.location.href='submit.jsp'" value="Submit"></input>
    <input type="button" onclick="window.location.href='cancel.jsp'" value="Cancel"></input>
    </div>
    </div>

<% } %>
    </div>
</section>
</body>
</html>


