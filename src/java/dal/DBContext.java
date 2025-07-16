
package dal;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

/**
 * Database context class for managing database connections
 * Implements AutoCloseable for better resource management
 */
public class DBContext implements AutoCloseable {
    protected Connection connection;
    private static final Logger LOGGER = Logger.getLogger(DBContext.class.getName());
    private static final String DB_POOL_NAME = "jdbc/gameStoreDB";
    
    // Default database properties - should be moved to a properties file in production
    private static final String DEFAULT_URL = "jdbc:postgresql://localhost:5432/gamestore";
    private static final String DEFAULT_USER = "postgres";
    private static final String DEFAULT_PASSWORD = "postgres";
    
    /**
     * Constructor - establishes a database connection
     * First tries to use connection pool, falls back to direct connection if needed
     */
    public DBContext() {
        try {
            // Get connection from the connection pool defined in context.xml
            Context initContext = new InitialContext();
            Context envContext = (Context) initContext.lookup("java:/comp/env");
            DataSource ds = (DataSource) envContext.lookup(DB_POOL_NAME);
            connection = ds.getConnection();
            
            if (connection != null) {
                LOGGER.log(Level.INFO, "Database connection established successfully from connection pool");
            }
        } catch (NamingException ex) {
            LOGGER.log(Level.WARNING, "Error finding datasource: {0}", ex.getMessage());
            fallbackDirectConnection();
        } catch (SQLException ex) {
            LOGGER.log(Level.WARNING, "Database connection error from pool: {0}", ex.getMessage());
            fallbackDirectConnection();
        }
    }
    
    /**
     * Fallback to direct connection if pool fails
     * Uses default properties or loads from configuration
     */
    private void fallbackDirectConnection() {
        try {
            // Try to load properties from configuration
            Properties dbProps = loadDatabaseProperties();
            String url = dbProps.getProperty("db.url", DEFAULT_URL);
            String username = dbProps.getProperty("db.username", DEFAULT_USER);
            String password = dbProps.getProperty("db.password", DEFAULT_PASSWORD);
            
            LOGGER.log(Level.WARNING, "Falling back to direct database connection: {0}", url);
            
            // Register the driver explicitly
            try {
                Class.forName("org.postgresql.Driver");
            } catch (ClassNotFoundException e) {
                LOGGER.log(Level.SEVERE, "PostgreSQL JDBC Driver not found", e);
            }
            
            connection = java.sql.DriverManager.getConnection(url, username, password);
            
            if (connection != null) {
                LOGGER.log(Level.INFO, "Direct database connection established successfully");
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Fallback connection also failed: {0}", ex.getMessage());
        }
    }
    
    /**
     * Load database properties from configuration
     * In a real application, this would load from a properties file
     */
    private Properties loadDatabaseProperties() {
        Properties props = new Properties();
        
        // In a production environment, you would load these from a file
        // For example:
        // try (InputStream input = getClass().getClassLoader().getResourceAsStream("database.properties")) {
        //     if (input != null) {
        //         props.load(input);
        //     }
        // } catch (IOException ex) {
        //     LOGGER.log(Level.SEVERE, "Could not load database properties", ex);
        // }
        
        return props;
    }
    
    /**
     * Get the current connection
     * @return the database connection
     */
    public Connection getConnection() {
        return connection;
    }
    
    /**
     * Close connection when done
     * Implements AutoCloseable interface
     */
    @Override
    public void close() {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                    LOGGER.log(Level.FINE, "Database connection closed successfully");
                }
            } catch (SQLException ex) {
                LOGGER.log(Level.SEVERE, "Error closing connection", ex);
            }
        }
    }
}

