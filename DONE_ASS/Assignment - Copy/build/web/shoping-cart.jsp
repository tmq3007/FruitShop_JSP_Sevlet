<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">

    <head>
        <meta charset="UTF-8">
        <meta name="description" content="Ogani Template">
        <meta name="keywords" content="Ogani, unica, creative, html">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Ogani | Template</title>

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
                            <h2>Shopping Cart</h2>
                            <div class="breadcrumb__option">
                                <a href="./index.html">Home</a>
                                <span>Shopping Cart</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End -->

        <!-- Shoping Cart Section Begin -->
        <section class="shoping-cart spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="shoping__cart__table">
                            <table>
                                <thead>
                                    <tr>
                                        <th class="shoping__product">Products</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody id="cart-items">


                                    <c:set var="o" value="${sessionScope.cart}"/>
                                    <c:forEach items="${o.items}" var="i">
                                        <tr class="cart-item" data-item-id="2">
                                            <td class="shoping__cart__item">
                                                <img style="width:100px;" src="${i.product.imgURL}" alt="">
                                                <h5>${i.product.name}</h5>
                                            </td>
                                            <td class="shoping__cart__price"><span class="item-price"><fmt:formatNumber pattern="##.##" value="${i.price}"/>$</span></td>
                                            <td class="shoping__cart__quantity">
                                                <div class="quantity">
                                                    <button class="qty-btn minus"><a href="process?num=-1&id=${i.product.id}">-</a></button>
                                                    <span class="quantity-input" data-price="${i.price}">${i.quantity}</span>
                                                    <button class="qty-btn plus"><a href="process?num=1&id=${i.product.id}">+</a></button>
                                                </div>
                                            </td>
                                            <td class="shoping__cart__total"><span class="item-total"><fmt:formatNumber pattern="##.##" value="${i.price*i.quantity}"/>$</span></td>
                                            <td class="shoping__cart__item__close">

                                                <form  action="process" method="post">
                                                    <input type="hidden" name="id" value="${i.product.id}"/>
                                                    <input type="submit" value="Delete" />
                                                </form>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <h5 style="color: red; font-weight: bold">${error}</h5>                 
                <div class="row">

                    <div class="col-lg-6">
                        <div class="shoping__cart__btns">
                            <a href="home" class="primary-btn cart-btn">CONTINUE SHOPPING</a>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="shoping__checkout">
                            <h5>Cart Total</h5>
                            
                                <ul>
                                    <li>Total <span id="subtotal"><fmt:formatNumber pattern="##.##" value="${totalMoney}"/>$</span></li>
                                </ul>
                                <a href="checkout.jsp" class="primary-btn">PROCEED TO CHECKOUT</a>

                            </form

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Shoping Cart Section End -->

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
