<%-- 
    Document   : left
    Created on : Jun 3, 2024, 9:52:19 AM
    Author     : admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<!-- Hero Section Begin -->

<div class="col-lg-3">
    <div class="hero__categories">
        <div class="hero__categories__all">
            <i class="fa fa-bars"></i>
            <span>All departments</span>
        </div>
        <ul>
            <li class="active" data-filter="*">
                <a href="home">All</a>
            </li>
            <c:forEach var="item" items="${listCategory}">
                <li  >
                    <a href="category?cid=${item.categoryId}">${item.categoryName}</a>
                </li>
            </c:forEach>

        </ul>

    </div>
</div>
<div class="col-lg-9">
    <div class="hero__search">
        <div class="hero__search__form">
            <form action="search" method="post">
                <div class="hero__search__categories">
                    Categories
                    
                </div>
                <input value="${txtParam}" name="txt" type="text" placeholder="What do you need?">
                <button type="submit" class="site-btn">SEARCH</button>
            </form>
        </div>
        <div class="hero__search__phone">
            <div class="hero__search__phone__icon">
                <i class="fa fa-phone"></i>
            </div>
            <div class="hero__search__phone__text">
                <h5>0838734373</h5>
                <span>support 24/7 time</span>
            </div>
        </div>
    </div>
</div>
<!-- Hero Section End -->
