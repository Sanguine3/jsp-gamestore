<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Page Not Found</title>
        <jsp:include page="../common/header.jsp" />
    </head>
    <body style="background-color: #0d0c0c">
        <div class="container mt-5 text-center">
            <div class="card p-5 bg-dark text-light">
                <h1 class="display-1">404</h1>
                <h2>Page Not Found</h2>
                <p class="lead">The page you are looking for does not exist.</p>
                <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-light mt-3">Return to Home</a>
            </div>
        </div>
        <jsp:include page="../common/scripts.jsp" />
    </body>
</html> 