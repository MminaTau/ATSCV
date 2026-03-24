package com.example.atscv.util;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() throws SQLException {
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("jdbc/ATSCVDB");
            return ds.getConnection();
        } catch (NamingException e) {
            throw new SQLException("JNDI lookup failed: " + e.getMessage(), e);
        }
    }
}