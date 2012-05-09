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
int residence = 0;
try {
    residence = Integer.parseInt((String)(request.getParameter("residence")));
}
catch (NumberFormatException e) { }

GradStudent student = (GradStudent)session.getAttribute("student");

if (residence == 0 && student != null)
    residence = student.getResidence();

if (residence == 0 || student == null) { %>
<p><strong>An error occured.</strong>You should consider restarting your application procedure. <a href="./">Restart now.</a></p>
<% 
}
else {
student.setResidence(residence);

Countries c = new Countries();
boolean domestic = false;
if (c.getCountry(residence).equals("United States")) {
    domestic = true;
}
%>
    <div class="row">
    <div class="span6">
    <h3>Your personnal address</h3>
    <p></p>
    <form action="degreeloc.jsp" method="POST" class="form-horizontal">
    <fieldset>
        <input type="hidden" name="action" value="address">
        <div class="control-group">
            <label class="control-label" for="input01">Street:</label>
            <div class="controls">
            <input type="text" value="" name="streetName" class="span3" id="input01">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="input02">City:</label>
            <div class="controls">
            <input type="text" value="" name="city" class="span2" id="input02">
            </div>
        </div>
    <% if (domestic) { %>
        <div class="control-group">
            <label class="control-label" for="input03">State:</label>
            <div class="controls">
            <input type="text" value="" name="stateCode" class="span1" id="input03" maxlength=2>
            </div>
        </div>
    <% } %>
        <div class="control-group">
            <label class="control-label" for="input04">Zipcode:</label>
            <div class="controls">
            <input type="text" value="" name="zipcode" class="span1" id="input04" maxlength=5>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="input05">Area code:</label>
            <div class="controls">
            <input type="text" value="" name="areaCode" class="span1" id="input05" maxlength=5>
            </div>
        </div>
    <% if (!domestic) { %>
        <div class="control-group">
            <label class="control-label" for="input03">Country Telephone Code:</label>
            <div class="controls">
            <input type="text" value="" name="countryCode" class="span1" id="input03" maxlength=4>
            </div>
        </div>
    <% } %>
        <div class="control-group">
            <label class="control-label" for="input06">Phone Number:</label>
            <div class="controls">
            <input type="text" value="" name="phoneNumber" class="span2" id="input06" maxlength=14>
            </div>
        </div>
          <div class="form-actions">
            <button type="submit" class="btn btn-primary" value="submit">Save changes</button>
          </div>
        </fieldset>
      </form>
    </div>
    <div class="span3">
    <h3> Your informations </h3>
    <p></p>
    <p>Name: <%= student.getFirstName() %>  <%= student.getMiddleInitial() %> <%= student.getLastName() %></p>
    <p>Citizen of: <%= c.getCountry(student.getCitizenship()) %></p>
    <p>Resident of: <%= c.getCountry(residence) %></p>
    </div>
    </div>
<% } %>
    </div>
</section>
</body>
</html>
