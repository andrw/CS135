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
String action = request.getParameter("action");
Address address = null;
if (student != null) {
    address = student.getAddress();
    if (action != null && action.equals("address")) {
        String streetName = request.getParameter("streetName");
        String city = request.getParameter("city");
        String stateCode = request.getParameter("stateCode");
        if (stateCode == null)
            stateCode = "";
        String countryCode = request.getParameter("countryCode");
        if (countryCode == null)
            countryCode = "001";
        String zipcode = request.getParameter("zipcode");
        String areaCode = request.getParameter("areaCode");
        String phoneNumber = request.getParameter("phoneNumber");
    
        if (streetName != null && city != null && zipcode != null && phoneNumber != null) {
            address = new Address(streetName, city, stateCode, zipcode, countryCode , areaCode, phoneNumber);
        }
    }
}

if (student == null || address == null)// || action != "anotherDegree")
 { %>
<p><strong>An error occured.</strong>You should consider restarting your application procedure. <a href="./">Restart now.</a></p>
<% 
}
else {
if (action != null && action.equals("address")) {
  student.setAddress(address);
}
Countries c = new Countries();
Universities univ = new Universities();   
%>
    <div class="row">
    <div class="span6">
    <p>Choose the location where you got your degree.</p>
    <table class="table table-bordered">
      <tr>
    <%
    for (int i = 0; i < univ.getUnivStatesNb(); i++){
    if (i % 3 == 0 && i != 0) { %>
        </tr><tr>
    <% } %>
    <td><a href="degreeuni.jsp?loc=<%= i %>"><%= univ.getUnivState(i) %></a></td>
    <% } %>
    </table>
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
     <%= address.getStreet() %><br/>
    <%= address.getCity() %>, <%= address.getStateCode() %> <%= address.getZipcode() %><br/>
    <%= address.getCountryCode() %> (<%= address.getAreaCode() %>) <%= address.getPhoneNumber() %><br>
    </address>
    </div>
    </div>
<% } %>
    </div>
</section>
</body>
</html>
