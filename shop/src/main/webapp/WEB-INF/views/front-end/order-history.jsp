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
                        <span>Lịch sử mua hàng</span>
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
                                    <th class="pl-4" style="text-align: left;">Mã đơn hàng</th>
                                    <th style="text-align: left;">Sản phẩm</th>
                                    <th>Tổng tiền</th>
                                    <th>Ngày mua</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:forEach items="${ saleOrders }" var="order">
                            		<tr>
                                    <td class="first-row pl-4" style="text-align: left;">
                                        <h5><a href="${ base }/order/${ order.seo }">${ order.seo }</a></h5>
                                    </td>
                                    <td class="first-row" style="text-align: left;">
                                    	<c:forEach items="${ order.saleOrderProducts }" var="item">
                                    		<h5>${ item.product.title } - ${ item.size } - ${ item.color } x ${ item.quantity }</h5>
                                    	</c:forEach>
                                    </td>
                                    <td class="p-price first-row">
                                    	<fmt:formatNumber value="${ order.total }" maxFractionDigits="0"/> &#8363;
                                    </td>
                                    
                                    <td class="first-row"><h5><fmt:formatDate type = "date" value = "${ order.createdDate }" /></h5></td>
                                    <td class="qua-col first-row">
                                    	<h5>${ order.orderStatus }</h5>
                                    </td>
                                </tr>
                            	</c:forEach>
                            </tbody>
                        </table>
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
	    var productId = $(this).attr('name');
	    var totalPrinceItem =  $(this).parent().parent().parent().find('.total-price');
	    
	    if(!parseInt(quantity)){
	    	$(this).parent().find('input').val('1');
	    	return;
	    }

	    var data = {
	      productId: productId,
	      quantity: parseInt(quantity)
	    }

	    $.ajax({
	      url: '/cart/changeQuantity/' + productId,
	      type: "post",
	      contentType: "application/json",
	      data: JSON.stringify(data),
	      dataType: "json",
	      success: function(objectData) {
	    	  $("#totalCart").text(objectData.data.totalItems);
	          $(".totalPrice").html(objectData.data.totalPrice.toLocaleString('vi-VI', { style: 'currency', currency: 'VND' }));
	          $(".cart-total").html(objectData.data.totalPrice.toLocaleString('vi-VI', { style: 'currency', currency: 'VND' }));
	          let productItem = objectData.data.cartItems.find(function(item){
	        	 return item.productId == productId;
	          });
	          totalPrinceItem.html((productItem.priceUnit*productItem.quantity).toLocaleString('vi-VI', { style: 'currency', currency: 'VND' }));
	      },
	      error: function (jqXhr, textStatus, errorMessage) { // error callback 
	    	  alert('error')
	      }
	    });
	  });
</script>
