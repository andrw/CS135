<%@page import="java.util.*, com.google.gson.JsonObject, com.google.gson.JsonArray" %>
<%@page import="java.sql.*, javax.naming.*, javax.sql.*" %>
<% 
int studid = -1;
try {
    studid = Integer.parseInt((String)(request.getParameter("studid")));
}
catch (NumberFormatException e) { }

JsonObject jsonRes = new JsonObject();

if (studid != -1) {
    Context initCtx = null;
    DataSource ds = null;
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        initCtx = new InitialContext();
        ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/ClassesDBPool");
        conn = ds.getConnection();
        pstmt = conn.prepareStatement("SELECT st.street, st.city, st.statecode, st.zipcode, st.areacode, st.phonenumber, sp.specialization, cit.country, res.country FROM students AS st LEFT JOIN countries AS cit ON st.citizenship = cit.c_id LEFT JOIN countries AS res ON st.residence = res.c_id LEFT JOIN specializations AS sp ON sp.s_id = st.specialization WHERE st.s_id=?");
        pstmt.setInt(1, studid);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            JsonArray degreesTab = new JsonArray();
            JsonObject degree;
            jsonRes.addProperty("status", "success");
            jsonRes.addProperty("id", studid);
            jsonRes.addProperty("street", rs.getString(1));
            jsonRes.addProperty("city", rs.getString(2));
            jsonRes.addProperty("statecode", rs.getString(3));
            jsonRes.addProperty("zipcode", rs.getString(4));
            jsonRes.addProperty("areacode", rs.getString(5));
            jsonRes.addProperty("phonenumber", rs.getString(6));
            jsonRes.addProperty("specialization", rs.getString(7));
            jsonRes.addProperty("citizenship", rs.getString(8));
            jsonRes.addProperty("residence", rs.getString(9));
            pstmt = conn.prepareStatement("SELECT u.country_state, u.university, m.major, d.month, d.year, d.gpa FROM degrees AS d LEFT JOIN universities AS u ON d.uni = u.u_id LEFT JOIN majors AS m ON d.major = m.m_id WHERE d.student=?");
            pstmt.setInt(1, studid);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                degree =  new JsonObject();
                degree.addProperty("ustate", rs.getString(1));
                degree.addProperty("uname", rs.getString(2));
                degree.addProperty("major", rs.getString(3));
                degree.addProperty("month", rs.getString(4));
                degree.addProperty("year", rs.getString(5));
                degree.addProperty("gpa", rs.getString(6));
                degreesTab.add(degree);
            }
            jsonRes.add("degrees", degreesTab);
        }
        else {
            jsonRes.addProperty("status", "noResult");
        }
    } catch (SQLException e) { jsonRes.addProperty("status", "SQLfailure " + e); }
    finally {
    // Release resources
    if (rs != null) { try { rs.close(); } catch (SQLException e) { } }
    if (pstmt != null) { try { pstmt.close(); } catch (SQLException e) { } }
    if (conn != null) { try { conn.close(); } catch (SQLException e) { } }
    } 
}
else {
    jsonRes.addProperty("status", "failure");
}
out.println(jsonRes);
%>
