    <%@page import="org.springframework.security.core.userdetails.UserDetails"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<jsp:include page="/WEB-INF/views/front-end/common/header.jsp"></jsp:include>
    <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text product-more">
                        <a href="/index"><i class="fa fa-home"></i> Trang chủ</a>
                        <a href="/cart">Giỏ hàng</a>
                        <span>Thanh toán</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Section Begin -->

    <!-- Shopping Cart Section Begin -->
    <section class="checkout-section spad">
        <div class="container">
        	<c:if test="${ not empty error }">
        		<div class="alert alert-warning alert-dismissible fade show" role="alert">
				  <strong>Xảy ra lỗi!</strong> ${ error }, hãy kiểm tra lại.
				  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
				    <span aria-hidden="true">&times;</span>
				  </button>
				</div>
        	</c:if>
            <form action="/check-out" method='POST' class="checkout-form">
                <div class="row">
                	<%
							boolean isLogined = false;
							Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
							if (principal instanceof UserDetails) {
								isLogined = true;
							}
						%>
					<% if(!isLogined) { %>
						<c:if test="${ not empty success }">
			        		<div class="alert alert-success col-lg-12" role="alert">
							    <h4 class="alert-heading">Đặt hàng thành công!</h4>
							    <p>Đơn hàng của bạn đã được chúng tôi ghi lại, chúng tôi sẽ sớm liên hệ với bạn.</p>
							</div>
			        	</c:if>
                    	<div class="col-lg-6">
							<div class="checkout-content">
	                            <a href="#" class="content-btn">Click vào đây để đăng nhập</a>
	                        </div>
	                        <h4>Thông tin người mua</h4>
	                        <div class="row">
	                            <div class="col-lg-12">
	                                <label for="fullname">Họ tên<span>*</span></label>
	                                <input type="text" name="fullname" id="fullname" required="required">
	                            </div>
	                            <div class="col-lg-12">
	                                <label for="address">Địa chỉ<span>*</span></label>
	                                <input type="text" name="address" id="address" required="required" class="street-first">
	                            </div>
	                            <div class="col-lg-12">
	                                <label for="email">Email<span>*</span></label>
	                                <input type="email" name="email" id="email" required="required">
	                            </div>
	                            <div class="col-lg-12">
	                                <label for="phone">Số điện thoại<span>*</span></label>
	                                <input type="text" name="phone" id="phone" pattern="[0-9]{10,11}" required="required">
	                                <small class="form-text text-muted" style="margin-top: -20px;">Số điện thoại gồm 10-11 số.</small>
	                            </div>
	                        </div>
                    	</div>
                    	<div class="col-lg-6">
	                        <div class="checkout-content">
	                            <input type="text" placeholder="Nhập mã giảm giá">
	                        </div>
	                        <div class="place-order">
	                            <h4>Đơn đặt hàng của bạn</h4>
	                            <div class="order-total">
	                                <ul class="order-table">
	                                    <li>Sản phẩm <span>Tổng cộng</span></li>
	                                    <c:forEach items="${ cart.cartItems }" var="item">
	                                    	<li class="fw-normal">${ item.productName } - ${ item.size } - ${ item.color } x ${ item.quantity }<span><fmt:formatNumber value="${ item.priceUnit*item.quantity }" maxFractionDigits="0"/></span></li>
	                                    </c:forEach>
	                                    <!-- <li class="fw-normal">Subtotal <span>$240.00</span></li> -->
	                                    <li class="total-price">Tổng cộng 
		                                    <span>
		                                    	<fmt:formatNumber value="${ totalPrice }" maxFractionDigits="0"/> &#8363;
		                                    </span>
	                                    </li>
	                                </ul>
	                                <div class="order-btn">
	                                    <button type="submit" class="site-btn place-btn">Đặt hàng</button>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
                    <% } else { %>
                    	<div class="col-lg-2"></div>
	                    <div class="col-lg-8">
	                    	<c:if test="${ not empty success }">
				        		<div class="alert alert-success" role="alert">
								    <h4 class="alert-heading">Đặt hàng thành công!</h4>
								    <p>Đơn hàng của bạn đã được chúng tôi ghi lại, chúng tôi sẽ sớm liên hệ với bạn.</p>
								    <hr>
								    <p class="mb-0">Để kiểm tra đơn hàng của bạn, hãy click vào <strong><a href="${ base }/order">Đây</a></strong> để xem chi tiết.</p>
								</div>
				        	</c:if>
	                        <div class="checkout-content">
	                            <input type="text" placeholder="Nhập mã giảm giá">
	                        </div>
	                        <div class="place-order">
	                            <h4>Đơn đặt hàng của bạn</h4>
	                            <div class="order-total">
	                                <ul class="order-table">
	                                    <li>Sản phẩm <span>Tổng cộng</span></li>
	                                    <c:forEach items="${ cart.cartItems }" var="item">
	                                    	<li class="fw-normal">${ item.productName } - ${ item.size } - ${ item.color } x ${ item.quantity }<span><fmt:formatNumber value="${ item.priceUnit*item.quantity }" maxFractionDigits="0"/></span></li>
	                                    </c:forEach>
	                                    <!-- <li class="fw-normal">Subtotal <span>$240.00</span></li> -->
	                                    <li class="total-price">Tổng cộng 
		                                    <span>
		                                    	<fmt:formatNumber value="${ totalPrice }" maxFractionDigits="0"/> &#8363;
		                                    </span>
	                                    </li>
	                                </ul>
	                                <div class="order-btn">
	                                    <button type="submit" class="site-btn place-btn">Đặt hàng</button>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                <% } %>
                </div>
            </form>
        </div>
    </section>
    <!-- Shopping Cart Section End -->

<jsp:include page="/WEB-INF/views/front-end/common/footer.jsp"></jsp:include>