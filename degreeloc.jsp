<%@page import="support.*, java.util.*, gradstudent.*" %>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css" type="text/css">   
</head>
    <div class="container" style="margin-top:20px">
    <div class="row-fluid">
        <div class="span12">
<body>
  <% 
  // grab old info
  GradStudent student = (GradStudent) application.getAttribute("student");

String action = request.getParameter("action");

// set new info
  if(action.equals("address")) {
  student.setAddress(request.getParameter("streetNumber"), request.getParameter("streetName"), request.getParameter("city"), request.getParameter("stateCode"), request.getParameter("zipcode"), request.getParameter("areaCode"), request.getParameter("phoneNumber"));
}
else if(action.equals("anotherDegree")) {
  // SUBMIT/UPDATE STUDENT INFO WITH DEGREE
  student.newDegree((String)application.getAttribute("loc"), (String)application.getAttribute("uni"), (String)application.getAttribute("major"), (String)application.getAttribute("month"), (String)application.getAttribute("year"), (String)application.getAttribute("gpa"));
}
else {
  out.println("what the heck.");  
}
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

<%-- gather new info --%>
<%
support s = new support();   
Vector universities = s.getUniversities(config.getServletContext().getRealPath("universities.txt"));
%>

<table border =1>
  <tr>
    <%
    for (int i=0; i<universities.size(); i++){
      //each entry in the universities vector is a tuple with the first entry being the country/state
      //and the second entry being a vector of the universities as String's
      Vector tuple = (Vector)universities.get(i);
      String state = (String)tuple.get(0);
      if(i%3 == 0 && 3!=0) {
      out.println("</tr><tr>");
    }

    %>

    <td><a href="degreeuni.jsp?loc=<%= state %>"><%= state %></td>

    <%

      //out.println("<br>"+state+"<br>");    
    }
    
    %>
    </div>
</div>
</div>
  </body>
  </html>