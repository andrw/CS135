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

int major = -1;
try {
    major = Integer.parseInt((String)(request.getParameter("stdMajor")));
}
catch (NumberFormatException e) { }

String addMajor= request.getParameter("addMajor");
String gpa = request.getParameter("gpa");
String month = request.getParameter("gradMonth");
String year = request.getParameter("gradYear");
String title = request.getParameter("degreeTitle");

if (student == null || curDegree == null || student.getAddress() == null ||
        (curDegree.getMonth() == null &&
            ((major == -1 && addMajor == null) || gpa == null || month == null || year == null || title == null)))
 { %>
<p><strong>An error occured.</strong>You should consider restarting your application procedure. <a href="./">Restart now.</a></p>
<% 
}
else {
if (month != null) {
    if (major != -1) {
        curDegree.setMajor(major);
    }
    else {
        curDegree.setCustomMajor(addMajor);
    }
    curDegree.setGPA(gpa);
    curDegree.setMonth(month);
    curDegree.setYear(year);
    curDegree.setTitle(title);
}

Countries c = new Countries();
Universities univ = new Universities();   
Majors majors = new Majors();
%>

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
    <div class="span9">
    <button onClick="location.href='specialization.jsp'" class="btn">Submit</button>
    <button onClick="location.href='degreeloc.jsp'" class="btn">Add Another Degree</button>
    </div>

    </div>
<% } %>
    </div>
</section>
</body>
</html>
