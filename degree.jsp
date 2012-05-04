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
  student.setAddress(request.getParameter("streetNumber"), request.getParameter("streetName"), request.getParameter("city"), request.getParameter("zipcode"), request.getParameter("areaCode"), request.getParameter("phoneNumber"));

// record new info
  application.setAttribute("student", student);
  %>

  <%-- display old info --%>
  <h1>Welcome <%= student.getFirstName() %> <%= student.getLastName() %>!<br></h1>
  citizenship: <%= student.getCitizenship() %><br>
  residence: <%= student.getResidence() %><br>
  address: <%= student.getAddress().getStreetNumber() %> <%= student.getAddress().getStreetName() %> <Br>
  <%= student.getAddress().getCity() %>, <%= student.getAddress().getZipcode() %><br>
  (<%= student.getAddress().getAreaCode() %>) <%= student.getAddress().getPhoneNumber() %><br>

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
      out.println("<br>"+state+"<br>");    
      Vector u = (Vector)tuple.get(1);
      for(int j=0; j<u.size(); j++){%>
      <%=u.get(j)%><br>
      <%}
    } 
    %>
    </div>
</div>
</div>
  </body>
  </html>