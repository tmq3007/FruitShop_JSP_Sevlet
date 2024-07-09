<%-- 
    Document   : shop-details
    Created on : May 28, 2024, 10:01:29 PM
    Author     : admin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="zxx">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Ogani Template">
        <meta name="keywords" content="Ogani, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>OrgaVes</title>

        <!-- Google Font -->
        <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

        <!-- Css Styles -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css">
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
    <head>
        <!-- Các thẻ khác -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    </head>

</head>

<body>
    <jsp:include page="header.jsp"/>

    <!-- Hero Section Begin -->
    <section class="hero hero-normal">
        <div class="container">
            <div class="row">
                <jsp:include page="left.jsp"/>
            </div>
        </div>
    </section>
    <!-- Hero Section End -->

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>${detail.name}’s Package</h2>
                        <div class="breadcrumb__option">
                            <a href="home">Home</a>
                            <a href="home">${detail.name}</a>
                            <span>${detail.name}’s Package</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Product Details Section Begin -->
    <section class="product-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="product__details__pic">
                        <div class="product__details__pic__item">
                            <img class="product__details__pic__item--large" src="${detail.imgURL}" alt="">
                        </div>
                        <div class="product__details__pic__slider owl-carousel">
                            <c:forEach var="item" items="${listProducts}">
                                <a href="shopdetail?pid=${item.id}" data-imgbigurl="${item.imgURL}">
                                    <img src="${item.imgURL}" alt="">
                                </a>
                            </c:forEach>
                        </div>


                    </div>
                </div>

                <div class="col-lg-6 col-md-6">
                    <div class="product__details__text">
                        <h3>${detail.name}’s Package</h3>
                        <div class="product__details__rating">
                            <%-- Display full stars --%>
                            <c:forEach var="i" begin="0" end="4"> <!-- Loop 5 times for up to 5 stars -->
                                <c:choose>
                                    <c:when test="${i < fullStars}">
                                        <i class="fa fa-star"></i>
                                    </c:when>
                                    <c:when test="${i == fullStars && hasHalfStar}">
                                        <i class="fa fa-star-half"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fa fa-star-o"></i> <!-- Empty star if neither full nor half -->
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <span>(${reviewsCount} reviews)</span>
                        </div>
                        <div class="product__details__price">$ ${detail.unitPrice}</div>
                        <p>${detail.desciption}</p>


                        <form action="cart3" method="post">
                        <div class="product__details__quantity">
                            <div class="quantity">
                                <div class="pro-qty">
                                    <input type="text" name="num" value="1">
                                    
                                </div>
                            </div>
                            <input type="hidden" name="id" value="${detail.id}">
                        </div><input class="primary-btn" type="submit" value="ADD TO CARD" />
                         
                        <a href="voting?pid=${detail.id}" class="heart-icon"><span class="icon_star"></span></a>
                        </form>
                        <ul>
                            <li><b>Availability</b> <span>In Stock</span></li>
                            <li><b>Shipping</b> <span>01 day shipping. <samp>Free pickup today</samp></span></li>
                            <li><b>Quantitty In Stock</b> <span>${detail.quantity}</span></li>

                        </ul>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="product__details__tab">
                        <ul class="nav nav-tabs" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab"
                                   aria-selected="true">Description</a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab"
                                   aria-selected="false">Reviews <span>(${reviewsCount})</span></a>
                            </li>
                        </ul>

                        <div class="tab-content">
                            <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                <div class="product__details__tab__desc">
                                    <h6>Products Infomation</h6>
                                    <p>${detail.desciption}</p>
                                </div>
                            </div>

                            <div class="tab-pane" id="tabs-3" role="tabpanel">
                                <div class="product__details__tab__desc">
                                    <h6>Review:</h6>
                                    <c:forEach var="c" items="${listFeedback}">
                                        <p>- ${c.comment}</p>
                                    </c:forEach>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Product Details Section End -->

    <!-- Related Product Section Begin -->
    <section class="related-product">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title related__product__title">
                        <h2>Related Product</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <c:forEach var="item" items="${listProducts}">
                    <c:if test="${item.categoryId == detail.categoryId}">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="${item.imgURL}">
                                    <ul class="product__item__pic__hover">
                                        <li><a href="voting?pid=${item.categoryId}"><i class="fa fa-star"></i></a></li>
                                        <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                                    </ul>
                                </div>
                                <div class="product__item__text">
                                    <h6><a href="shopdetail?pid=${item.id}">${item.name}</a></h6>
                                    <h5>$ ${item.unitPrice}</h5>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>


            </div>
        </div>
    </section>
    <!-- Related Product Section End -->

    <jsp:include page="footer.jsp"/>

    <!-- Js Plugins -->
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/mixitup.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/main.js"></script>



</body>

</html>