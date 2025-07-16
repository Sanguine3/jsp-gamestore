<%-- 
    Document   : changeinfo
    Created on : Jul 19, 2022, 6:17:56 PM
    Author     : 5555
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Notification</title>
        <jsp:include page="common/header.jsp" />
        <style>
            body {
                background-image: url("https://wallpaperaccess.com/full/2329697.jpg");
                background-size: cover;
                background-repeat: no-repeat;
            }
            .center {
                margin-left: auto;
                margin-right: auto;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-8 text-center">
                    <div class="card bg-dark text-white">
                        <div class="card-body">
                            <h1 class="card-title" style="text-align:center; color: white; text-shadow: 2px 2px #ff0000">Attention, user!</h1>
                            <p class="card-text" style="text-align:center; font-size:140%; color: white; text-shadow: 1px 1px black">Your information had been changed successfully, all accounts logged out.</p>
                            <div class="d-flex justify-content-center">
                                <a class="btn btn-success me-2" href="${pageContext.request.contextPath}/login.jsp" role="button">Click here to login again</a>
                                <a class="btn btn-warning" href="${pageContext.request.contextPath}/home" role="button">Click here to go back to the HomePage</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="common/scripts.jsp" />
    </body>
</html>
