<%@page import="support.*, java.util.*" %>
<% 
String uniName = request.getParameter("uniName");
int uniID = -1;
int loc = -1;
try {
    loc = Integer.parseInt((String)(request.getParameter("loc")));
}
catch (NumberFormatException e) { }

if (loc != -1 && uniName != null) {
    Universities univ = new Universities();   
    uniID = univ.getUnivId(loc, uniName);
}
out.println(uniID);
%>
