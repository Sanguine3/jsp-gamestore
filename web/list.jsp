

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <title>List</title>
        <!-- Page-specific stylesheet removed: using common.css globally -->
        <jsp:include page="common/header.jsp" />
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        <c:set var="page" value="${requestScope.page}"/>
            <section class="ftco-section">
                <div class="container">
                    <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Back</a><br/>
                    <div class="row justify-content-center">
                        <div class="col-md-6 text-center mb-5">
                            <h2 class="heading-section">Manage Product</h2>
                        </div>
                    </div>
                    <a style="margin-bottom: 10px" href="${pageContext.request.contextPath}/add" class="btn btn-success">Add Game</a><br/>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-wrap">
                                <table class="table text-center table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Image</th>
                                            <th>Price</th>
                                            <th>CategoryID</th>
                                            <th>ReleaseDate</th>
                                            <th>Rating</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${requestScope.products}" var="p">
                                        <tr>
                                            <th scope="row">${p.id}</th>
                                            <td>${p.name}</td>
                                            <td><img src="${p.image}" width="150" height="100" alt="${p.name}"></td>
                                            <td><c:if test="${p.price != 0}">$${p.price}</c:if><c:if test="${p.price == 0}">Free</c:if></td>
                                            <td>${p.cat.name}</td>
                                            <td>${p.releasedate}</td>
                                            <td>${p.rating}<div class="bi-star-fill"></div></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/delete?pid=${p.id}" class="btn btn-danger">Delete</a><br/>
                                                <a href="${pageContext.request.contextPath}/update?pid=${p.id}" class="btn btn-warning mt-2">Edit</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="text-center" style="display: inline-block; margin-right:auto; width: 100%">
                        <c:forEach begin="${1}" end="${requestScope.num}" var="i">
                            <a style='text-decoration: none; color: white;' href="${pageContext.request.contextPath}/list?page=${i}">
                                <button style='margin-right: 1px;' class="btn btn-outline-dark ${i == page ? "active" : ""}">
                                    ${i}
                                </button>
                            </a>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>



