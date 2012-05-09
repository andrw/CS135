<!DOCTYPE html>
<%@page import="java.sql.*, javax.naming.*, javax.sql.*, support.*, java.util.*, gradstudent.*" %>
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

if (student == null || student.getAddress() == null || student.getSpecialization() == 0) { %>
<p><strong>An error occured.</strong> You should consider restarting your application procedure. <a href="./">Restart now.</a></p>
<% 
}
else {
if (student.getStudId() == -1) {
Context initCtx = null;
DataSource ds = null;
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    initCtx = new InitialContext();
    ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/ClassesDBPool");
    conn = ds.getConnection();
    conn.setAutoCommit(false);
    pstmt = conn.prepareStatement("INSERT INTO students (first_name, middle_initial, last_name, citizenship, residence, street, city, stateCode, zipcode, areaCode, phoneNumber, specialization) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) returning s_id"); 
    pstmt.setString(1, student.getFirstName());
    pstmt.setString(2, student.getMiddleInitial());
    pstmt.setString(3, student.getLastName());
    pstmt.setInt(4, student.getCitizenship());
    pstmt.setInt(5, student.getResidence());
    pstmt.setString(6, student.getAddress().getStreet());
    pstmt.setString(7, student.getAddress().getCity());
    pstmt.setString(8, student.getAddress().getStateCode());
    pstmt.setString(9, student.getAddress().getZipcode());
    pstmt.setString(10, student.getAddress().getAreaCode());
    pstmt.setString(11, student.getAddress().getPhoneNumber());
    pstmt.setInt(12, student.getSpecialization());
    rs = pstmt.executeQuery();

    rs.next();
    int studId = rs.getInt(1);
    Vector<Degree> allDegrees = student.getDegrees();

    Universities univ = new Universities();   
    Majors major = new Majors();   
    Degree curDegree = null;
    
    for (int i = 0; i < allDegrees.size(); i++) {
        curDegree = allDegrees.get(i);

        // Insert the university in the database if it's a custom one
        if (curDegree.getUni() == -1) {
            pstmt = conn.prepareStatement("SELECT u_id FROM universities WHERE country_state=? AND university=?");
            pstmt.setString(1, univ.getUnivState(curDegree.getLoc()));
            pstmt.setString(2, curDegree.getCustomUni());
            rs = pstmt.executeQuery();
            if (rs.next()) {
                curDegree.setUni(rs.getInt(1));
            }
            else {
                pstmt = conn.prepareStatement("INSERT INTO universities (country_state, university) VALUES (?, ?) RETURNING u_id");
                pstmt.setString(1, univ.getUnivState(curDegree.getLoc()));
                pstmt.setString(2, curDegree.getCustomUni());
                rs = pstmt.executeQuery();
                rs.next();
                curDegree.setUni(rs.getInt(1));
            }
        }

        // Insert the major in the database if it's a custom one
        if (curDegree.getMajor() == -1) {
            pstmt = conn.prepareStatement("SELECT m_id FROM majors WHERE major=?");
            pstmt.setString(1, curDegree.getCustomMajor());
            rs = pstmt.executeQuery();
            if (rs.next()) {
                curDegree.setMajor(rs.getInt(1));
            }
            else {
                pstmt = conn.prepareStatement("INSERT INTO majors (major) VALUES (?) RETURNING m_id");
                pstmt.setString(1, curDegree.getCustomMajor());
                rs = pstmt.executeQuery();
                rs.next();
                major.getMajorsVector().add(curDegree.getCustomMajor());
                curDegree.setMajor(rs.getInt(1));
            }
        }

        pstmt = conn.prepareStatement("INSERT INTO degrees (student, uni, major, month, year, gpa) VALUES (?, ?, ?, ?, ?, ?)");
        pstmt.setInt(1, studId);
        pstmt.setInt(2, allDegrees.get(i).getUni());
        pstmt.setInt(3, allDegrees.get(i).getMajor());
        pstmt.setString(4, allDegrees.get(i).getMonth());
        pstmt.setString(5, allDegrees.get(i).getYear());
        pstmt.setString(6, allDegrees.get(i).getGPA());
        pstmt.executeUpdate();
        conn.commit();
    }
    conn.commit();
    student.setStudId(studId);
    conn.setAutoCommit(true);
} catch (SQLException e) { %>
<p><strong>An SQL error occured "<%= e %>".</strong>
You should consider restarting your application procedure. <a href="./">Restart now.</a></p>
<% }
finally {
    // Release resources in a finally block in reverse-order of
    // their creation
    if (rs != null) {
        try {
            rs.close();
        } catch (SQLException e) { } // Ignore
        rs = null;
    }
    if (pstmt != null) {
        try {
            pstmt.close();
        } catch (SQLException e) { } // Ignore
        pstmt = null;
    }
    if (conn != null) {
        try {
            conn.close();
        } catch (SQLException e) { } // Ignore
        conn = null;
    }
}
}
if (student.getStudId() != -1)
{
%>
    <div class="span9">
    <h2>Your application has ben recorded !</h2>
    <br/>
    <p>Your ID is <strong><%= student.getStudId() %></strong></p>
    </div>
<%} } %>
    </div>
</section>
</body>
</html>
