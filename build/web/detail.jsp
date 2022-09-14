

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="icon" href="https://static.vecteezy.com/system/resources/previews/002/061/701/original/video-games-icon-with-tv-and-gamepad-eps-vector.jpg">
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Details</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/detail.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Navigation-->
        <jsp:include page="menu.jsp"></jsp:include>
            <!-- Header-->
            <header style="background-size: 100% 300px; background-repeat: no-repeat; background-image: url(https://i.imgur.com/9A12u2b.jpg)" class="py-5">
                <div class="container px-4 px-lg-5 my-5">
                    <div class="text-center text-white">
                        <h1 class="display-4 fw-bolder" style="color: white">GameShop™</h1>
                        <p class="lead fw-normal text-white-50 mb-0">The best video game retailer out there</p>
                    </div>
                </div>
            </header>  
            <!-- Product section-->
        <jsp:include page="bar.jsp"></jsp:include>
            <section style="background-image: url(https://wallpapercave.com/wp/wp7347036.jpg); color: white" class="py-5">
                <div class="container px-4 px-lg-5 my-5">
                    <form name="f" action="cart" method="post">
                        <input type="hidden" name="id" value="">
                        <div class="row gx-4 gx-lg-5 align-items-center">
                            <div class="col-md-6"><img class="card-img-top mb-5 mb-md-0" src="${p.image}" alt="..." /></div>
                        <div class="col-md-6">
                            <h1 class="display-5 fw-bolder">${p.name}</h1>
                            <div style="font-weight: bold" class="d-flex big text-warning mb-2">
                                Rating: ${p.rating}/5<div class="bi-star-fill"></div>
                            </div>
                            <div class="fs-5 mb-2">
                                <span  style="font-weight: bold">Price: <c:if test="${p.price != 0}">$${p.price}</c:if><c:if test="${p.price == 0}">Free</c:if></span><br/>
                                Category: ${p.cat.name}<br/>
                                Release Date: ${p.releasedate}
                            </div>
                            <p class="lead">${p.description}</p>
                            <div class="d-flex">
                                <c:if test="${sessionScope.account != null}">
                                    <button style="width: 7%; margin-right: 2.5%" type="button" class="btn btn-outline-light flex-shrink-0"  data-type="minus" data-field="" onClick="decrease()">
                                        -
                                    </button>
                                    <input class="form-control text-center me-3" id="quantity" type="text" name="num" value="1" style="max-width: 3rem"/>
                                    <button style="width: 7%; margin-right: 2.5%" type="button" class="btn btn-outline-light flex-shrink-0"  data-type="plus" data-field="" onClick="increase()">
                                        +
                                    </button>
                                    <input class="btn btn-outline-light flex-shrink-0" type="submit" onclick="cart('${p.id}')" value="Add to Cart"/>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </section>
        <!-- Footer-->
        <jsp:include page="footer.jsp"></jsp:include>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script type="text/javascript">
                                        function decrease() {
                                            var quantity = document.getElementById("quantity").value;
                                            if(!(quantity < 2)){
                                                quantity--;
                                                document.getElementById("quantity").setAttribute('value', quantity);
                                            }
                                            
                                        }
                                        function increase() {
                                            var quantity = document.getElementById("quantity").value;
                                            quantity++;
                                            document.getElementById("quantity").setAttribute('value', quantity);
                                        }
                                        function cart(id) {
                                            document.f.action = "cart?pid=" + id;
                                            document.f.submit();

                                        }

        </script>
    </body>
</html>

