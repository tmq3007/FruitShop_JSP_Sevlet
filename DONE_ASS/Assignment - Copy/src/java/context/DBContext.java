package context;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    
    /* Database connection details */
    private final String serverName = "localhost";
    private final String dbName = "FruitShop";
    private final String portNumber = "1433";
    private final String instance = ""; 
    private final String userID = "sa";
    private final String password = "123";
    
    
    public Connection getConnection() throws SQLException, ClassNotFoundException {
        String url;
        if (instance == null || instance.trim().isEmpty()) {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + dbName;
        } else {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance + ";databaseName=" + dbName;
        }
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }
    
    
    public static void main(String[] args) {
        try {
             System.out.println(new DBContext().getConnection());
        } catch (Exception e) {
        }
    }
}
