<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
    <div id="layoutSidenav_content">
      <main>
        <div class="container-fluid">
          <h1 class="mt-4">Danh sách người dùng</h1>
          <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
            <li class="breadcrumb-item active">Danh sách người dùng</li>
          </ol>
          <div class="row ml-1">
          	<div>
          	  <div class="float-left mb-4">
		      	<a class="btn btn-primary" href="${ base }/admin/add-user">Thêm</a>
		      </div>
		    </div>
          </div>
          <div class="card mb-4">
            <div class="card-header">
              <i class="fas fa-table mr-1"></i>
              Danh sách người dùng
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Tài khoản</th>
                      <th>Họ tên</th>
                      <th>Email</th>
                      <th>Địa chỉ</th>
                      <th>Số điện thoại</th>
                      <th>Vai trò</th>
                      <th class="text-center">Status</th>
                      <th>Edit</th>
                      <th>Remove</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Tài khoản</th>
                      <th>Họ tên</th>
                      <th>Email</th>
                      <th>Địa chỉ</th>
                      <th>Số điện thoại</th>
                      <th>Vai trò</th>
                      <th class="text-center">Status</th>
                      <th>Edit</th>
                      <th>Remove</th>
                    </tr>
                  </tfoot>
                  <tbody>
                  	<c:forEach items="${ users }" var="user">
                  		<tr>
                  			<td>${ user.username }</td>
		                    <td>${ user.fullname }</td>
		                    <td>${ user.email }</td>
		                    <td>${ user.address }</td>
		                    <td>${ user.phone }</td>
		                    <td>${ user.roles[0].name }</td>
		                    <td>
		                    	<c:choose>
		                    		<c:when test="${ user.status }">
		                    			<h5 class="text-center text-success"><i class="fas fa-check-circle"></i></h5>
		                    		</c:when>
		                    		<c:otherwise>
		                    			<h5 class="text-center text-danger"><i class="fas fa-minus-circle"></i></h5>
		                    		</c:otherwise>
		                    	</c:choose>
		                    </td>
		                    <td><a href="${ base }/admin/edit-user/${ user.id }" class="btn btn-warning"><i class="fas fa-edit"></i></a></td>
		                    <td><button class="btn btn-danger delete-user" name="${ user.id }"><i class="fas fa-trash-alt"></i></button></td>
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
      <script>     
	      $(document).ready(function(){
	    	
	    	var table = $('#dataTable').DataTable();
 		     
  		    $('#dataTable').on('click', '.delete-user', function () {
  		      var answer = confirm("Bạn có muốn xóa bỏ người dùng " + $(this).parent().parent().children().first().text() + '?');
  	          if (answer === false) {
  	            return;
  	          }
  	          var name = $(this).attr('name');
  	          var selector = $(this);
  	          $.ajax({
  	            url: '/admin/users/delete/' + name,
  	            type: 'delete',
  	            contentType: "application/json",
  	            dataType: "json",
  	            success: function(jsonResult) {
  	              selector.parent().parent().remove();
  	              alert('Xóa thành công!');
  	            },
  	            error: function (jqXhr, textStatus, errorMessage) { // error callback 
  	            	alert('Có lỗi xảy ra.');
  	            }
  	          });
  		    });
	      });
      </script>
</body>
</html>