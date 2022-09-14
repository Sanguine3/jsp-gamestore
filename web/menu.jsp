
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <a class="navbar-brand" href="#">GameShop™</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <li class="nav-item"><a class="nav-link" href="home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                
                <c:if test="${sessionScope.account != null}">
                    <li class="nav-item"><a class="nav-link" href="account">Manage Account</a></li>
                </c:if>
                    
                    <c:if test="${sessionScope.account.admin == 1}">
                    <li class="nav-item"><a class="nav-link" href="list">Manage Product</a></li>   
                    </c:if>
            </ul>
            <form action="search" method="post" class="d-flex">
                <div>
                    <input style="font-weight: 400; line-height: 1.5; color: #212529; text-decoration: none; vertical-align: middle; background-color: transparent; border: 1px solid black; padding: 0.375rem 0.75rem; font-size: 1rem; border-radius: 0.25rem;" class="btn-outline-dark" name="search" type="text" placeholder="Search..." value="${requestScope.search}"/>
                    <button class="btn btn-outline-dark" type="submit">Search</button>
                </div>
            </form>
            <c:if test="${sessionScope.account != null}">
                <a href="cart">
                    <button style='margin-left: 10px' class="btn btn-outline-dark">
                        <i class="bi-cart-fill me-1"></i>
                        Cart  
                        <span class="badge bg-dark text-white ms-1 rounded-pill">${sessionScope.size}</span>
                    </button>
                </a>
            </c:if>
            <c:if test="${sessionScope.account == null}">
                <a href='login.jsp'>
                    <button style='margin-left: 10px' class="btn btn-outline-dark">
                        Login
                    </button>
                </a>
            </c:if>
            <c:if test="${sessionScope.account != null}">
                <a href='#'>
                    <button style='margin-left: 10px' class="btn btn-outline-dark">
                        Hello, ${sessionScope.account.user}!
                    </button>
                </a>
                <a href='logout'>
                    <button style='margin-left: 10px' class="btn btn-outline-dark">
                        Logout
                    </button>
                </a>
            </c:if>
        </div>
    </div>
</nav>      
