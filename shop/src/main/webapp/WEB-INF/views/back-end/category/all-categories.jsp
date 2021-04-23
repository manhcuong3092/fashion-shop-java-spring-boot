<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
    <div id="layoutSidenav_content">
      <main>
        <div class="container-fluid">
          <h1 class="mt-4">Danh mục</h1>
          <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
            <li class="breadcrumb-item active">Danh mục</li>
          </ol>
          <div class="row ml-1">
          	<div class="float-right">
	          <a class="btn btn-primary" href="${ base }/admin/add-category">Thêm</a>
	        </div>
          </div>
          <div class="card mt-4">
            <div class="card-header">
              <i class="fas fa-table mr-1"></i>
              Danh mục sản phẩm
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Tên</th>
                      <th>Mô tả</th>
                      <th class="text-center">Trạng thái</th>
                      <th>Sửa</th>
                      <th>Xóa</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Tên</th>
                      <th class="text-center">Trạng thái</th>
                      <th>Sửa</th>
                      <th>Xóa</th>
                    </tr>
                  </tfoot>
                  <tbody>
                    <c:forEach items="${ categories }" var="category">
                      <tr>
			            <td>${category.name }</td>
			            <td>${category.description }</td>
			            <c:choose>
			          	  <c:when test= "${category.status }">
			          	    <td class="text-center text-success"><h5><i class="fas fa-check-circle"></i></h5></td>
			          	  </c:when>
			          	  <c:otherwise>
						     <td class="text-center text-danger"><h5><i class="fas fa-minus-circle"></i></h5></td>
						  </c:otherwise>
		          	    </c:choose>
		          	    <td><a class="btn btn-warning" href="${pageContext.request.contextPath}/admin/edit-category/${category.id}"><i class="fas fa-edit"></i></a></td>
                        <td><button class="btn btn-danger delete-category" name="${category.id}"><i class="fas fa-trash-alt"></i></button></td>
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
	      $('#error-message').hide();
	      $('#success-message').hide();
	      
	      $(document).ready(function(){
	        $('.delete-category').click(function(){
	          var answer = confirm("Bạn có muốn xóa bỏ sản phẩm " + $(this).parent().parent().children().first().text() + '?');
	          if (answer === false) {
	            return;
	          }
	          var name = $(this).attr('name');
	          var selector = $(this);
	          $.ajax({
	            url: '/admin/categories/delete/' + name,
	            type: 'delete',
	            contentType: "application/json",
	            dataType: "json",
	            success: function(jsonResult) {
	              selector.parent().parent().remove();
	              alert('Xóa ' + jsonResult.data.name + ' thành công!');
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