<%@page import="java.sql.*, javax.naming.*, javax.sql.*, support.*, java.util.*, gradstudent.*" %>
<% 
String name = request.getParameter("uniName");
   Context initCtx = new InitialContext();
 DataSource ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/ClassesDBPool");
    Connection conn = ds.getConnection();
    conn.setAutoCommit(false);
    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM universities WHERE university = ?");
    pstmt.setString(1, name);

   ResultSet rs = pstmt.executeQuery();
if(rs.next()){
String temp = rs.getString(3); 
out.println("matched soemthing");
}
else {
out.println("no matches");
}
//    int studId = rs.getInt(1);
  //  Vector<Degree> allDegrees = student.getDegrees();

    //Universities univ = new Universities();   
    //Majors major = new Majors();   
    //Degree curDegree = null;



%>
