<!DOCTYPE html>
<%@page import="gradstudent.*" %>
<html>
<head>
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
    <link rel="stylesheet" href="css/bootstrap-responsive.css" type="text/css">   
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js">
    </script>
<script>
$(document).ready(function () {
$("#firstNameControl .help-inline").hide();
$("#midInitialControl .help-inline").hide();
$("#lastNameControl .help-inline").hide();

$("#nameFormSubmit").click(function (event) {
    var first = $("#firstName").val();
    var middle = $("#midInitial").val();
    var last = $("#lastName").val();
    var error = false;

if ( ! /^[a-zA-Z]+$/.test(first) ) {
    $("#firstNameControl").addClass("error");
    $("#firstNameControl .help-inline").show();
    error = true;
} else {
    $("#firstNameControl").removeClass("error");
    $("#firstNameControl .help-inline").hide();
}
if ( ! /^[a-zA-Z]?$/.test(middle) ) {
    $("#midInitialControl").addClass("error");
    $("#midInitialControl .help-inline").show();
    error = true;
} else {
    $("#midInitialControl").removeClass("error");
    $("#midInitialControl .help-inline").hide();
}
if ( ! /^[a-zA-Z]+$/.test(last) ) {
    $("#lastNameControl").addClass("error");
    $("#lastNameControl .help-inline").show();
    error = true;
} else {
    $("#lastNameControl").removeClass("error");
    $("#lastNameControl .help-inline").hide();
}
if (error) {
    event.preventDefault();
}
})
});
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
<section>
    <div class="container" style="margin-top:20px">
    <div class="row">
    <div class="span9">
            <h2>Graduate Student Application Form</h1>
            <p></p>
    <form action="citizenship.jsp" method="POST" class="form-horizontal">
        <fieldset>
            <div class="control-group" id="firstNameControl">
                <label class="control-label">First Name</label>
                <div class="controls">
                <input value="<%= firstName %>" type="text" class="span2" name="firstName" id="firstName"/>
                <span class="help-inline">
                    This field is mandatory and should only contain alphabetic characters
                </span>
                </div>
            </div>
            <div class="control-group" id="midInitialControl">
                <label class="control-label">Middle Initial</label>
                <div class="controls">
                <input value="<%= middleInitial %>" name="middleInitial"
                        class="span1" maxlength=1 id="midInitial"/>
                <span class="help-inline">
                    This field should only contain one alphabetic character
                </span>
                </div>
            </div>
            <div class="control-group" id="lastNameControl">
                <label class="control-label">Last Name</label>
                <div class="controls">
                <input value="<%= lastName %>" name="lastName" class="span2" id="lastName"/>
                <span class="help-inline">
                    This field is mandatory and should only contain alphabetic characters
                </span>
                </div>
            </div>
            <div class="form-actions">
            <button type="submit" class="btn" id="nameFormSubmit">Submit</button>
            </div>
        </fieldset>
   </form>

</div>
    </div>
    </div>
</section>
</body>
</html>
