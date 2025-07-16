
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>About</title>
        <jsp:include page="common/header.jsp" />
        <!-- Page-specific stylesheet removed: using common.css globally -->
    </head>
    <body style="background-color: #0d0c0c">
        <jsp:include page="menu.jsp"></jsp:include>
            <header style="background-size: 100% 300px; background-repeat: no-repeat; background-image: url(https://img.freepik.com/premium-vector/modern-colorful-orange-wide-banner-background-abstract-background-banner-design-web-banner-texture-header-website-vector-abstract-graphic-design-banner-pattern-background-template_181182-17976.jpg)" class="py-5">
                <div class="container px-4 px-lg-5 my-5">
                    <div class="text-center text-white">
                        <h1 class="display-4 fw-bolder" style="color: white">GameShop™</h1>
                        <p class="lead fw-normal text-white-50 mb-0">Never Gonna Give Game Up.</p>
                    </div>
                </div>
            </header>  
            <section class="py-5">
                <div class="container">
                    <div style="color: white" class="row">
                        <div class="col-md-5">
                            <img src="https://wallpapercave.com/wp/wp8830728.jpg" width="100%" alt="Game image">
                        </div>
                        <div class="col-md-7 py-5 wrap-about pb-md-5">
                            <div class="heading-section-bold mb-4 mt-md-5">
                                <div class="ml-md-0">
                                    <h2 class="mb-4 text-center">Instant Access</h2>
                                </div>
                            </div>
                            <div class="pb-md-5">
                                <p>Early access to upcoming titles. Enjoy exclusive deals, regular game updates, and other great benefits. Discover, play, and get in touch with games as they evolve. Be the first to see what's coming and become a part of the ever-changing gaming world.</p>
                                <p class="text-center"><a href="${pageContext.request.contextPath}/home" class="btn btn-dark">Shop now</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <section class="py-5">
                <div class="container">
                    <div style="color: white" class="row">
                        <div class="col-md-7 py-5 wrap-about pb-md-5">
                            <div class="heading-section-bold mb-4 mt-md-5">
                                <div class="ml-md-0">
                                    <h2 class="mb-4 text-center">Hardware Compatibility</h2>
                                </div>
                            </div>
                            <div class="pb-md-5">
                                <p>GameShop™ encourages game developers to include in-depth console support and accessibility in their products including PlayStation, Xbox, Nintendo, Steam Deck and VR.</p>
                            </div>
                        </div>
                        <div class="col-md-5">
                            <img src="https://store.akamai.steamstatic.com/public/images/valveindex/kit_social_media.jpg" width="100%" alt="VR hardware">
                        </div>
                    </div>
                </div>
            </section>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
