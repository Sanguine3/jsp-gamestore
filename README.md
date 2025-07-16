# JSP Game Store

A Java web application for an online game store built using JSP, Servlets, and Maven.

## Features

*   User authentication (login/logout)
*   Product catalog browsing
*   Shopping cart functionality
*   Administrator panel for product management
*   Secure password handling
*   Responsive design using Bootstrap

## Tech Stack

*   **Backend:** Java 11, Jakarta Servlets 5.0, JSP 3.0
*   **Frontend:** HTML, CSS, JavaScript, Bootstrap 5.3.2 (via WebJars)
*   **Database:** PostgreSQL
*   **Build Tool:** Apache Maven
*   **Server:** Apache Tomcat 10.x

## Project Structure

```
.
├── src/java/           # Java source files (Servlets, DAL, Models)
├── web/                # Web resources (JSP, CSS, static files)
│   ├── META-INF/
│   │   └── context.xml # Tomcat context configuration
│   ├── WEB-INF/
│   │   └── web.xml     # Deployment descriptor
│   ├── common/         # Reusable JSP fragments (header, footer)
│   ├── css/            # Stylesheets
│   └── error/          # Error pages (404, 500)
├── GameStore_postgres.sql # Database schema and initial data
├── pom.xml             # Maven project configuration
└── README.md
```

## Setup and Deployment

### Prerequisites

*   JDK 11
*   Apache Maven 3.6+
*   Apache Tomcat 10.x
*   PostgreSQL

### 1. Database Setup

1.  Ensure PostgreSQL is installed and running.
2.  Create a new database named `GameStore`.
3.  Execute the `GameStore_postgres.sql` script to create the necessary tables and seed initial data.

### 2. Configuration

This project is configured to use a database connection pool defined in `web/META-INF/context.xml`. The connection pool is automatically configured when you deploy the application.

#### Database Connection Pool

The database connection pool is pre-configured in `web/META-INF/context.xml` with the following default settings:

- **Database:** `GameStore` on `localhost:5432`
- **Username:** `postgres`
- **Password:** `postgres`

If your PostgreSQL setup differs from these defaults, edit the `web/META-INF/context.xml` file and update the `username`, `password`, and `url` attributes in the `<Resource>` element.

#### Fallback Direct Connection

If the connection pool is not available, the application will fall back to a direct database connection. The credentials for this fallback connection are located in `src/java/dal/DBContext.java`.

### 3. Build the Project

Use Maven to build the project. This will compile the source code and package it into a WAR file.

```sh
mvn clean package
```

### 4. Deploy to Tomcat

1.  A WAR file named `myproject.war` will be created in the `target/` directory after running `mvn clean package`.
2.  Copy this `myproject.war` file to the `webapps/` directory of your Tomcat installation.
3.  Start the Tomcat server (if not already running).
4.  Tomcat will automatically deploy the WAR file.
5.  The application will be accessible at `http://localhost:8080/myproject`.

**Note:** The context root `/myproject` is defined in `web/META-INF/context.xml`, so the application will always be accessible at this URL regardless of the WAR file name.

## Security

This application uses Servlet-container managed security configured in `web.xml`.

*   **Authentication Method:** Form-based authentication.
*   **Security Roles:** Defines access control for different parts of the application (e.g., user-specific pages, admin dashboard).

## Default Admin Login

*   **Username:** `admin@gamestore.com`
*   **Password:** `admin123`
