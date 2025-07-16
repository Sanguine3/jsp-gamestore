
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
    <head>
        <title>Sign up</title>
        <!-- Page-specific stylesheet removed: using common.css globally -->
        <jsp:include page="common/header.jsp" />
    </head>
    <body style="background-image: url(https://steamcdn-a.akamaihd.net/steamcommunity/public/images/items/292030/a42ae88904d993d7d59341e265db211f4966fc3b.jpg); background-position:center; background-size: cover;">
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6 text-center mb-5">
                        <h2 style='color: white' class="heading-section">Sign up</h2>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <div class="col-md-7 col-lg-5">
                        <div class="wrap">
                            <div class="img" style="background-image: url(https://i.pinimg.com/originals/89/38/74/89387431bf8631336b7967bc065a6af1.jpg);"></div>
                            <div class="login-wrap p-4 p-md-5">
                                <div class="d-flex">
                                    <div class="w-100">
                                        <h3 class="mb-4 text-center">Sign up</h3>
                                    </div>
                                </div>
                                <form action="${pageContext.request.contextPath}/register" method="post" class="signin-form">
                                    <p class="text-success">${requestScope.success}</p>
                                    <p class="text-danger">${requestScope.error}</p>
                                    <p class="text-danger">${requestScope.error1}</p>
                                    <div class="form-group mt-3">
                                        <input name="user" type="text" class="form-control" required>
                                        <label class="form-control-placeholder" for="username">Username</label>
                                    </div>
                                    <div class="form-group">
                                        <input name="pass" id="password-field" type="password" class="form-control" required>
                                        <label class="form-control-placeholder" for="password">Password</label>
                                    </div>
                                    <div class="form-group">
                                        <input name="repass" id="password-field" type="password" class="form-control" required>
                                        <label class="form-control-placeholder" for="password">Confirm Password</label>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="form-control btn btn-primary rounded submit px-3">Sign Up</button>
                                    </div>
                                    <div class="form-group d-md-flex">
                                        <div class="w-50 text-left">
                                        </div>
                                        <div class="w-50 text-md-right">
                                        </div>
                                    </div>
                                </form>
                                <p class="text-center">Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <jsp:include page="common/scripts.jsp" />
    </body>
</html>


