

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<footer class="py-5 bg-dark" style="color: white">
    <div class="container">
        <div class="row">
            <div class="col-md-3" style="margin-top: 30px">&copy; 2022 GameShop™. All rights reserved.</div>

            <div class="col-md-3 text-center">
                <div class="bi-twitter"> Twitter</div>
                <div class="bi-instagram"> Instagram</div>
                <div class="bi-facebook"> Facebook</div>
                <div class="bi-twitch"> Twitch</div>
            </div>

            <div class="col-md-3 justify-content-center">Email: huyvqhe163784@fpt.edu.vn</div>

            <div class="col-md-3">
                <ul>
                    <li><a style="color: white;text-decoration: none" href="${pageContext.request.contextPath}/about.jsp">About GameShop™</a></li>
                    <li><a style="color: white;text-decoration: none" href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li><a style="color: white;text-decoration: none" href="${pageContext.request.contextPath}/chart" accesskey="1" title="">Store Statistics</a></li>
                </ul>
            </div>
        </div>
    </div>
</footer>
<!-- Include common scripts -->
<jsp:include page="common/scripts.jsp" />
</body>
</html>