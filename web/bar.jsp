
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
    <div class="container">
        <!-- Brand -->
        <a class="navbar-brand fw-bold d-flex align-items-center" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-controller me-2"></i>Categories
        </a>

        <!-- Toggler -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#categoryNavbar" aria-controls="categoryNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Links -->
        <div class="collapse navbar-collapse" id="categoryNavbar">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link ${empty tag ? "active" : ""}" href="${pageContext.request.contextPath}/home">All</a>
                </li>
                <c:forEach items="${requestScope.categories}" var="c">
                    <li class="nav-item">
                        <a class="nav-link ${tag == c.id ? "active" : ""}" href="${pageContext.request.contextPath}/category?cid=${c.id}">${c.name}</a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</nav>
