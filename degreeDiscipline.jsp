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
  // grab old info
  GradStudent student = (GradStudent) application.getAttribute("student");

// set new info  
// record new info
application.setAttribute("uni", request.getParameter("uni"));

  %>

  <%-- display old info --%>
  <h1>Welcome <%= student.getFirstName() %> <%= student.getLastName() %>!<br></h1>
  citizenship: <%= student.getCitizenship() %><br>
  residence: <%= student.getResidence() %><br>
  address: <%= student.getAddress().getStreetNumber() %> <%= student.getAddress().getStreetName() %> <Br>
  <%= student.getAddress().getCity() %>, <%= student.getAddress().getZipcode() %><br>
  (<%= student.getAddress().getAreaCode() %>) <%= student.getAddress().getPhoneNumber() %><br>
Your chosen location: <%= application.getAttribute("loc") %><br>
Your chosen university: <%= application.getAttribute("uni") %><br>

  <%-- gather new info --%>
  <%
  support s = new support();   
      Vector majors = s.getMajors(config.getServletContext().getRealPath("majors.txt"));
  %>
  <form action="moreDegrees.jsp" method="GET">
  <select name="major" >
  <%
// change this into a drop down
    for(int i=0; i<majors.size(); i++) {
%>
  <option value="<%= majors.get(i) %>"><%= majors.get(i) %></option>
  <% } %>
</select><br>
GPA: <input value="" name="gpa"></input><br>
Month: <input value="" name="month"></input><br>
Year: <input value="" name="year"></input><br>
Title of Degree: <input value="" name="degreeTitle"></input><br>
<input type="submit" value="submit">
</form>

</div>
</div>
</div>

  </body>
  </html>