<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zxx">
    <head>
        <meta charset="UTF-8" />
        <meta name="description" content="Ogani Template" />
        <meta name="keywords" content="Ogani, unica, creative, html" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Ogani | Template</title>

        <!-- Google Font -->
        <link
            href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap"
            rel="stylesheet"
            />

        <style>
            .body-rate {
                font-family: Arial, sans-serif;
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }

            .container-rate {
                background-color: white;
                padding: 10px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
                text-align: center;
                width: 300px;
            }

            h1 {
                font-size: 20px;
                margin: 0;
            }

            .rating {
                font-size: 16px;
                margin: 5px 0;
            }

            .stars {
                font-size: 20px;
                margin: 5px 0;
            }

            .star {
                cursor: pointer;
                margin: 0 2px;
            }

            textarea {
                width: 90%;
                padding: 5px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
            }

            input[type="submit"] {
                background-color: #7fad39;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                margin-top: 10px;
                display: inline-block;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            .reviews {
                margin-top: 10px;
                text-align: left;
            }


            .review {
                border: 1px solid #ccc;
                border-radius: 4px;
                padding: 10px;
                margin: 10px 0;
            }

            .review p {
                margin: 0;
            }

            .shoping__cart__item img {
                width: 200px;
                height: auto;
                margin-right: 20px;
            }

            .shoping__cart__item h5 {
                font-size: 18px;
                font-weight: bold;
                margin: 0;
            }

            input[type="radio"] {
                display: none;
            }

            .star {
                cursor: pointer;
                font-size: 20px;
            }

            input[type="radio"]:checked + .star i,
            .star:hover i,
            .star:hover ~ .star i {
                color: green;
            }

            .star i.checked {
                color: green;
            }
            
        </style>

        <!-- Css Styles -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css" />
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css" />
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css" />
        <link rel="stylesheet" href="css/nice-select.css" type="text/css" />
        <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css" />
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css" />
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css" />
        <link rel="stylesheet" href="css/style.css" type="text/css" />

    </head>

    <body>
        <%@ include file="header.jsp" %>

        <!-- Hero Section Begin -->
        <section class="hero hero-normal">
            <div class="container">
                <div class="row">
                    <%@ include file="left.jsp" %>
                </div>
            </div>
        </section>
        <!-- Hero Section End -->

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
                                        <th></th>
                                        <th>Rate</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="shoping__cart__item">
                                            <input type="hidden" name="new_pid" value="${requestScope.product.id}" />
                                            <img src="${requestScope.product.imgURL}" alt="" />
                                            <h5>${requestScope.product.name}</h5>
                                        </td>
                                        <td></td>
                                        <td class="shoping__cart__price">
                                            <div class="body-rate">
                                                <div class="container-rate">
                                                    <div class="rating">
                                                        <span id="rating">0</span>/5
                                                    </div>
                                                    <div class="stars" id="stars">
                                                        <form action="voting" method="post">
                                                            <input type="hidden" name="pid" value="${requestScope.product.id}" />
                                                            <input type="radio" id="star1" name="star" value="1" /><label for="star1" class="star" data-value="1"><i class="fa fa-star"></i></label>
                                                            <input type="radio" id="star2" name="star" value="2" /><label for="star2" class="star" data-value="2"><i class="fa fa-star"></i></label>
                                                            <input type="radio" id="star3" name="star" value="3" /><label for="star3" class="star" data-value="3"><i class="fa fa-star"></i></label>
                                                            <input type="radio" id="star4" name="star" value="4" /><label for="star4" class="star" data-value="4"><i class="fa fa-star"></i></label>
                                                            <input type="radio" id="star5" name="star" value="5" /><label for="star5" class="star" data-value="5"><i class="fa fa-star"></i></label>
                                                            <p>Share your review:</p>
                                                            <input id="review" type="text" name="review" placeholder="Write your review here" />
                                                            <br>
                                                            <input type="submit" value="Submit" />
                                                        </form>
                                                    </div>
                                                    <div class="reviews" id="reviews">
                                                        <c:if test="${not empty successMessage}">
                                                            <p style="color: green">${successMessage}</p>
                                                        </c:if>
                                                        <c:if test="${not empty error}">
                                                            <p style="color: red">${error}</p>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Shoping Cart Section End -->

        <%@ include file="footer.jsp" %>

        <!-- Js Plugins -->
        <script src="js/jquery-3.3.1.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.nice-select.min.js"></script>
        <script src="js/jquery-ui.min.js"></script>
        <script src="js/jquery.slicknav.js"></script>
        <script src="js/mixitup.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/main.js"></script>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const stars = document.querySelectorAll(".star");
                const rating = document.getElementById("rating");

                stars.forEach(star => {
                    star.addEventListener("click", function () {
                        const value = this.getAttribute("data-value");
                        rating.textContent = value;
                        updateStars(value);
                    });
                });

                function updateStars(value) {
                    stars.forEach(star => {
                        const starValue = star.getAttribute("data-value");
                        if (starValue <= value) {
                            star.querySelector("i").classList.add("checked");
                        } else {
                            star.querySelector("i").classList.remove("checked");
                        }
                    });
                }

                // Initialize stars based on the hidden rating value
                const initialRating = rating.textContent;
                if (initialRating) {
                    updateStars(initialRating);
                }
            });
        </script>

    </body>
</html>
