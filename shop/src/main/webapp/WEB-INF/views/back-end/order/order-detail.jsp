<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Paging -->
<%@ taglib prefix="tag" uri="/WEB-INF/taglibs/pagingTagLibs.tld"%>
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
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
                      <th>Tên sản phẩm</th>
                      <th>Ảnh</th>
                      <th>Kích cỡ</th>
                      <th>Màu</th>
                      <th>Đơn giá</th>
                      <th>Số lượng</th>
                      <th>Tổng tiền</th>
                    </tr>
                  </thead>
                  <tfoot class="font-weight-bold">
			      	<tr>
			      		<td>Tổng cộng</td>
			            <td></td>
			            <td></td>
			            <td></td>
			            <td></td>
			            <td></td>
		          	    <td><fmt:setLocale value="vi_VI"/>
	                 	    	<fmt:formatNumber type="currency" maxFractionDigits = "0" value = "${ saleOrder.total }" /></td>
			      	</tr>    
			      </tfoot>
                  <tbody>
                  	<c:forEach items="${ saleOrder.saleOrderProducts }" var="item">
                      <tr>
			            <td>${ item.product.title }</td>
			            <td>
			            	<img src="${base }/upload/${ item.product.avatar}" style="width: 80px; height: 80px;" class="mx-auto "/>
			            </td>
			            <td>${item.size }</td>
			            <td>${item.color }</td>
			            <td><fmt:setLocale value="vi_VI"/>
                  	    	<fmt:formatNumber type="currency" maxFractionDigits = "0" value = "${ item.price }" /></td>
		          	    <td>${item.quantity }</td>
		          	    <td><fmt:setLocale value="vi_VI"/>
                  	    	<fmt:formatNumber type="currency" maxFractionDigits = "0" value = "${ item.price*item.quantity }" /></td>
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