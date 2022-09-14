

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <link rel="icon" href="https://static.vecteezy.com/system/resources/previews/002/061/701/original/video-games-icon-with-tv-and-gamepad-eps-vector.jpg">
        <title>Manage Account</title>
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
                    <a href="home" class="btn btn-primary">Back</a><br/>
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
                                <c:if test="${sessionScope.account.admin == 1}">
                                    <tbody>
                                        <c:forEach items="${requestScope.accounts}" var="a">
                                            <tr>
                                                <td>${a.user}</td>
                                                <td>${a.pass}</td>
                                                <td><a href="remove?uid=${a.id}" class="btn btn-danger">Remove</a></td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                <a href="updateacc" class="btn btn-warning">Edit current account</a>
        </tbody>
                                
                            </table>
                    </div>
                    <div class="text-center" style="display: inline-block; margin-right:auto; width: 100%">
                        <c:forEach begin="${1}" end="${requestScope.num}" var="i">
                            <a style='text-decoration: none; color: white;' href="account?page=${i}">
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
