
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Game Store</title>
        <jsp:include page="common/header.jsp" />
    </head>
    <body>
        <header>
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-4">
                        <h1><a href="${pageContext.request.contextPath}/home" style="text-decoration: none; color:black">GameShop™</a></h1>
                    </div>
                    <div class="col-md-4">
                        <form action="${pageContext.request.contextPath}/search" class="d-flex">
                            <input name="keyword" class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
                            <button class="btn btn-outline-success" type="submit">Search</button>
                        </form>
                    </div>
                    <div class="col-md-4 text-end">
                        <c:choose>
                            <c:when test="${sessionScope.account != null}">
                                <c:if test="${sessionScope.account.adminLevel == 1}">
                                    <a href="${pageContext.request.contextPath}/add.jsp" class="btn btn-outline-primary me-2">Add Product</a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/cart" class="btn btn-primary me-2">Cart</a>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-outline-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                                        ${sessionScope.account.username}
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/account.jsp">Account</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                                    </ul>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-primary me-2">Login</a>
                                <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary">Register</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </header>
        <div class="container mt-4">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/list">All Games</a>
                            </li>
                            <c:forEach items="${requestScope.listCategories}" var="c">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/category?cid=${c.id}">${c.name}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </body>
</html>      
