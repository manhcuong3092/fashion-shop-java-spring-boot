<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Paging -->
<%@ taglib prefix="tag" uri="/WEB-INF/taglibs/pagingTagLibs.tld"%>
<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
    <div id="layoutSidenav_content">
      <main>
        <div class="container-fluid">
          <h1 class="mt-4">Đơn hàng</h1>
          <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
            <li class="breadcrumb-item active">Order</li>
          </ol>
          <div class="row ml-1">
          	<div class="float-left mb-4 mr-4">
			    <a class="btn btn-primary" href="${ base }/admin/sale-orders">Tất cả đơn hàng</a>
			</div>
          	<div class="float-left mb-4 mr-4"">
			    <a class="btn btn-secondary" href="${ base }/admin/pending-orders">Chờ xử lý</a>
			</div>
			<div class="float-left mb-4 mr-4"">
			    <a class="btn btn-warning" href="${ base }/admin/delivering-orders">Đang giao</a>
			</div>
			<div class="float-left mb-4 mr-4"">
			    <a class="btn btn-success" href="${ base }/admin/successful-orders">Đã giao</a>
			</div>
			<div class="float-left mb-4 mr-4"">
			    <a class="btn btn-danger" href="${ base }/admin/canceled-orders">Đã hủy</a>
			</div>
          </div>
          <div class="card mb-4">
            <div class="card-header">
              <i class="fas fa-table mr-1"></i>
              Danh sách đơn hàng
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Mã đơn hàng</th>
                      <th>Họ tên</th>
                      <th>Địa chỉ</th>
                      <th>Sản phẩm</th>
                      <th>Tổng tiền</th>
                      <th>Ngày đặt</th>
                      <th class="text-center">Trạng thái</th>
                      <th>Chi tiết</th>
                      <th>Hành động</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Mã đơn hàng</th>
                      <th>Họ tên</th>
                      <th>Địa chỉ</th>
                      <th>Sản phẩm</th>
                      <th>Tổng tiền</th>
                      <th>Ngày đặt</th>
                      <th class="text-center">Trạng thái</th>
                      <th>Chi tiết</th>
                      <th>Hành động</th>
                    </tr>
                  </tfoot>
                  <tbody>
                  	<c:forEach items="${ saleOrders }" var="saleOrder">
                  	  <tr id="row_order_${ saleOrder.id }">
                  	  	<td>${ saleOrder.code }</td>
                  	    <td>${ saleOrder.customerName }</td>
                  	    <td>${ saleOrder.customerAddress }</td>
                  	    <td>
                  	    	<c:forEach items="${ saleOrder.saleOrderProducts }" var="item">
	                  	    	<p>${ item.product.title } - ${ item.size } - ${ item.color } x ${ item.quantity }</p>
	                  	    </c:forEach>
                  	    </td>
                  	    <td>
                  	    	<fmt:setLocale value="vi_VI"/>
                  	    	<fmt:formatNumber type="currency" maxFractionDigits = "0" value = "${ saleOrder.total }" />
                  	    </td>
                  	    <td>
                  	    	<fmt:formatDate pattern = "dd-MM-YYYY  HH:mm" value = "${ saleOrder.createdDate }" />
                  	    </td>
                  	    <td id="order_${ saleOrder.id }_status">
                  	    	<c:choose>
                  	    		<c:when test="${ saleOrder.orderStatus == 'Chờ xử lý' }">
                  	    			<p class="text-secondary">${ saleOrder.orderStatus }</p>
                  	    		</c:when>
                  	    		<c:when test="${ saleOrder.orderStatus == 'Đang giao hàng' }">
                  	    			<p class="text-primary">${ saleOrder.orderStatus }</p>
                  	    		</c:when>
                  	    		<c:when test="${ saleOrder.orderStatus == 'Giao hàng thành công' }">
                  	    			<p class="text-success">${ saleOrder.orderStatus }</p>
                  	    		</c:when>
                  	    		<c:when test="${ saleOrder.orderStatus == 'Đã hủy' }">
                  	    			<p class="text-danger">${ saleOrder.orderStatus }</p>
                  	    		</c:when>
                  	    	</c:choose>
                  	    </td>
                  	    <td><a href="/admin/order/${ saleOrder.code }" class="btn btn-info m-1"><i class="fas fa-info-circle"></i></a></td>
                  	    <td id="order_${ saleOrder.id }">
                  	    	<c:if test="${ saleOrder.orderStatus == 'Chờ xử lý' }">
                  	    		<button class="btn btn-warning m-1" onclick="changeStatus(${saleOrder.id},'Đang giao hàng')"><i class="fas fa-shipping-fast"></i></button>
                  	    		<button class="btn btn-danger m-1" onclick="changeStatus(${saleOrder.id},'Đã hủy')"><i class="fas fa-times"></i></button>
                  	    	</c:if>
	                        <c:if test="${ saleOrder.orderStatus == 'Đang giao hàng' }">
                  	    		<button class="btn btn-success m-1" onclick="changeStatus(${saleOrder.id},'Giao hàng thành công')"><i class="fas fa-clipboard-check"></i></button>
                  	    		<button class="btn btn-danger m-1" onclick="changeStatus(${saleOrder.id},'Đã hủy')"><i class="fas fa-times"></i></button>
                  	    	</c:if>
	                        <button class="btn btn-secondary m-1" onclick="deleteOrder(${saleOrder.id})"><i class="fas fa-trash"></i></button>
                  	    </td>
                  	  </tr>
                  	</c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </main>
      <jsp:include page="/WEB-INF/views/back-end/common/footer.jsp"></jsp:include>
</body>

</html>