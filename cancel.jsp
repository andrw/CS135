<!DOCTYPE html>
<%@page import="support.*, java.util.*, gradstudent.*" %>
<% session.removeAttribute("student"); %>
<html>
<head>
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
    <link rel="stylesheet" href="css/bootstrap-responsive.css" type="text/css">    
</head>
<body>
<section>
    <div class="container" style="margin-top:20px">
    <p><strong>Your application has been cancelled.</strong></p>
    <p>You can restart the application procedure.</p>
    <p><a href="./">Restart now.</a></p>
    </div>
</section>
</body>
</html>
