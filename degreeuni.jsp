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
application.setAttribute("loc", request.getParameter("loc"));

  %>

  <%-- display old info --%>
  <h1>Welcome <%= student.getFirstName() %> <%= student.getLastName() %>!<br></h1>
  citizenship: <%= student.getCitizenship() %><br>
  residence: <%= student.getResidence() %><br>
  address: <%= student.getAddress().getStreetNumber() %> <%= student.getAddress().getStreetName() %> <Br>
  <%= student.getAddress().getCity() %>, <%= student.getAddress().getZipcode() %><br>
  (<%= student.getAddress().getAreaCode() %>) <%= student.getAddress().getPhoneNumber() %><br>
Your chosen location: <%= application.getAttribute("loc") %><Br>

  <%-- gather new info --%>
  <%
  support s = new support();   
  Vector universities = s.getUniversities(config.getServletContext().getRealPath("universities.txt"));
  %>


    <%
    for (int i=0; i<universities.size(); i++){
      //each entry in the universities vector is a tuple with the first entry being the country/state
      //and the second entry being a vector of the universities as String's
      Vector tuple = (Vector)universities.get(i);
      String state = (String)tuple.get(0);
      if(state.equals(application.getAttribute("loc"))) 
      {
      // does this if location = selected location
      Vector u = (Vector)tuple.get(1);
      for(int j=0; j<u.size(); j++){ 
      %>
      <a href="degreeDiscipline.jsp?uni=<%= u.get(j)%>"><%= u.get(j) %></a><br>
    <%}
    }
     
    }
  %>
</div>
</div>
</div>
  </body>
  </html>