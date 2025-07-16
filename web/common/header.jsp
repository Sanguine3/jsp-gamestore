<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- Common Header with Standardized CSS/JS Imports -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="icon" href="https://static.vecteezy.com/system/resources/previews/002/061/701/original/video-games-icon-with-tv-and-gamepad-eps-vector.jpg">

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- Common CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">

<!-- Page-specific CSS -->
<c:if test="${not empty cssfile}">
    <link href="${pageContext.request.contextPath}/css/${cssfile}" rel="stylesheet" type="text/css"/>
</c:if>

<!-- CSRF Protection -->
<c:if test="${not empty pageContext.request.userPrincipal}">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
</c:if> 