<!DOCTYPE html>
<%@page import="support.*, java.util.*, gradstudent.*" %>
<html>
<head>
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
    <link rel="stylesheet" href="css/bootstrap-responsive.css" type="text/css">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">
    </script>
</head>
<body>
<section>
    <div class="container" style="margin-top:20px">

<% 
GradStudent student = (GradStudent)session.getAttribute("student");
int loc = -1;
try {
    loc = Integer.parseInt((String)(request.getParameter("loc")));
}
catch (NumberFormatException e) { }
Degree curDegree = null;

if (loc == -1 && student != null) {
    try {
        curDegree = student.getLastDegree();
        loc = curDegree.getLoc();
    }
    catch (NoSuchElementException e) { }
}

if (student == null || loc == -1 || student.getAddress() == null)
 { %>
<p><strong>An error occured.</strong>You should consider restarting your application procedure. <a href="./">Restart now.</a></p>
<% 
}
else {

if (curDegree == null) {
    curDegree = new Degree();
    curDegree.setLoc(loc);
    student.newDegree(curDegree);
}
Countries c = new Countries();
Universities univ = new Universities();   
Vector univByState = univ.getUnivByState(loc);
%>
<script>
$(document).ready(function () {
$("#uniName").change(function (event) {
    var uniName = $('#uniName').val();

    $.get("getuniid.jsp?loc=<%= loc %>&uniName=" + uniName, function (result) {
        $('td.well').removeClass('well');
        if (Number(result) != -1) {
            window.location.hash = '#uni' + result.trim();
            $('#uni' + result.trim()).focus();
            $('#uni' + result.trim()).parent().addClass('well');
        }
          });
        
      })
});
</script>

    <div class="row">
    <div class="span6">
    <p>Choose the university where you got your degree. If you don't find it in the list, add it with the form below.</p>
    <form action="degreeDiscipline.jsp" method="POST" class="well form-inline">
        <input type="text" id="uniName" name="addUni" class="span3" placeholder="Your university here">
        <button type="submit" class="btn">Add</button>
    </form>

    <table class="table table-bordered">
      <tr>
    <%
    Object uniID;
    for (int i = 0; i < univByState.size(); i++){
    if (i % 3 == 0 && i != 0) { %>
        </tr><tr>
    <% } %>
    <td>
        <% uniID = ((Vector)univByState.get(i)).get(0); %>
        <a id="uni<%= uniID %>" href="degreeDiscipline.jsp?uni=<%= uniID %>">
        <%= ((Vector)univByState.get(i)).get(1) %>
        </a>
    </td>
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
     <%= student.getAddress().getStreet() %><br/>
    <%= student.getAddress().getCity() %>, <%= student.getAddress().getStateCode() %> <%= student.getAddress().getZipcode() %><br/>
    <%= student.getAddress().getCountryCode() %> (<%= student.getAddress().getAreaCode() %>) <%= student.getAddress().getPhoneNumber() %><br>
    </address>
    <p>You obtained your last degree in : <%= univ.getUnivState(loc) %></p>
    </div>
    </div>
<% } %>
    </div>
</section>
</body>
</html>
