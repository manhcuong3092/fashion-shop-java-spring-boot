<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Paging -->
<%@ taglib prefix="tag" uri="/WEB-INF/taglibs/pagingTagLibs.tld"%>
<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
    <div id="layoutSidenav_content">
      <main>
        <div class="container-fluid">
          <h1 class="mt-4">Sản phẩm</h1>
          <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li>
            <li class="breadcrumb-item active">Sản phẩm</li>
          </ol>
          <div class="row ml-1">
          	<div>
           	  <nav class="float-left navbar-light pb-3">
			  <!-- <form class="form-inline" action='${ base }/admin/products/search-all' method='GET'>
			    <input class="form-control mr-sm-2" name='searchText' type="search" placeholder="Search" aria-label="Search">
			    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			  </form> -->
		      </nav>
		      <div class="float-left mb-4">
		      	<a class="btn btn-primary" href="${ base }/admin/add-product">Thêm</a>
		      </div>
            </div>
          </div>
          <div class="card mb-4">
            <div class="card-header">
              <i class="fas fa-table mr-1"></i>
              Danh sách sản phẩm
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Tên</th>
                      <th>Danh mục</th>
                      <th>Ảnh đại diện</th>
                      <th>Giá</th>
                      <th>Giá khuyến mại</th>
                      <th>Đối tượng</th>
                      <th class="text-center">Trạng thái</th>
                      <th>Chỉnh sửa</th>
                      <th>Xóa</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Tên</th>
                      <th>Danh mục</th>
                      <th>Ảnh đại diện</th>
                      <th>Giá</th>
                      <th>Giá khuyến mại</th>
                      <th>Đối tượng</th>
                      <th class="text-center">Trạng thái</th>
                      <th>Chỉnh sửa</th>
                      <th>Xóa</th>
                    </tr>
                  </tfoot>
                  <tbody>
                  	<c:forEach items="${ products }" var="product">
                      <tr>
			            <td>${product.title }</td>
			            <td>${product.category.name }</td>
			            <td>
			            	<img src="${base }/upload/${product.avatar}" style="width: 80px; height: 80px;" class="mx-auto "/>
			            </td>
			            <td><fmt:setLocale value="vi_VI"/>
                  	    	<fmt:formatNumber type="currency" maxFractionDigits = "0" value = "${ product.price }" /></td>
		          	    <c:choose>
			          	  <c:when test= "${not empty product.priceSale }">
			          	    <td><fmt:setLocale value="vi_VI"/>
                  	    	<fmt:formatNumber type="currency" maxFractionDigits = "0" value = "${product.priceSale }" /></td>
			          	  </c:when>
			          	  <c:otherwise>
						     <td></td>
						  </c:otherwise>
		          	    </c:choose>
		          	    <td>${product.gender }</td>
			            <c:choose>
			          	  <c:when test= "${product.status }">
			          	    <td class="text-center text-success"><h5><i class="fas fa-check-circle"></i></h5></td>
			          	  </c:when>
			          	  <c:otherwise>
						     <td class="text-center text-danger"><h5><i class="fas fa-minus-circle"></i></h5></td>
						  </c:otherwise>
		          	    </c:choose>
		          	    <td><a class="btn btn-warning" href="${pageContext.request.contextPath}/admin/edit-product/${product.id}"><i class="fas fa-edit"></i></a></td>
                        <td><button class="btn btn-secondary delete-product" name="${product.id}"><i class="fas fa-trash-alt"></i></button></td>
			          </tr>
                  	</c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          <!-- 
          <div class="pagination justify-content-center">
              <div class="row">
              	<div class="col-lg-3"></div>
              	<div class="col-lg-9 d-flex-justify-content-center rounded">
              		<tag:paginate offset="${productSearch.offset }" count="${productSearch.count }" uri="${pageUrl}" />
              	</div>
              </div>
          </div> -->
        </div>
      </main>
      <jsp:include page="/WEB-INF/views/back-end/common/footer.jsp"></jsp:include>
      <script>     
	      $(document).ready(function(){
	    	var table = $('#dataTable').DataTable();
	 		     
	  		$('#dataTable').on('click', '.delete-product', function () {
	          var answer = confirm("Bạn có muốn xóa bỏ sản phẩm " + $(this).parent().parent().children().first().text() + '?');
	          if (answer === false) {
	            return;
	          }
	          var name = $(this).attr('name');
	          var selector = $(this);
	          $.ajax({
	            url: '/admin/products/delete/' + name,
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