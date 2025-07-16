
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Game</title>
        <!-- Page-specific stylesheet removed: using common.css globally -->
        <jsp:include page="common/header.jsp" />
    </head>
    <body>
        <div class="page-wrapper bg-gra-03 p-t-45 p-b-50">
            <div class="wrapper wrapper--w790">
                <div class="card-component">
                    <div class="card-component__heading">
                        <h2 class="title">Add a game</h2>
                    </div>
                    <div class="card-component__body">
                        <form action="${pageContext.request.contextPath}/add" method="post">
                            <div class="form-row">
                                <div class="form-row__name">Name</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="name" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">Image</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="image" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">Price</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="number" step="0.01" name="price" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">Description</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="text" name="description" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">ReleaseDate</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="date" name="releasedate" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">Rating</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <input class="input--style-5" type="number" step="0.1" min="0" max="5" name="rating" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-row__name">Category</div>
                                <div class="form-row__value">
                                    <div class="input-group">
                                        <div class="rs-select2 js-select-simple select--no-search">
                                            <select name="cid" required>
                                                <option disabled="disabled" selected="selected">Choose option</option>
                                                <c:forEach items="${requestScope.categories}" var="c">
                                                    <option <c:if test="${c.id == cid}">selected</c:if> value="${c.id}">${c.name}</option>
                                                </c:forEach>
                                            </select>
                                            <div class="select-dropdown"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div style="display: inline-block">
                                <button class="btn btn--radius-2 btn--red" type="submit">Add</button>
                            </div>
                        </form>
                        <a href="${pageContext.request.contextPath}/list"><button class="btn btn--radius-2 btn--blue">Back</button></a>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="common/scripts.jsp" />
    </body>
</html>
