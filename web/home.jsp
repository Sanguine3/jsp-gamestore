

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <!-- Page-specific stylesheet removed: using common.css globally -->
        <jsp:include page="/WEB-INF/views/common/header.jsp" />
    </head>
    <body style="background-color: #0d0c0c">
        <jsp:include page="menu.jsp"></jsp:include>
            <!-- Header-->
            <header style="background-size: 100% 300px; background-repeat: no-repeat; background-image: url(https://img.freepik.com/premium-vector/modern-colorful-orange-wide-banner-background-abstract-background-banner-design-web-banner-texture-header-website-vector-abstract-graphic-design-banner-pattern-background-template_181182-17976.jpg)" class="py-5">
                <div class="container px-4 px-lg-5 my-5">
                    <div class="text-center text-white">
                        <h1 class="display-4 fw-bolder" style="color: white">GameShop™</h1>
                        <p class="lead fw-normal text-white-50 mb-0">Never Gonna Give Game Up</p>
                    </div>
                </div>
            </header>  
            <!-- Section-->
        <jsp:include page="bar.jsp"></jsp:include>
        <c:set var="page" value="${requestScope.page}"/>
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4">
                    <c:forEach items="${requestScope.products}" var="p">
                        <div class="col mb-5">
                            <div class="card h-100 border-dark">
                                <!-- Product image-->
                                <img class="card-img-top" src="${p.image}" alt="${p.name}" width="254" height="150">
                                <!-- Product details-->
                                <div class="card-body p-4">
                                    <div class="text-center">
                                        <!-- Product name-->
                                        <h5 class="fw-bolder">${p.name}</h5>
                                        <!-- Product reviews-->
                                        <div style="font-weight: bold" class="d-flex justify-content-center small text-warning mb-2">
                                            Rating: ${p.rating}/5<div class="bi-star-fill"></div>
                                        </div>
                                        <!-- Product price-->
                                        Category: ${p.cat.name}<br/>
                                        Release Date: ${p.releasedate}<br/>
                                        <p style="font-weight: bold">Price: <c:if test="${p.price != 0}">$${p.price}</c:if><c:if test="${p.price == 0}">Free</c:if></p>
                                        </div>
                                    </div>
                                    <!-- Product actions-->
                                    <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                            <div class="text-center justify-content-center"><a class="btn btn-outline-dark mt-auto" href="${pageContext.request.contextPath}/detail?pid=${p.id}">View Detail</a></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="text-center" style="display: inline-block; margin-right:auto; width: 100%">
                        <c:forEach begin="${1}" end="${requestScope.num}" var="i">
                            <a style='text-decoration: none; color: white;' href="${pageContext.request.contextPath}/home?page=${i}">
                                <button style='margin-right: 1px;' class="btn btn-outline-dark ${i == page ? "active" : ""}">
                                    ${i}
                                </button>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </section>
        <!-- Footer-->
        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    </body>
</html>

