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
application.setAttribute("major", request.getParameter("major"));
application.setAttribute("gpa", request.getParameter("gpa"));
application.setAttribute("month", request.getParameter("month"));
application.setAttribute("year", request.getParameter("year"));

  %>

  <%-- display old info --%>
  <h1>Welcome <%= student.getFirstName() %> <%= student.getLastName() %>!<br></h1>
  citizenship: <%= student.getCitizenship() %><br>
  residence: <%= student.getResidence() %><br>
  address: <%= student.getAddress().getStreetNumber() %> <%= student.getAddress().getStreetName() %> <Br>
  <%= student.getAddress().getCity() %>, <%= student.getAddress().getZipcode() %><br>
  (<%= student.getAddress().getAreaCode() %>) <%= student.getAddress().getPhoneNumber() %><br>
<Br>
<%-- previously entered degrees --%>
<% 

for(int i=0; i<student.getDegrees().size(); i++) {

%>

  
  Degree # <%= i %> <br>
  Degree Location: <%= student.getDegrees().get(i).getLoc() %><Br>
  University: <%= student.getDegrees().get(i).getUni() %><br>
  Major: <%= student.getDegrees().get(i).getDiscipline() %><br>
GPA: <%= student.getDegrees().get(i).getGPA() %><br>
Graduation Date: <%= student.getDegrees().get(i).getMonth() %>/<%= student.getDegrees().get(i).getYear() %><br><br>
<% 
}
%>

<%-- current degree stuff --%>
Most recent update:<br> 
Your chosen location: <%= application.getAttribute("loc") %><br>
Your chosen university: <%= application.getAttribute("uni") %><br>
Your chosen Major: <%= application.getAttribute("major") %><br>
Your GPA: <%= application.getAttribute("gpa") %><br>
Your Graduation Date: <%= application.getAttribute("month") %>/<%= application.getAttribute("year") %><br><br>

<button onClick="location.href='specialization.jsp'">Submit</button>
<button onClick="location.href='degreeloc.jsp?action=anotherDegree'">Add Another Degree</button>

</div>
</div>
</div>
  </body>
  </html>