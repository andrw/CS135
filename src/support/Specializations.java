package support;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class Specializations {
    private Vector mv = null;

    public Specializations() {
    }

    public String getSpecialization(int id) {
        return ((String)getSpecializationsVector().get(id - 1));
    }

    public int getSpecializationsNb() {
        return (getSpecializationsVector().size());
    }

    public Vector getSpecializationsVector() {
        if (mv == null) {
            Context initCtx;
            DataSource ds;
            Connection conn = null;
            PreparedStatement pstmt;
            ResultSet rs;
            try {
                initCtx = new InitialContext();
                ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/ClassesDBPool");
                try {
                    conn = ds.getConnection();
                    pstmt = conn.prepareStatement("SELECT specialization FROM specializations ORDER BY s_id ASC");
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
            catch (NamingException e) {
                return (null);
            }
        }
        return (mv);
    }
}
       
