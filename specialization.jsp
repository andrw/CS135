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

  // SUBMIT/UPDATE STUDENT INFO WITH DEGREE
  student.newDegree((String)application.getAttribute("loc"), (String)application.getAttribute("uni"), (String)application.getAttribute("major"), (String)application.getAttribute("month"), (String)application.getAttribute("year"), (String)application.getAttribute("gpa"));
// record new info
  application.setAttribute("student", student);
  %>

<%-- display old info --%>
<h1>Welcome <%= student.getFirstName() %> <%= student.getLastName() %>!<br></h1>
citizenship: <%= student.getCitizenship() %><br>
residence: <%= student.getResidence() %><br>
address: <%= student.getAddress().getStreetNumber() %> <%= student.getAddress().getStreetName() %> <Br>
<%= student.getAddress().getCity() %>, <%= student.getAddress().getStateCode() %> <%= student.getAddress().getZipcode() %><br>
(<%= student.getAddress().getAreaCode() %>) <%= student.getAddress().getPhoneNumber() %><br>


<%-- display all degree info --%>
<% 
for(int i=0; i<student.getDegrees().size(); i++) {
%>
  Degree # <%= i %> <br>
  Degree Location: <%= student.getDegrees().get(i).getLoc() %><Br>
  University: <%= student.getDegrees().get(i).getUni() %><br><br>
<% 
}
%>




<%-- gather new info --%>
<%
support s = new support();   
Vector specializations = s.getSpecializations(config.getServletContext().getRealPath("specializations.txt"));
%>
 <form action="verification.jsp" method="POST">
  <select name="specialization">
 <%
    for (int i=0; i<specializations.size(); i++){
      //each entry in the universities vector is a tuple with the first entry being the country/state
      //and the second entry being a vector of the universities as String's

      %>

      <option value="<%= specializations.get(i) %>"><%= specializations.get(i) %></option>

    <%
    }    
    %>
    <input type="submit" value="submit">
  </form>
  </div>
</div>
</div>
  </body>
  </html>