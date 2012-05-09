package support;

import java.util.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class Countries {
    private Vector cv = null;

    public Countries() {
    }

    public String getCountry(int id) {
        return ((String)getCountriesVector().get(id - 1));
    }

    public int getCountriesNb() {
        return (getCountriesVector().size());
    }

    public Vector getCountriesVector() {
        if (cv == null) {
            Context initCtx;
            DataSource ds;
            Connection conn = null;
            PreparedStatement pstmt;
            ResultSet rs;
            try {
                initCtx = new InitialContext();
                ds = (DataSource)initCtx.lookup("java:comp/env/jdbc/ClassesDBPool");
                conn = ds.getConnection();
                pstmt = conn.prepareStatement("SELECT country FROM countries ORDER BY c_id ASC");
                rs = pstmt.executeQuery();
                cv = new Vector();
                while (rs.next())
                    cv.add(rs.getString(1));
            }
            catch (SQLException e) {
                return (null);
            }
            catch (NamingException e) {
                return (null);
            }
            finally {
                try { if (conn != null) { conn.close(); } }
                catch (SQLException e) { }
            }
        }
        return (cv);
    }
}
       
