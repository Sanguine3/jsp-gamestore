

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <link rel="icon" href="https://static.vecteezy.com/system/resources/previews/002/061/701/original/video-games-icon-with-tv-and-gamepad-eps-vector.jpg">
        <!-- Required meta tags-->
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="Colorlib Templates">
        <meta name="author" content="Colorlib">
        <meta name="keywords" content="Colorlib Templates">

        <!-- Title Page-->
        <title>Edit Game</title>

        <!-- Icons font CSS-->
        <link href="vendor/mdi-font/css/material-design-iconic-font.min.css" rel="stylesheet" media="all">
        <link href="vendor/font-awesome-4.7/css/font-awesome.min.css" rel="stylesheet" media="all">
        <!-- Font special for pages-->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">

        <!-- Vendor CSS-->
        <link href="vendor/select2/select2.min.css" rel="stylesheet" media="all">
        <link href="vendor/datepicker/daterangepicker.css" rel="stylesheet" media="all">

        <!-- Main CSS-->
        <link href="css/crud.css" rel="stylesheet" media="all">
    </head>

    <body>
        <div class="page-wrapper bg-gra-03 p-t-45 p-b-50">
            <div class="wrapper wrapper--w790">
                <div class="card card-5">
                    <div class="card-heading">
                        <h2 class="title">Edit a game</h2>
                    </div>
                    <div class="card-body">
                        <c:set var="p" value="${requestScope.product}"/>
                        <form action="update" method="post">
                            <div class="form-row">
                                <div class="name">ID</div>
                                <div class="value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="id" readonly value="${p.id}">
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="name">Name</div>
                                <div class="value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="name" value="${p.name}">
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="name">Image</div>
                                <div class="value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="image" value="${p.image}">
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="name">Price</div>
                                <div class="value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="price" value="${p.price}">
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="name">Description</div>
                                <div class="value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="description" value="${p.description}">
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="name">ReleaseDate</div>
                                <div class="value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="releasedate" value="${p.releasedate}">
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="name">Rating</div>
                                <div class="value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="rating" value="${p.rating}">
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="name">Category</div>
                                <div class="value">
                                    <div class="input-group">
                                        <div class="rs-select2 js-select-simple select--no-search">
                                            <select name="cid">
                                                <c:forEach items="${requestScope.categories}" var="c">
                                                    <option <c:if test="${p.cat.id == c.id}">selected</c:if> value="${c.id}">${c.name}</option>
                                                </c:forEach>
                                            </select>
                                            <div class="select-dropdown"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button class="btn btn--radius-2 btn--red" type="submit">Update</button>
                        </form>
                        <a href="list"><button class="btn btn--radius-2 btn--blue">Back</button></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Jquery JS-->
        <script src="vendor/jquery/jquery.min.js"></script>
        <!-- Vendor JS-->
        <script src="vendor/select2/select2.min.js"></script>
        <script src="vendor/datepicker/moment.min.js"></script>
        <script src="vendor/datepicker/daterangepicker.js"></script>

        <!-- Main JS-->
        <script src="js/global.js"></script>

    </body><!-- This templates was made by Colorlib (https://colorlib.com) -->

</html>
<!-- end document-->

