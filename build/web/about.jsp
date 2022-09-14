

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="https://static.vecteezy.com/system/resources/previews/002/061/701/original/video-games-icon-with-tv-and-gamepad-eps-vector.jpg">
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet"/>
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/home.css" rel="stylesheet" />
        <title>About</title>
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
                            <img src="https://wallpapercave.com/wp/wp8830728.jpg" width=100%">
                        </div>
                        <div class="col-md-7 py-5 wrap-about pb-md-5">
                            <div class="heading-section-bold mb-4 mt-md-5">
                                <div class="ml-md-0">
                                    <h2 class="mb-4 text-center">Instant Access</h2>
                                </div>
                            </div>
                            <div class="pb-md-5">
                                <p>Early access to upcoming titles. Enjoy exclusive deals, regular game updates, and other great benefits. Discover, play, and get in touch with games as they evolve. Be the first to see what's coming and become a part of the ever-changing gaming world.</p>
                                <p class="text-center"><a href="home" class="btn btn-dark">Shop now</a></p>
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
                            <img src="https://store.akamai.steamstatic.com/public/images/valveindex/kit_social_media.jpg" width="100%">
                        </div>
                    </div>
                </div>
            </section>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
