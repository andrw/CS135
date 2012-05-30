<!DOCTYPE html>
<%@page import="gradstudent.*" %>
<html>
<head>
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
    <link rel="stylesheet" href="css/bootstrap-responsive.css" type="text/css">   
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js">
    </script>
</head>
<body>
<%
GradStudent student = (GradStudent)session.getAttribute("student");
String firstName = "";
String middleInitial = "";
String lastName = "";
if (student != null) {
    firstName = student.getFirstName();
    middleInitial = student.getMiddleInitial();
    lastName = student.getLastName();
}
%>
    <script>
      function check() {

var first = $("input[name=firstName]").val();
var middle = $("input[name=middleInitial]").val();
var last = $("input[name=lastName]").val();
      

var exp1= /^[a-zA-Z]+$/.test(first);
var exp2= /^[a-zA-Z]*$/.test(middle);
var exp3 = /^[a-zA-Z]+$/.test(last);

var params = new Array();

if(exp1 && exp2 && exp3) {
alert("submitting!");
$("#form").submit();
//alert("worked");
/*
params.push("firstName"+"="+first);
params.push("middleInitial"+"="+middle);
params.push("lastName"+"="+last);
$.ajax({
type: 'POST', 
url: "citizenship.jsp?",
beforeSend:function() {
alert("sending ajax request...");
},
data: 'firstName=Andrew',
success: function(response) {
alert(response);
}
});
*/
}
else {
alert("Please use letters only!");
}
      }
</script>
<section>
    <div class="container" style="margin-top:20px">
    <div class="row">
    <div class="span6">
            <h1>Graduate Student Application Form</h1>
            <p></p>
     <form action="citizenship.jsp" method="POST" class="well" id="form">
        <label>First Name</label>
        <input value="<%= firstName %>" type="text" class="span2" name="firstName"/>
        <label>Middle Initial</label>
        <input value="<%= middleInitial %>" name="middleInitial" class="span1" maxlength=1 />
        <label>Last Name</label>
        <input value="<%= lastName %>" name="lastName" class="span2"/>
        <br>
        <!-- <input type="submit" value="Submit" /> -->
   </form>
        <button onclick="check()">hi</button>

</div>
    </div>
    </div>
</section>
</body>
</html>
