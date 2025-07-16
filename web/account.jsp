
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <title>Manage Account</title>
        <!-- Page-specific stylesheet removed: using common.css globally -->
        <jsp:include page="common/header.jsp" />
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        <section class="ftco-section">
            <div class="container">
                <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">Back</a><br/>
                <div class="row justify-content-center">
                    <div class="col-md-6 text-center mb-5">
                        <h2 class="heading-section">Manage Account</h2>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="table-wrap">
                            <table class="table text-center table-striped">
                                <thead>
                                    <tr>
                                        <th>Username</th>
                                        <th>Password</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:if test="${sessionScope.account.adminLevel == 1}">
                                    <c:forEach items="${requestScope.accounts}" var="a">
                                        <tr>
                                            <td>${a.user}</td>
                                            <td>********</td>
                                            <td><a href="${pageContext.request.contextPath}/remove?uid=${a.id}" class="btn btn-danger">Remove</a></td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                </tbody>
                            </table>
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/updateacc" class="btn btn-warning">Edit current account</a>
                            </div>
                        </div>
                        <div class="text-center mt-4" style="display: inline-block; margin-right:auto; width: 100%">
                            <c:forEach begin="${1}" end="${requestScope.num}" var="i">
                                <a style='text-decoration: none; color: white;' href="${pageContext.request.contextPath}/account?page=${i}">
                                    <button style='margin-right: 1px;' class="btn btn-outline-dark ${i == page ? "active" : ""}">
                                        ${i}
                                    </button>
                                </a>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
