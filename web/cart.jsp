

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="en">
    <head>
        <title>Cart</title>
        <!-- Page-specific stylesheet removed: using common.css globally -->
        <jsp:include page="common/header.jsp" />
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
            <section class="ftco-section">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-md-6 text-center mb-5">
                            <h2 class="heading-section">Cart</h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-wrap">
                                <table class="table text-center table-striped">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Image</th>
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total Price</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:set value="${sessionScope.cart}" var="c"/>
                                    <c:forEach items="${c.items}" var="i">
                                        <tr>
                                            <td>${i.product.name}</td>
                                            <td><img src="${i.product.image}" width="150" height="100" alt="${i.product.name}"></td>
                                            <td><c:if test="${i.price != 0}"><fmt:formatNumber type="number" maxFractionDigits="2" value="${i.price}"/></c:if>
                                                <c:if test="${i.price == 0}">Free</c:if>
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/process?num=-1&id=${i.product.id}"><button class="btn btn-success">-</button></a>
                                                <input class="btn" style="text-align: center" type="text" readonly value="${i.quantity}"/> 
                                                <a href="${pageContext.request.contextPath}/process?num=1&id=${i.product.id}"><button class="btn btn-success">+</button></a>
                                            </td>
                                            <td><fmt:formatNumber type="number" maxFractionDigits="2" value="${i.quantity * i.price}"/></td>
                                            <td><form action="${pageContext.request.contextPath}/process" method="post">
                                                    <input type="hidden" name="id" value="${i.product.id}"/>
                                                    <input class="btn btn-danger" type="submit" value="Remove"/>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="row py-5 p-4 bg-white rounded shadow-sm">
                    <div class="col-lg-6">
                        <p class="text-success">${requestScope.success}</p><br>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-dark">Continue Shopping</a><br/>
                    </div>
                    <div class="col-lg-6">
                        <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Invoice</div>
                        <div class="p-4">
                            <ul class="list-unstyled mb-4">
                                <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Total</strong><strong><fmt:formatNumber type="number" maxFractionDigits="2" value="${c.getTotalMoney()}"/></strong></li>
                            </ul><a href="${pageContext.request.contextPath}/purchase" class="btn btn-dark py-2 btn-block">Purchase</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>

