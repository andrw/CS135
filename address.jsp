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
GradStudent student = (GradStudent) application.getAttribute("student");
student.setResidence(request.getParameter("residence"));

if(student.getResidence().equals("United States")) {
student.setForeign(false);
}
else {
  student.setForeign(true);
}

application.setAttribute("student", student);
%>


<h1>Welcome <%= student.getFirstName() %> <%= student.getLastName() %>!<br></h1>
Citizenship: <%= student.getCitizenship() %><br>
Residence: <%= student.getResidence() %><br>

<form action="degreeloc.jsp" method="POST">
<input type="hidden" name="action" value="address">
  Street Number: <input value="" name ="streetNumber"><br>
  Street Name: <input value="" name="streetName"><br>
  City: <input value="" name="city"><br>

  <%-- extremely hacky way of getting determining country or not --%>
  <% if(student.getResidence().equals("United States")) { %>
  State: 
<% } 
  else {
  %>
  Country Telephone Code:
  <%
}
%>
<input value="" name="stateCode"><br>

  Zipcode: <input value="" name="zipcode"><br>
  Areacode: <input value="" name="areaCode"><br>
  Phone Number: <input value="" name="phoneNumber"><br>
  <input type="submit" value="submit">
  </form>
  
</div>
</div>
</div>

</body>
</html>