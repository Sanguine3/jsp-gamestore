<%-- 
    Document   : updateAcc
    Created on : Jul 19, 2022, 3:05:42 PM
    Author     : 5555
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Account</title>
        <!-- Page-specific stylesheet removed: using common.css globally -->
        <jsp:include page="common/header.jsp" />
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
            <div class="overlay">
                <!-- LOGIN FORM -->
                <form method="post" action="${pageContext.request.contextPath}/updateacc">
                    <!--   con = Container  for items in the form-->
                    <div class="con">
                        <!--     Start  header Content  -->
                        <header class="head-form">
                            <h2>UPDATE ACCOUNT</h2>
                            <!--     A welcome message or an explanation of the login form -->
                            <p>Update your account information here</p>
                        </header>
                        <!--     End  header Content  -->
                        <br>
                        <div class="field-set">
                        <c:set var="a" value="${requestScope.acc}"></c:set>
                            <!--   ID -->
                            <span class="input-item">
                                <i class="fa fa-id-badge"></i>
                            </span>
                            <input readonly class="form-input" type="text" placeholder="ID" name="aid" value="${a.id}">

                            <br>
                            <!--   Username -->
                            <span class="input-item">
                                <i class="fa fa-user-circle"></i>
                            </span>
                            <!--   Username Input-->
                            <input value="${a.user}" class="form-input" id="txt-input" type="text" placeholder="Username" required name="user">

                            <br>
                            <!--   Password -->
                            <span class="input-item">
                                <i class="fa fa-key"></i>
                            </span>
                            <!--   Password Input-->
                            <input value="${a.pass}" class="form-input" id="txt-input" type="password" placeholder="Password" name="pass">

                            <br>
                            <div class="name">Is Admin</div>
                            <br>
                            <span class="input-item">
                                <i class="fa fa-id-badge"></i>
                            </span>
                            <select name="admin">
                                <c:if test = "${a.adminLevel == 1}">
                                    <option value="${a.adminLevel}">Yes</option>
                                </c:if>
                                <c:if test = "${a.adminLevel == 0}">
                                    <option value="${a.adminLevel}">No</option>
                                </c:if>
                                <option value="1">Yes</option>
                                <option value="0">No</option>
                            </select>
                            <br>
                            <!--        buttons -->
                            <!--      button Update -->
                            <button type="submit" class="log-in"> Update</button>
                        </div>

                        <!--   other buttons -->
                        <div class="other">
                            <!--      Home button-->
                            <button class="btn submits frgt-pass" type="button"><a href="${pageContext.request.contextPath}/home" style="color: white;text-decoration: none">Home</a></button>
                            <!--     Accounts button -->
                            <button class="btn submits sign-up"><a href="${pageContext.request.contextPath}/account" style="color: white;text-decoration: none">Accounts</a></button>
                            <!--         Sign Up font icon -->
                            <i class="fa fa-user-plus" aria-hidden="true"></i>
                        </div>

                        <!--   End Container  -->
                    </div>

                    <!-- End Form -->
                </form>
            </div>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>


