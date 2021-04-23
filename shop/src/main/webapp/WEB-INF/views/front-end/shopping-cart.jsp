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
                        <span>Giỏ hàng</span>
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
                            	<c:forEach items="${ cart.cartItems }" var="item">
                            		<tr id="${item.productId}__${item.size}__${item.color}">
                                    <td class="cart-pic first-row"><img src="${ base }/upload/${ item.avatar }" alt=""></td>
                                    <td class="cart-title first-row">
                                        <h5>${ item.productName }</h5>
                                    </td>
                                    <td class="p-price first-row">
                                    	<fmt:formatNumber value="${ item.priceUnit }" maxFractionDigits="0"/> &#8363;
                                    </td>
                                    <td class="first-row p-size"><h5>${ item.size }</h5></td>
                                    <td class="first-row p-color"><h5>${ item.color }</h5></td>
                                    <td class="qua-col first-row">
                                        <div class="quantity">
                                            <div class="pro-qty" name="${item.productId}&&${item.size}&&${item.color}">
                                            	<span class="dec qtybtn">-</span>
                                                <input type="number" value="${ item.quantity }">
                                                <span class="inc qtybtn">+</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="total-price p-price first-row">
                                    	<fmt:formatNumber value="${ item.priceUnit*item.quantity }" maxFractionDigits="0"/> &#8363;
                                    </td>
                                    <td class="close-td first-row"><i class="ti-close" onclick="Cart.deleteItem(${ item.productId }, '${ item.size }', '${ item.color }')"></i></td>
                                </tr>
                            	</c:forEach> 
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="cart-buttons">
                                <a href="#" class="primary-btn continue-shop">Tiếp tục mua sắm</a>
                            </div>
                        </div>
                        <div class="col-lg-4 offset-lg-4">
                            <div class="proceed-checkout">
                                <ul>
                                    <!-- <li class="subtotal">Subtotal <span>$240.00</span></li> -->
                                    <li>Tổng cộng 
                                    	<span class="cart-total">
                                    		<fmt:formatNumber value="${ totalPrice }" maxFractionDigits="0"/> &#8363;
										</span>
									</li>
                                </ul>
                                <a href="${ base }/check-out" class="proceed-btn">Nhấn để thanh toán </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shopping Cart Section End -->

<jsp:include page="/WEB-INF/views/front-end/common/footer.jsp"></jsp:include>
<script>
	$('.pro-qty').click(function () {
	    var quantity = $(this).parent().find('input').val();
	    var productInfor = $(this).attr('name');
	    var prodcutDetail = productInfor.split("&&");
	    var productId = prodcutDetail[0];
	    var size = prodcutDetail[1];
	    var color = prodcutDetail[2];
	    
	    if(!parseInt(quantity)){
	    	$(this).parent().find('input').val('1');
	    	return;
	    }
	    var totalPriceItemHtml =  $(this).parent().parent().parent().find('.total-price');

	    Cart.changeQuantity(productId, size, color, quantity, totalPriceItemHtml);
	  });
</script>
