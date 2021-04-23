<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
    <div id="layoutSidenav_content">
      <main>
        <div class="container-fluid">
          <h1 class="mt-4">Dashboard</h1>
          <ol class="breadcrumb mb-4">
            <c:choose>
            	<c:when test="${ not empty days }">
            		<li class="breadcrumb-item active">Thống kê trong vòng ${ days } ngày</li>
            	</c:when>
            	<c:otherwise>
            		<li class="breadcrumb-item active">Thống kê</li>
            	</c:otherwise>
            </c:choose>
          </ol>
          <div class="row">
            <div class="col-xl-3 col-md-6">
              <div class="card bg-primary text-white mb-4">
                <div class="card-body"><h4>${ pendingOrders } </h4>đơn hàng chờ xử lý</div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                  <a class="small text-white stretched-link" href="${ base }/admin/pending-orders">Xem chi tiết</a>
                  <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6">
              <div class="card bg-warning text-white mb-4">
                <div class="card-body"><h4>${ deliveringOrders } </h4>đơn hàng đang giao</div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                  <a class="small text-white stretched-link" href="${ base }/admin/delivering-orders">Xem chi tiết</a>
                  <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6">
              <div class="card bg-success text-white mb-4">
                <div class="card-body"><h4>${ successfulOrders } </h4>đơn hàng thành công</div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                  <a class="small text-white stretched-link" href="${ base }/admin/successful-orders">Xem chi tiết</a>
                  <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6">
              <div class="card bg-danger text-white mb-4">
                <div class="card-body"><h4>${ canceledOrders } </h4>đơn hàng đã hủy</div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                  <a class="small text-white stretched-link" href="${ base }/admin/canceled-orders">Xem chi tiết</a>
                  <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                </div>
              </div>
            </div>
          </div>
          <div class="mb-3">
          	<a href="${ base }/admin" class="btn btn-secondary">Tất cả</a>
          	<a href="${ base }/admin/limit/1" class="btn btn-info">1 ngày</a>
          	<a href="${ base }/admin/limit/3" class="btn btn-info">3 ngày</a>
          	<a href="${ base }/admin/limit/7" class="btn btn-info">7 ngày</a>
          	<a href="${ base }/admin/limit/30" class="btn btn-info">30 ngày</a>
          </div>
          <div class="card mb-4">
            <div class="card-header">
              <i class="fas fa-table mr-1"></i>
              <c:choose>
            	<c:when test="${ not empty days }">
            		Danh sách đơn hàng trong vòng ${ days } ngày
            	</c:when>
            	<c:otherwise>
            		Danh sách đơn hàng
            	</c:otherwise>
              </c:choose>
            </div>
            <div class="card-body">
              <p>Click vào <a href="${ base }/admin/sale-orders">đây</a> để xem chi tiết</p>
              <c:if test="${ not empty days }">
       		      <div class="table-responsive">
	                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
	                  <thead>
	                    <tr>
	                      <th>Họ tên</th>
	                      <th>Email</th>
	                      <th>Tổng cộng</th>
	                      <th>Ngày tạo</th>
	                      <th>Trạng thái</th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                  	<c:forEach items="${ saleOrders }" var="saleOrder">
	                  	  <tr>
	                  	  	<td>${ saleOrder.customerName }</td>
		                    <td>${ saleOrder.customerEmail }</td>
		                    <td>
		                      <fmt:setLocale value="vi_VI"/>
		                  	  <fmt:formatNumber type="currency" maxFractionDigits = "0" value = "${ saleOrder.total }" />
		                  	</td>
		                  	<td>
		               	      <fmt:formatDate pattern = "dd-MM-YYYY  HH:mm" value = "${ saleOrder.createdDate }" />
		               	    </td>
		               	    <td>${ saleOrder.orderStatus }</td>
	                  	  </tr>
	                  	</c:forEach>
	                  </tbody>
	                </table>
	              </div>
       	      </c:if>
            </div>
          </div>
          <div class="card mb-4">
            <div class="card-header">
              <i class="fas fa-table mr-1"></i>
              <c:choose>
            	<c:when test="${ not empty days }">
            		Danh sách người dùng mới trong vòng ${ days } ngày
            	</c:when>
            	<c:otherwise>
            		Danh sách người dùng
            	</c:otherwise>
              </c:choose>
            </div>
            <div class="card-body">
              <p>Click vào <a href="${ base }/admin/users">đây</a> để xem chi tiết</p>
              <c:if test="${ not empty days }">
                  <div class="table-responsive">
	                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
	                  <thead>
	                    <tr>
	                      <th>Tên tài khoản</th>
	                      <th>Họ tên</th>
	                      <th>Email</th>
	                      <th>Ngày tạo</th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                  	<c:forEach items="${ userList }" var="user">
	                  	  <tr>
	                  	  	<td>${ user.username }</td>
		                    <td>${ user.fullname }</td>
		                    <td>${ user.email }</td>
		                  	<td>
		               	      <fmt:formatDate pattern = "dd-MM-YYYY  HH:mm" value = "${ user.createdDate }" />
		               	    </td>
	                  	  </tr>
	                  	</c:forEach>
	                  </tbody>
	                </table>
	              </div>
              </c:if>
            </div>
          </div>
          <div class="card mb-4">
            <div class="card-header">
              <i class="fas fa-table mr-1"></i>
              Danh sách liên hệ
            </div>
            <div class="card-body">
              <p>Click vào <a href="${ base }/admin/contacts">đây</a> để xem chi tiết</p>
            </div>
          </div>
        </div>
      </main>
      <jsp:include page="/WEB-INF/views/back-end/common/footer.jsp"></jsp:include>
      <script src="${pageContext.request.contextPath}/assets/demo/chart-area-demo.js"></script>
      <script src="${pageContext.request.contextPath}/assets/demo/chart-bar-demo.js"></script>
  	  <script src="${pageContext.request.contextPath}/assets/demo/datatables-demo.js"></script>