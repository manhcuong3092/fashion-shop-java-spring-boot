<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
    <div id="layoutSidenav_content">
      <main>
        <div style="height: 50px;"></div>
        <div class="container-fluid">
          <h2 class="mb-4">Thêm sản phẩm</h2>
          <c:if test="${ not empty error }">
          	<div class="alert alert-danger" role="alert">
			  ${ error }
			</div>
          </c:if>
          <form:form method="post" enctype="multipart/form-data" action='${pageContext.request.contextPath}/admin/add-product' modelAttribute="product" >
          	<form:hidden path="id"/>
            <div class="form-group">
              <label>Danh mục *</label>
              <form:select class="form-control form-control-line" path="category.id" id="category">
                <form:options items="${categories}" itemValue="id" itemLabel="name" />
              </form:select>
            </div>
            <div class="form-group">
              <label>Tiêu đề *</label>
              <form:input type="text" class="form-control" id="title" path="title" />
              <small id="emailHelp" class="form-text text-muted"></small>
            </div>
            <div class="form-group">
              <label>Giá bán *</label>
              <form:input type="text" class="form-control" id="price" path="price" />
              <small id="emailHelp" class="form-text text-muted"> USD </small>
            </div>
            <div class="form-group">
              <label>Giá khuyến mại *</label>
              <form:input type="text" class="form-control" id="priceSale" path="priceSale" />
              <small id="emailHelp" class="form-text text-muted"> USD </small>
            </div>
            <div class="form-group">
              <label>Mô tả *</label>
              <form:input type="text" class="form-control" id="shortDescription" path="shortDescription" />
              <small id="emailHelp" class="form-text text-muted"> Show in product </small>
            </div>
            <div class="form-group">
              <label>Chi tiết sản phẩm *</label>
              <form:textarea class="form-control summernote" name="editordata" id="detailDescription" path="detailDescription"></form:textarea>
            </div>
            <div class="form-group">
              <label>Đối tượng *</label>
              <form:select class="form-control form-control-line" path="gender" id="gender">
                <form:option value="Tất cả" itemLabel="Tất cả" />
                <form:option value="Nam" itemLabel="Nam" />
                <form:option value="Nữ" itemLabel="Nữ" />
                <form:option value="Trẻ em" itemLabel="Trẻ em" />
              </form:select>
            </div>
            <div class="form-group" id="sizes-form-container">
            	<label>Kích cỡ</label>
            	<button class="btn btn-primary mb-2 ml-2" id="add-size" type="button">Thêm</button>
            	<c:choose>
			        <c:when test = "${fn:length(product.sizes) == 0}">
			            <form:hidden path="sizes[0].id"/>
		       			<form:input class="form-control product-size" type="text" path="sizes[0].name"/><br/>
			        </c:when>
			        <c:otherwise>
			            <c:forEach items="${product.sizes}" varStatus="count" var="size">
		           			<form:hidden path="sizes[${count.index}].id"/>
			       			<form:input class="form-control product-size" type="text" path="sizes[${count.index}].name"/><br/>
				    	</c:forEach>
			        </c:otherwise>
		        </c:choose>
            </div>
            <div class="form-group" id="colors-form-container">
            	<label>Màu</label>
            	<button class="btn btn-primary mb-2 ml-2" id="add-color" type="button">Thêm</button>
            	<c:choose>
			        <c:when test = "${fn:length(product.colors) == 0}">
			            <form:hidden path="colors[0].id"/>
		       			<form:input class="form-control product-color" type="text" path="colors[0].name"/><br/>
			        </c:when>
			        <c:otherwise>
			            <c:forEach items="${product.colors}" varStatus="count" var="color">
		           			<form:hidden path="colors[${count.index}].id"/>
			       			<form:input class="form-control product-color" type="text" path="colors[${count.index}].name"/><br/>
				    	</c:forEach>
			        </c:otherwise>
		        </c:choose>
            </div>
            <div class="form-group">
              <div class="mb-3">
              	<c:if test = "${fn:length(product.avatar) > 0}">
			      <img src="${pageContext.request.contextPath}/upload/${product.avatar}" style='width:200px; height:200px; object-fit: center' alt='' />
			    </c:if>
              </div>
              <label>Ảnh đại diện</label> <input type="file" name="productAvatar">
            </div>
            <div class="form-group">
              <form:hidden path="avatar"/>
              <label>Ảnh sản phẩm (nhiều)</label> <input type="file" name="images" multiple="multiple">
            </div>
            <div class="form-check">
              <form:checkbox class="form-check-input" path="status" id="flexCheckDefault"/>
              <label class="form-check-label" for="flexCheckDefault">
                Active
              </label>
            </div>
            <button type="submit" class="btn btn-primary mt-3">Save</button>
          </form:form>
        </div>
      </main>
      
  <jsp:include page="/WEB-INF/views/back-end/common/footer.jsp"></jsp:include>
  <script>
    $(document).ready(function () {
      $('.summernote').summernote();

      $('#add-size').click(function(){
    	var index = $('.product-size').length;
        $('#sizes-form-container').append('<input type="hidden" id="sizes' + length +'.id' + '" name="sizes[' + index + '].id"/>' + 
        '<input id="sizes' + length +'.name' + '" class="form-control product-size" type="text" name="sizes[' + index + '].name"/><br/>')
      })

      $('#add-color').click(function(){
    	var index = $('.product-color').length;
        $('#colors-form-container').append('<input type="hidden" id="colors' + length +'.id' + '" name=colors[' + index + '].id"/>' + 
        '<input id="colors' + length +'.name' + '" class="form-control product-color" type="text" name="colors[' + index + '].name"/><br/>')
      })
    }); 
  </script>
</body>

</html>