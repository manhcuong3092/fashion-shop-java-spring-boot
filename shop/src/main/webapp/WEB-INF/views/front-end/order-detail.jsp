    <jsp:include page="/WEB-INF/views/front-end/common/header.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
    <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="tag" uri="/WEB-INF/taglibs/pagingTagLibs.tld"%>
    <!-- Header End -->

    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text product-more">
                        <a href="/home"><i class="fa fa-home"></i> Trang chủ</a>
                        <a href="/order">Lịch sử mua hàng</a>
                        <span>Chi tiết đơn hàng</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Section Begin -->

    <!-- Shopping Cart Section Begin -->
    <section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="cart-table">
                        <table>
                            <thead>
                                <tr>
                                    <th>Ảnh</th>
                                    <th class="p-name">Tên sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Kích cỡ</th>
                                    <th>Màu</th>
                                    <th>Số lượng</th>
                                    <th>Tổng Cộng</th>
                                    <th><i class="ti-close"></i></th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${ order.saleOrderProducts }" var="item">
                            		<tr>
                                    <td class="cart-pic first-row"><img src="${ base }/upload/${ item.product.avatar }" alt=""></td>
                                    <td class="cart-title first-row">
                                        <h5>${ item.product.title }</h5>
                                    </td>
                                    <td class="p-price first-row">
                                    	<fmt:formatNumber value="${ item.price }" maxFractionDigits="0"/> &#8363;
                                    </td>
                                    <td class="first-row"><h5>${ item.size }</h5></td>
                                    <td class="first-row"><h5>${ item.color }</h5></td>
                                    <td class="first-row">
                                        <h5>${ item.quantity }</h5>
                                    </td>
                                    <td class="total-price first-row">
                                    	<fmt:formatNumber value="${ item.price*item.quantity }" maxFractionDigits="0"/> &#8363;
                                    </td>
                                    <td class="close-td first-row"><i class="ti-close"></i></td>
                                </tr>
                            	</c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="cart-buttons">
                                <a href="${ base }/shop" class="primary-btn continue-shop">Tiếp tục mua sắm</a>
                            </div>
                        </div>
                        <div class="col-lg-4 offset-lg-4">
                            <div class="proceed-checkout">
                                <ul>
                                    <!-- <li class="subtotal">Subtotal <span>$240.00</span></li> -->
                                    <li>Tổng cộng 
                                    	<span class="cart-total">
                                    		<fmt:formatNumber value="${ order.total }" maxFractionDigits="0"/> &#8363;
										</span>
									</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shopping Cart Section End -->

<jsp:include page="/WEB-INF/views/front-end/common/footer.jsp"></jsp:include>
