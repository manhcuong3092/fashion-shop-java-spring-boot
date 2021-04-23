<!-- sử dụng tiếng việt -->
<%@page import="com.cuong.shop.entities.User"%>
<%@page import="org.springframework.security.core.userdetails.UserDetails"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>

<%
	boolean isLogined = false;
	String fullname = "Chưa đăng nhập";
	Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	if (principal instanceof UserDetails) {
		fullname = ((User)principal).getFullname();
		isLogined = true;
	}
%>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
    <meta name="description" content="Fashi Template">
    <meta name="keywords" content="Fashi, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Fashi | Shop thời trang</title>
    <jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>

    <!-- Css Styles -->
    <jsp:include page="/WEB-INF/views/front-end/common/css.jsp"></jsp:include>
    
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Header Section Begin -->
    <header class="header-section">
        <div class="header-top">
            <div class="container">
                <div class="ht-left">
                    <div class="mail-service">
                        <i class=" fa fa-envelope"></i>
                        <%= fullname %>
                    </div>
                </div>
                <div class="ht-right">
                	<% if(!isLogined) { %>
                    	<a href="/login" class="login-panel"><i class="fa fa-user"></i>Đăng nhập</a>
                    <% } else { %>
                    	<a href="/logout" class="login-panel"><i class="fa fa-user"></i>Đăng xuất</a>
                    <% } %>	
                    <div class="top-social">
                    	<a href="${ base }/admin">Admin</a>
                        <a href="#"><i class="ti-facebook"></i></a>
                        <a href="#"><i class="ti-twitter-alt"></i></a>
                        <a href="#"><i class="ti-linkedin"></i></a>
                        <a href="#"><i class="ti-pinterest"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="inner-header">
                <div class="row">
                    <div class="col-lg-2 col-md-2">
                        <div class="logo">
                            <a href="./index.html">
                                <img src="img/logo.png" alt="">
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-7 col-md-7">
                        <div class="advanced-search">
                            <button type="button" class="category-btn">Tất cả thể loại</button>
                            <div class="input-group">
                                <form method="GET" action="${ base }/shop/search-all">
                                	<input type="text" name="searchText" placeholder="Bạn muốn gì?">
                                	<button><i class="ti-search"></i></button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 text-right col-md-3">
                        <ul class="nav-right">
                            <li class="heart-icon">
                                <a href="#">
                                    <i class="icon_heart_alt"></i>
                                    <span></span>
                                </a>
                            </li>
                            <li class="cart-icon">
                                <a href="#">
                                    <i class="icon_bag_alt"></i>
                                    <span id="totalCart">${ total }</span>
                                </a>
                                <div class="cart-hover">
                                    <div class="select-items">
                                        <table>
                                            <tbody id="cart-items">
                                            	<c:forEach items="${ cart.cartItems }" var="item">
	                                            	<tr>
							    	                    <td class="si-pic"><img src="${ base }/upload/${item.avatar}" alt=""></td>
							    	                    <td class="si-text">
							    	                        <div class="product-selected">
							    	                            <p>
							    	                            	<fmt:formatNumber value="${ item.priceUnit }" maxFractionDigits="0"/> &#8363;
							    	                            	 x ${ item.quantity }
							    	                            </p>
							    	                            <h6>${ item.productName } - ${ item.size } - ${ item.color }</h6>
							    	                        </div>
							    	                    </td>
							    	                    <td class="si-close">
							    	                        <i class="ti-close" onclick="Cart.deleteItem(${ item.productId }, '${ item.size }', '${ item.color }')"></i>
							    	                    </td>
							    	                </tr>
							    	            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="select-total">
                                        <span>Tổng cộng:</span>
                                        <h5 class="total-price totalPrice"><fmt:formatNumber value="${ totalPrice }" maxFractionDigits="0"/> &#8363;</h5>
                                    </div>
                                    <div class="select-button">
                                        <a href="${ base }/cart" class="primary-btn view-card">Xem giỏ hàng</a>
                                        <a href="${ base }/check-out" class="primary-btn checkout-btn">Thanh toán</a>
                                    </div>
                                </div>
                            </li>
                            <li class="cart-price total-price totalPrice">
                            	<fmt:formatNumber value="${ totalPrice }" maxFractionDigits="0"/>
                            	&#8363;
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="nav-item">
            <div class="container">
                <div class="nav-depart">
                    <div class="depart-btn">
                        <i class="ti-menu"></i>
                        <span>Tất cả danh mục</span>
                        <ul class="depart-hover">
                            ${ menu }
                        </ul>
                    </div>
                </div>
                <nav class="nav-menu mobile-menu">
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/index">Trang chủ</a></li>
                        <li><a href="${pageContext.request.contextPath}/shop">Shop</a></li>
                        <li><a href="#">Bộ sưu tập</a>
                            <ul class="dropdown">
                                <li><a href="#">Nam</a></li>
                                <li><a href="#">Nữ</a></li>
                                <li><a href="#">Trẻ em</a></li>
                            </ul>
                        </li>
                        <li><a href="${pageContext.request.contextPath}/blog">Blog</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
                        <li><a href="#">Xem thêm</a>
                            <ul class="dropdown">
                                <li><a href="${pageContext.request.contextPath}/user-infor">Thông tin cá nhân</a></li>
                                <li><a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a></li>
                                <li><a href="${pageContext.request.contextPath}/check-out">Thanh toán</a></li>
                                <li><a href="${pageContext.request.contextPath}/order">Đơn hàng của tôi</a></li>
                                <li><a href="${pageContext.request.contextPath}/faq">Câu hỏi thường gặp</a></li>
                                <li><a href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
                                <li><a href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
                <div id="mobile-menu-wrap"></div>
            </div>
        </div>
    </header>
    <!-- Header End -->