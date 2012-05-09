package support;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class Majors {
    private Vector mv = null;
    private DataSource ds;

    public Majors() {
        Context initCtx;
        try {
                initCtx = new InitialContext();
                ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/ClassesDBPool");
        }
        catch (NamingException e) {
        }
    }

    public String getMajor(int id) {
        Connection conn = null;
        PreparedStatement pstmt;
        ResultSet rs;
        try {
            conn = ds.getConnection();
            pstmt = conn.prepareStatement("SELECT major FROM majors WHERE m_id=?");
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next())
                return (rs.getString(1));
        }
        catch (SQLException e) {
            return (null);
        }
        finally {
            try { if (conn != null) { conn.close(); } }
            catch (SQLException e) { }
        }
        return (null);
    }

    public int getMajorsNb() {
        return (getMajorsVector().size());
    }

    public Vector getMajorsVector() {
        if (mv == null) {
            Connection conn = null;
            PreparedStatement pstmt;
            ResultSet rs;
            try {
                conn = ds.getConnection();
                pstmt = conn.prepareStatement("SELECT major FROM majors ORDER BY m_id ASC");
                rs = pstmt.executeQuery();
                mv = new Vector();
                while (rs.next())
                    mv.add(rs.getString(1));
            }
            catch (SQLException e) {
                return (null);
            }
            finally {
                try { if (conn != null) { conn.close(); } }
                catch (SQLException e) { }
            }
        }
        return (mv);
    }
}
       
