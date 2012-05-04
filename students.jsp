<%@page import="java.util.*, student.*" %>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css" type="text/css">    
</head>
    <%-- Initialization of students and nextPID --%>
    <% if(application.getAttribute("students")==null) 
         application.setAttribute("students", new LinkedHashMap<Integer, Student>());
       if(application.getAttribute("nextPID")==null)
         application.setAttribute("nextPID", 0);
    %>    

    <%-- -------- Retrieval code (already initialized students and nextPID) -------- --%>
    <% 
        // retrieves student data from application scope
        LinkedHashMap<Integer, Student> students = (LinkedHashMap<Integer, Student>)application.getAttribute("students");
    
        // retrieves the latest pid
        Integer nextPID = (Integer)(application.getAttribute("nextPID"));
    %>

    <% String action = request.getParameter("action"); %>

    <%-- -------- INSERT Code -------- --%>
    <%       
       // Check if an insertion is requested
       if (action != null && action.equals("insert")) {
                    
          // make new student to add to students map
       	Student newStudent = new Student();
                    
          // add the attributes from the request object to new student
           newStudent.setPID(Integer.parseInt(request.getParameter("pid")));
           newStudent.setFirstName(request.getParameter("first"));
           newStudent.setMiddleName(request.getParameter("middle"));
           newStudent.setLastName(request.getParameter("last"));
                    
          // add new student to the map
           students.put(nextPID,newStudent);
           nextPID++;
           application.setAttribute("nextPID", nextPID);
         }
     %>
            
            <%-- -------- UPDATE Code -------- --%>
            <%
                // Check if an update is requested
                if (action != null && action.equals("update")) {

                    // get student that needs to be updated
                    Student updateStudent = students.get(Integer.parseInt(request.getParameter("id")));
                    
                    // add the attributes from the request object to new student
                    updateStudent.setPID(Integer.parseInt(request.getParameter("pid")));
                    updateStudent.setFirstName(request.getParameter("first"));
                    updateStudent.setMiddleName(request.getParameter("middle"));
                    updateStudent.setLastName(request.getParameter("last"));

                }
            %>
            
            <%-- -------- DELETE Code -------- --%>
            <%
                // Check if a delete is requested
                if (action != null && action.equals("delete")) {
                    
                    // remove the student at the given id
                    students.remove(Integer.parseInt(request.getParameter("id")));
                }
            %>

<body>
        <div class="container" style="margin-top:20px">
    <div class="row-fluid">
        <div class="span12">
<table>
    <tr>
        <td valign="top">
            <%-- -------- Include menu HTML code -------- --%>
            <jsp:include page="menu.html" />
        </td>
        <td>

            <!-- Add an HTML table header row to format the results -->
            <table border="1">
            <tr>
                <th>ID</th>
                <th>PID</th>
                <th>First Name</th>
                <th>Middle Name</th>
                <th>Last Name</th>
            </tr>

            <tr>
                <form action="students.jsp" method="POST">
                    <input type="hidden" name="action" value="insert"/>
                    <th>&nbsp;</th>
                    <th><input value="" name="pid" size="10"/></th>
                    <th><input value="" name="first" size="15"/></th>
                    <th><input value="" name="middle" size="15"/></th>
                    <th><input value="" name="last" size="15"/></th>
                    <th><input type="submit" value="Insert"/></th>
                </form>
            </tr>

            <%-- -------- Iteration Code -------- --%>
            <%
                // loop through the student data
                Iterator it = students.entrySet().iterator();
                while(it.hasNext()){
                    // current element pair
                    Map.Entry pair = (Map.Entry)it.next();
            %>

            <tr>
                <form action="students.jsp" method="POST">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id" value="<%= pair.getKey() %>"/>

                <%-- Get the id --%>
                <td>
                    <%= pair.getKey() %>
                </td>

                <%-- Get the pid --%>
                <td>
                    <input value="<%= ((Student)pair.getValue()).getPID() %>" name="pid" size="15"/>
                </td>

                <%-- Get the first name --%>
                <td>
                    <input value="<%=((Student)pair.getValue()).getFirstName()%>" name="first" size="15"/>
                </td>

                <%-- Get the middle name --%>
                <td>
                    <input value="<%=((Student)pair.getValue()).getMiddleName()%>" name="middle" size="15"/>
                </td>

                <%-- Get the last name --%>
                <td>
                    <input value="<%=((Student)pair.getValue()).getLastName()%>" name="last" size="15"/>
                </td>

                <%-- Button --%>
                <td><input type="submit" value="Update"></td>
                </form>
                <form action="students.jsp" method="POST">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" value="<%=pair.getKey() %>" name="id"/>
                    <%-- Button --%>
                <td><input type="submit" value="Delete"/></td>
                </form>
            </tr>
            <%
                }
            %>
        </table>
        </td>
    </tr>
</table>
</div>
</div>
</div>
</body>

</html>

