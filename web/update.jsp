
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Game</title>
        <!-- Page-specific stylesheet removed: using common.css globally -->
        <jsp:include page="common/header.jsp" />
    </head>
    <body>
        <div class="page-wrapper bg-gra-03 p-t-45 p-b-50">
            <div class="wrapper wrapper--w790">
                <div class="card-component">
                    <div class="card-component__heading">
                        <h2 class="title">Edit a game</h2>
                    </div>
                    <div class="card-component__body">
                        <c:set var="p" value="${requestScope.product}"/>
                        <form action="${pageContext.request.contextPath}/update" method="post">
                            <div class="form-row">
                                <div class="form-row__name">ID</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="id" readonly value="${p.id}">
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">Name</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="name" value="${p.name}" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">Image</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="image" value="${p.image}" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">Price</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="number" step="0.01" name="price" value="${p.price}" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">Description</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="description" value="${p.description}" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">ReleaseDate</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="date" name="releasedate" value="${p.releasedate}" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">Rating</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="number" step="0.1" min="0" max="5" name="rating" value="${p.rating}" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">Category</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <div class="rs-select2 js-select-simple select--no-search">
                                            <select name="cid" required>
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
                        <a href="${pageContext.request.contextPath}/list"><button class="btn btn--radius-2 btn--blue">Back</button></a>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="common/scripts.jsp" />
    </body>
</html>

