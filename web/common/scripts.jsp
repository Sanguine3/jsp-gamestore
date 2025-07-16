<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Common JavaScript Imports -->

<!-- Bootstrap Bundle with Popper -->
<script src="${pageContext.request.contextPath}/webjars/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>

<!-- jQuery (if needed) -->
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

<!-- Custom Scripts -->
<c:if test="${not empty jsfile}">
    <script src="${pageContext.request.contextPath}/js/${jsfile}"></script>
</c:if> 