

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="en">
    <head>
        <link rel="icon" href="https://static.vecteezy.com/system/resources/previews/002/061/701/original/video-games-icon-with-tv-and-gamepad-eps-vector.jpg">
        <title>Cart</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

        <link rel="stylesheet" href="css/list.css">
        <link rel="stylesheet" href="css/home.css">

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
                                            <td><img src="${i.product.image}" width="150" height="100"></td>
                                            <td><c:if test="${i.price != 0}"><fmt:formatNumber type="number" maxFractionDigits="2" value="${i.price}"/></c:if>
                                                <c:if test="${i.price == 0}">Free</c:if>
                                            </td>
                                            <td>
                                                <a href="process?num=-1&id=${i.product.id}"><button class="btn btn-success">-</button></a>
                                                <input class="btn" style="text-align: center" type="text" readonly value="${i.quantity}"/> 
                                                <a href="process?num=1&id=${i.product.id}"><button class="btn btn-success">+</button></a>
                                            </td>
                                            <td><fmt:formatNumber type="number" maxFractionDigits="2" value="${i.quantity * i.price}"/></td>
                                            <td><form action="process" method="post">
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
                        <a href="home" class="btn btn-dark">Continue Shopping</a><br/>
                    </div>
                    <div class="col-lg-6">
                        <div class="bg-light rounded-pill px-4 py-3 text-uppercase font-weight-bold">Invoice</div>
                        <div class="p-4">
                            <ul class="list-unstyled mb-4">
                                <li class="d-flex justify-content-between py-3 border-bottom"><strong class="text-muted">Total</strong><strong><fmt:formatNumber type="number" maxFractionDigits="2" value="${c.getTotalMoney()}"/></strong></li>
                            </ul><a href="purchase" class="btn btn-dark py-2 btn-block">Purchase</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="footer.jsp"></jsp:include>                    
        <script src="js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>

