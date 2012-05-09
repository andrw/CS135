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

String addUni = (String)(request.getParameter("addUni"));
int uni = -1;
try {
    uni = Integer.parseInt((String)(request.getParameter("uni")));
}
catch (NumberFormatException e) { }

Universities univ = new Universities();   

if (uni == -1 && student != null && curDegree != null && addUni == null) {
    uni = curDegree.getUni();
}

if (student == null || curDegree == null || student.getAddress() == null || (uni == -1 && addUni == null))
 { %>
<p><strong>An error occured.</strong>You should consider restarting your application procedure. <a href="./">Restart now.</a></p>
<% 
}
else {
if (uni != -1) {
    curDegree.setUni(uni);
}
else {
    curDegree.setCustomUni(addUni);
}

Countries c = new Countries();
Majors majors = new Majors();
%>

    <div class="row">
    <div class="span6">
    <p>Choose the major of your degree. If you don't find it in the list, add it with the form below.</p>
    <form action="moreDegrees.jsp" method="POST" class="form-horizontal">
    <fieldset>
        <div class="control-group">
        <label class="control-label">Majors</label>
        <div class=controls>
        <% for (int i = 0; i < majors.getMajorsNb(); i++) { %>
        <label class="radio">
            <input type="radio" name="stdMajor" value="<%= i + 1 %>"><%= majors.getMajorsVector().get(i) %>
        </label>
        <% } %>
        </div>
        </div>
        <div class="control-group">
            <label class="control-label">Add your major</label>
            <div class="controls">
            <input type="text" name="addMajor" class="span3" placeholder="Your major here">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">Graduation month</label>
            <div class="controls">
            <input type="text" name="gradMonth" class="span2">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">Graduation year</label>
            <div class="controls">
            <input type="text" name="gradYear" class="span1" maxlength="4">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">GPA</label>
            <div class="controls">
            <input type="text" name="gpa" class="span1" maxlength="4">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">Title of Degree</label>
            <div class="controls">
            <select name="degreeTitle" class="span1">
                <option value="BS">BS</option>
                <option value="MS">MS</option>
                <option value="PhD">PhD</option>
            </select>
            </div>
        </div>
        <button type="submit" class="btn">Submit</button>
    </fieldset>
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
    <p>You obtained your last degree in : <%= univ.getUnivState(curDegree.getLoc()) %></p>
    <!-- Need to add the university -->
    </div>
    </div>
<% } %>
    </div>
</section>
</body>
</html>
