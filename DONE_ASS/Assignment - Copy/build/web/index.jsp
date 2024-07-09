<%-- 
    Document   : index
    Created on : May 28, 2024, 9:55:13 PM
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
    </head>

    <body>

        <!-- Header -->
        <jsp:include page="header.jsp"/>
        <!-- Header end -->

        <!-- Hero Section Begin -->
        <section class="hero hero-normal">
            <div class="container">
                <div class="row">
                    <jsp:include page="left.jsp"/>

                </div>
            </div>
        </div>
    </section>
    <section class="breadcrumb-section set-bg" >
        <div class="container">
            <div class="row">
                <div class="hero__item set-bg col-lg-12" data-setbg="img/hero/banner.jpg">
                    <div class="hero__text">
                        <span>FRUIT FRESH</span>
                        <h2>Vegetable <br />100% Organic</h2>
                        <p>Free Pickup and Delivery Available</p>
                        <a href="shopgrid" class="primary-btn">SHOP NOW</a>
                    </div>
                </div>  
            </div>
        </div>
    </section>



    <!-- Hero Section End -->

    <!-- Featured Section Begin -->
    <section class="featured spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h2>Featured Product</h2>
                    </div>
                    <div class="featured__controls">
                        <ul>
                            <li class="" >
                                <a style="color: #7FAD39" href="home">All</a>
                            </li>
                            <c:forEach var="category" items="${listCategory}">
                                <li class="" >
                                    <a style="color: #7FAD39" href="category?cid=${category.categoryId}">${category.categoryName}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="row featured__filter">
                <c:forEach var="item" items="${listProducts}">
                    <!-- Loop through the categories to find the matching category ID -->
                    <c:forEach var="category" items="${listCategory}">
                        <c:if test="${category.categoryId == item.categoryId}">
                            <div class="col-lg-3 col-md-4 col-sm-6 mix ${category.categoryName}">
                                <div class="featured__item">
                                    <div class="featured__item__pic set-bg" data-setbg="${item.imgURL}">
                                        <ul class="featured__item__pic__hover">
                                            <li><a href="voting?pid=${item.id}"><i class="fa fa-star"></i></a></li>
                                            <li><a href="cart?id=${item.id}&num=1&link=index.jsp"><i class="fa fa-shopping-cart"></i></a></li>
                                        </ul>
                                    </div>
                                    <div class="featured__item__text">
                                        <h6><a href="shopdetail?pid=${item.id}">${item.name}</a></h6>
                                        <h5>${item.getFormattedUnitPrice()}$</h5>
                                        <%-- <p>${category.discription}</p>   --%>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:forEach>
            </div>
        </div>
    </section>



    <!-- Featured Section End -->

    <!-- Banner Begin -->
    <div class="banner">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="banner__pic">
                        <img src="img/banner/banner-1.jpg" alt="">
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="banner__pic">
                        <img src="img/banner/banner-2.jpg" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Banner End -->

    <!-- Latest Product Section Begin -->
    <section class="latest-product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="latest-product__text">
                        <h4>Latest Products</h4>
                        <div class="latest-product__slider owl-carousel">
                            <div class="latest-prdouct__slider__item">
                                <c:forEach var="item" items="${list6Last}" varStatus="status">
                                    <c:if test="${status.index < 3}">
                                        <div class="latest-product__slider owl-carousel">
                                            <div class="latest-prdouct__slider__item">
                                                <a href="shopdetail?pid=${item.id}" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="${item.imgURL}" alt="">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>${item.name}</h6>
                                                        <span>${item.getFormattedUnitPrice()}$</span>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>

                            </div>
                            <div class="latest-prdouct__slider__item">
                                <c:forEach var="item" items="${list6Last}" varStatus="status">
                                    <c:if test="${status.index >= 3 && status.index < 6}">
                                        <div class="latest-product__slider owl-carousel">
                                            <div class="latest-prdouct__slider__item">
                                                <a href="shopdetail?pid=${item.id}" class="latest-product__item">
                                                    <div class="latest-product__item__pic">
                                                        <img src="${item.imgURL}" alt="">
                                                    </div>
                                                    <div class="latest-product__item__text">
                                                        <h6>${item.name}</h6>
                                                        <span>${item.getFormattedUnitPrice()}$</span>
                                                    </div>
                                                </a>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="latest-product__text">
                        <h4>Top Rated Products</h4>
                        <%-- in ra 3 cái đầu --%>
                        <div class="latest-product__slider owl-carousel">
                            <div class="latest-prdouct__slider__item">
                                <c:forEach var="item" items="${listTopRate}" varStatus="status">
                                    <c:if test="${status.index < 3}">
                                        <a href="shopdetail?pid=${item.id}" class="latest-product__item">
                                            <div class="latest-product__item__pic">
                                                <img src="${item.imgURL}" alt="">
                                            </div>
                                            <div class="latest-product__item__text">
                                                <h6>${item.name}</h6>
                                                <span>${item.getFormattedUnitPrice()}$</span>
                                            </div>
                                        </a>
                                    </c:if>
                                </c:forEach>
                            </div>

                            <%-- 3 cái sau --%>
                            <div class="latest-product__slider owl-carousel">
                                <c:forEach var="item" items="${listTopRate}" varStatus="status">
                                    <c:if test="${status.index >= 3 && status.index < 6}">
                                        <div class="latest-prdouct__slider__item">
                                            <a href="shopdetail?pid=${item.id}" class="latest-product__item">
                                                <div class="latest-product__item__pic">
                                                    <img src="${item.imgURL}" alt="">
                                                </div>
                                                <div class="latest-product__item__text">
                                                    <h6>${item.name}</h6>
                                                    <span>${item.getFormattedUnitPrice()} $</span>
                                                </div>
                                            </a>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="latest-product__text">
                        <h4>Review Products</h4>
                        <div class="latest-product__slider owl-carousel">
                            <div class="latest-prdouct__slider__item">
                                <c:forEach var="item" items="${listReview}" varStatus="status">
                                    <c:if test="${status.index < 3}">
                                        <a href="shopdetail?pid=${item.id}" class="latest-product__item">
                                            <div class="latest-product__item__pic">
                                                <img src="${item.imgURL}" alt="">
                                            </div>
                                            <div class="latest-product__item__text">
                                                <h6>${item.name}</h6>
                                                <span>${item.getFormattedUnitPrice()} $</span>
                                            </div>
                                        </a>
                                    </c:if>
                                </c:forEach>
                            </div>

                            <%-- 3 cái sau --%>
                            <div class="latest-product__slider owl-carousel">
                                <c:forEach var="item" items="${listReview}" varStatus="status">
                                    <c:if test="${status.index >= 3 && status.index < 6}">
                                        <div class="latest-prdouct__slider__item">
                                            <a href="shopdetail?pid=${item.id}" class="latest-product__item">
                                                <div class="latest-product__item__pic">
                                                    <img src="${item.imgURL}" alt="">
                                                </div>
                                                <div class="latest-product__item__text">
                                                    <h6>${item.name}</h6>
                                                    <span>${item.getFormattedUnitPrice()} $</span>
                                                </div>
                                            </a>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Latest Product Section End -->


    <!-- Footer Section Begin -->
    <jsp:include page="footer.jsp"/>
    <!-- Footer Section End -->

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
