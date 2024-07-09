<%-- 
    Document   : shop-grid
    Created on : May 28, 2024, 10:01:51 PM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
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

        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
        <!-- Css Styles -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css">
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">
        <style>
            .product__pagination {
                margin-top: 20px; /* Để tạo khoảng cách giữa phân trang và các phần khác */
            }

            .product__pagination input {
                border: 1px solid #ccc; /* Đường viền xung quanh các nút phân trang */
                padding: 5px 10px; /* Kích thước lề và nội dung trong các nút phân trang */
                cursor: pointer; /* Con trỏ chuột chuyển thành dấu gạch ngang khi di chuột qua */
                background-color: #f2f2f2; /* Màu nền mặc định của các nút phân trang */
                color: #333; /* Màu văn bản mặc định */
                margin-right: 5px; /* Khoảng cách giữa các nút phân trang */
            }

            .product__pagination input.active {
                background-color: #7FAD39; /* Màu nền của nút phân trang khi đang hoạt động */
                color: #fff; /* Màu văn bản của nút phân trang khi đang hoạt động */
                border-color: #7FAD39; /* Đường viền xung quanh nút phân trang khi đang hoạt động */
                /* Các thuộc tính khác cho trạng thái hoạt động */
            }

        </style>
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
                            <h2>Organi Shop</h2>
                            <div class="breadcrumb__option">
                                <a href="home">Home</a>
                                <span>Shop</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Breadcrumb Section End -->

        <!-- Product Section Begin -->
        <form action="shopgrid" method="post" id="priceForm">
            <section class="product spad">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3 col-md-5">
                            <div class="sidebar">

                                <div class="sidebar__item">
                                    <h4>Price</h4>
                                    <div class="price-range-wrap">
                                        <div id="slider-range" class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content" data-min="0" data-max="10">
                                            <div class="ui-slider-range ui-corner-all ui-widget-header"></div>
                                            <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                                            <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                                        </div>
                                        <div class="range-slider">
                                            <div class="price-input">
                                                <label style="color: #DD2222; font-weight: bold;">$</label>
                                                <input type="text" id="minamount" name="minamount" value="${sessionScope.from}">
                                                <label style="color: #DD2222; font-weight: bold;">$</label>
                                                <input type="text" id="maxamount" name="maxamount" value="${sessionScope.to}">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sidebar__item sidebar__item__color--option">
                                        <h4>Category</h4>
                                        <div>
                                            <input type="checkbox" id="all" name="department" value="-1" ${fn:contains(requestScope.selectedCategories, '-1') ? 'checked' : ''}>
                                            <label for="all">All</label>

                                        </div>
                                        <c:forEach var="item" items="${listCategory}">
                                            <div>
                                                <input type="checkbox" id="${item.categoryId}" name="department" value="${item.categoryId}" ${fn:contains(requestScope.selectedCategories, item.categoryId) && !fn:contains(requestScope.selectedCategories, '-1') ? 'checked' : ''}>
                                                <label for="${item.categoryId}">${item.categoryName}</label>
                                            </div>
                                        </c:forEach>
                                    </div>

                                </div>

                                <!-- <div class="sidebar__item">
                    <h4>Popular Size</h4>
                    <div class="sidebar__item__size">
                        <label for="large">
                            Large
                            <input type="radio" id="large">
                        </label>
                    </div>
                    <div class="sidebar__item__size">
                        <label for="medium">
                            Medium
                            <input type="radio" id="medium">
                        </label>
                    </div>
                    <div class="sidebar__item__size">
                        <label for="small">
                            Small
                            <input type="radio" id="small">
                        </label>
                    </div>
                    <div class="sidebar__item__size">
                        <label for="tiny">
                            Tiny
                            <input type="radio" id="tiny">
                        </label>
                    </div>
                </div> -->


                                <div class="sidebar__item">
                                    <div class="latest-product__text">
                                        <h4>Latest Products</h4>
                                        <div class="latest-product__slider owl-carousel">
                                            <div class="latest-prdouct__slider__item">
                                                <c:forEach var="item" items="${list6Last}" varStatus="status">
                                                    <c:if test="${status.index < 3}">
                                                        <div class="latest-product__item">
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
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                            <div class="latest-prdouct__slider__item">
                                                <c:forEach var="item" items="${list6Last}" varStatus="status">
                                                    <c:if test="${status.index >= 3 && status.index < 6}">
                                                        <div class="latest-product__item">
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
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-9 col-md-7">
                            <div class="product__discount">
                                <div class="section-title product__discount__title">
                                    <h2>Sale Off</h2>
                                </div>
                                <div class="row">
                                    <div class="product__discount__slider owl-carousel">
                                        <c:forEach var="item" items="${listProductDiscount}">
                                            <div class="col-lg-4">
                                            <div class="product__discount__item">
                                                <div class="product__discount__item__pic set-bg" data-setbg="${item.imgURL}">
                                                    <div class="product__discount__percent">${item.getDiscountInt()}%</div>
                                                    <ul class="product__item__pic__hover">
                                                        <li><a href="voting?pid=${item.categoryId}"><i class="fa fa-star"></i></a></li>
                                                        <li><a href="cart2?id=${item.id}&num=1&link=shop-grid.jsp"><i class="fa fa-shopping-cart"></i></a></li>
                                                    </ul>
                                                </div>
                                                <div class="product__discount__item__text">
                                                    
                                                    <h5><a href="shopdetail?pid=${item.id}">${item.name}</a></h5>
                                                    <div class="product__item__price">${item.getFormattedUnitPrice()}$ <span>${item.unitPrice}$</span></div>
                                                </div>
                                            </div>
                                        </div>
                                        </c:forEach>
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="filter__item">
                                <div class="row">
                                    <div class="col-lg-9 col-md-6">
                                        <div class="filter__sort">
                                            <span>Sort By</span>
                                            <!-- HTML của select box -->
                                            <select name="sortOption" onchange="this.form.submit()">
                                                <option value="default" ${empty param.sortOption || param.sortOption eq 'default' ? 'selected' : ''}>Default</option>
                                                <option value="asc" ${param.sortOption eq 'asc' ? 'selected' : ''}>Price Asc</option>
                                                <option value="desc" ${param.sortOption eq 'desc' ? 'selected' : ''}>Price Desc</option>
                                            </select>

                                        </div>
                                    </div>
                                    <div class="col-lg-3 col-md-6">
                                        <div class="filter__found">
                                            <h6><span>${founded}</span> Products found</h6>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <c:forEach var="item" items="${listProducts}">
                                    <div class="col-lg-4 col-md-6 col-sm-6">
                                        <div class="product__item">
                                            <div class="product__item__pic set-bg" data-setbg="${item.imgURL}">
                                                <ul class="product__item__pic__hover">
                                                    <li><a href="voting?pid=${item.categoryId}"><i class="fa fa-star"></i></a></li>
                                                    <li><a href="cart2?id=${item.id}&num=1&link=shop-grid.jsp"><i class="fa fa-shopping-cart"></i></a></li>
                                                </ul>
                                            </div>
                                            <div class="product__item__text">
                                                <h6><a href="shopdetail?pid=${item.id}">${item.name}</a></h6>
                                                <h5>${item.getFormattedUnitPrice()}$</h5>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>

                            <div class="product__pagination">
                                <c:if test="${currentPage > 1}">
                                    <input class="previous-page" type="button" value="Previous Page" onclick="submitPreviousPage()" />
                                </c:if>
                                <c:forEach begin="1" end="${endP}" var="i">
                                    <c:set var="activeClass" value="${i == currentPage ? 'active' : ''}" />
                                    <input class="${activeClass}" type="submit" name="index" value="${i}" />
                                </c:forEach>
                                <input type="hidden" id="currentPage" name="index" value="${currentPage}" />
                                <c:if test="${currentPage < endP}">
                                    <input class="next-page" type="button" value="Next Page" onclick="submitNextPage()" />
                                </c:if>
                            </div>

                        </div>
                    </div>
                </div>
        </form>
    </section>

    <!-- Product Section End -->

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
    <script>
                                        function submitForm() {
                                            document.getElementById("sortForm").submit();
                                        }
    </script>
    <script>
        // JavaScript functions for pagination and form submission
        function submitPreviousPage() {
            var currentPage = parseInt("${currentPage}") - 1;
            document.getElementById('currentPage').value = currentPage;
            document.getElementById('priceForm').submit();
        }

        function submitNextPage() {
            var currentPage = parseInt("${currentPage}") + 1;
            document.getElementById('currentPage').value = currentPage;
            document.getElementById('priceForm').submit();
        }

        function submitPage(pageNumber) {
            document.getElementById('currentPage').value = pageNumber;
            document.getElementById('priceForm').submit();
        }
    </script>


    <script>
        $(document).ready(function () {
            var minAmountInput = $("#minamount");
            var maxAmountInput = $("#maxamount");
            var sliderRange = $("#slider-range");

            // Initialize the slider
            sliderRange.slider({
                range: true,
                min: 0,
                max: 10,
                values: [${sessionScope.from}, ${sessionScope.to}],
                slide: function (event, ui) {
                    minAmountInput.val(ui.values[0]);
                    maxAmountInput.val(ui.values[1]);
                },
                change: function (event, ui) {
                    // Do not submit immediately when the slider changes
                }
            });

            // Handle Enter key on minAmount input
            minAmountInput.keypress(function (event) {
                if (event.keyCode === 13) {
                    event.preventDefault();
                    alert("Price range selected: $" + minAmountInput.val() + " - $" + maxAmountInput.val());
                    $("#priceForm").submit();
                }
            });

            // Handle Enter key on maxAmount input
            maxAmountInput.keypress(function (event) {
                if (event.keyCode === 13) {
                    event.preventDefault();
                    alert("Price range selected: $" + minAmountInput.val() + " - $" + maxAmountInput.val());
                    $("#priceForm").submit();
                }
            });

            // Xử lý sự kiện khi nhấn phím Enter trên checkbox
            $("input[type='checkbox']").keypress(function (event) {
                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13') { // Kiểm tra nếu phím nhấn là Enter
                    submitPage(1); // Gửi yêu cầu đến server và quay về trang 1
                }
            });


// Xử lý sự kiện thay đổi giá sản phẩm
            $("#minamount, #maxamount").change(function () {
                submitPage(1); // Gửi yêu cầu đến server và quay về trang 1
            });


            // Handle Enter key for checkbox selections
            $(document).keypress(function (event) {
                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13') {
                    var selectedCategories = [];
                    $("input[type='checkbox']:checked").each(function () {
                        if ($(this).attr('id') === 'all') {
                            selectedCategories.push('All');
                        } else {
                            selectedCategories.push($(this).next('label').text());
                        }
                    });
                    alert("Selected categories: " + selectedCategories.join(', '));
                    $("#priceForm").submit();
                }
            });

            // Set initial values
            minAmountInput.val(sliderRange.slider("values", 0));
            maxAmountInput.val(sliderRange.slider("values", 1));
        });
    </script>

</body>

</html>
