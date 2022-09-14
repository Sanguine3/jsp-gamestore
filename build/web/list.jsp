

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <link rel="icon" href="https://static.vecteezy.com/system/resources/previews/002/061/701/original/video-games-icon-with-tv-and-gamepad-eps-vector.jpg">
        <title>List</title>
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
        <c:set var="page" value="${requestScope.page}"/>
            <section class="ftco-section">
                <div class="container">
                    <a href="home" class="btn btn-primary">Back</a><br/>
                    <div class="row justify-content-center">
                        <div class="col-md-6 text-center mb-5">
                            <h2 class="heading-section">Manage Product</h2>
                        </div>
                    </div>
                    <a style="margin-bottom: 10px" href="add" class="btn btn-success">Add Game</a><br/>
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
                                            <td><img src="${p.image}" width="150" height="100"></td>
                                            <td><c:if test="${p.price != 0}">$${p.price}</c:if><c:if test="${p.price == 0}">Free</c:if></td>
                                            <td>${p.cat.name}</td>
                                            <td>${p.releasedate}</td>
                                            <td>${p.rating}<div class="bi-star-fill"></div></td>
                                            <td><a href="delete?pid=${p.id}" class="btn btn-danger">Delete</a><br/><a href="update?pid=${p.id}" class="btn btn-warning">Edit</a></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="text-center" style="display: inline-block; margin-right:auto; width: 100%">
                        <c:forEach begin="${1}" end="${requestScope.num}" var="i">
                            <a style='text-decoration: none; color: white;' href="list?page=${i}">
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
        <script src="js/jquery.min.js"></script>
        <script src="js/popper.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>



