# JSP Game Store

A Java web application for an online game store built using Jakarta EE (formerly Java EE) technologies.

## Updated Dependencies

The project has been modernized with the following updates:

- Java 11 (upgraded from Java 8)
- PostgreSQL JDBC Driver: Updated to 42.7.1
- Google Gson: Updated to 2.10.1
- Added Bootstrap 5.3.2 via WebJars
- Standardized on Maven for build management
- Configured for Tomcat 10 (Jakarta EE)
- Implemented Servlet/Tomcat built-in security

## Project Structure

- `src/java`: Java source files (controllers, data access layer, models)
- `web`: Web resources (JSP pages, CSS, static files)

## Setup Requirements

1. JDK 11
2. Maven 3.6+
3. Apache Tomcat 10.x
4. PostgreSQL database

## Database Setup

1. Install PostgreSQL if not already installed
2. Create a database named 'GameStore'
3. Execute the SQL script in `GameStore_postgres.sql` to set up the schema and initial data

## Configuration

Database connection parameters can be found in `src/java/dal/DBContext.java`. Modify these settings to match your PostgreSQL configuration:

```java
String url = "jdbc:postgresql://localhost:5432/GameStore";
String username = "postgres";
String password = "postgres"; // Change this to your PostgreSQL password
```

## Building the Application

### Using Maven (Recommended)

1. Install Maven if not already installed
2. From the project root, run:
```
mvn clean package
```

### Using NetBeans with Ant (Legacy)

If you still want to use NetBeans with the Ant build system:

1. Open the project in NetBeans
2. Use the built-in "Clean and Build" option

## Deployment

1. Copy the generated WAR file from `target/myproject.war` to your Tomcat's webapps directory
2. Start Tomcat
3. Access the application at http://localhost:8080/myproject

## Security Configuration

The application now uses Tomcat's built-in security with form-based authentication:

- Regular users can access account pages and shopping cart
- Administrators can also access product management pages
- Security roles are configured in `web.xml`

## Default Login

- Username: huyvqhe163784
- Password: deptrai2806
- Admin Level: 1 (Administrator) 