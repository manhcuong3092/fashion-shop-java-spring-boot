<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
            <div id="page-wrapper">
                <div class="container-fluid">
                	<div style="height: 50px;"></div>
                    <form:form method="post" action="${pageContext.request.contextPath}/admin/add-product"
						modelAttribute="product" enctype="multipart/form-data">
						<form:hidden path="id"/>
						<div class="form-group">
							<label>Category</label>
							<form:select class="form-control form-control-line"
								path="categories.id" id="category" >
								<form:options items="${categories}" itemValue="id"
									itemLabel="name" />
							</form:select>
						</div>
						<div class="form-group">
							<label>Title</label>
							<form:input type="text" class="form-control" path="title"
								id="title" />
							<small id="emailHelp" class="form-text text-muted"> Tối
								đa 15 kí tự. </small>
						</div>
						<div class="form-group">
							<label>Short Description</label>
							<form:input type="text" class="form-control"
								path="shortDescription" id="shortDescription" />
							<small id="emailHelp" class="form-text text-muted"> Sẽ
								hiển thị tại màn hình danh sách sản phẩm. </small>
						</div>
						<div class="form-group">
							<label>Giá bán</label>
							<form:input type="text" class="form-control" path="price"
								id="price" />
							<small id="emailHelp" class="form-text text-muted"> Đơn
								vị tính là VNĐ. </small>
						</div>

						<div class="form-group">
							<label>Details description</label>
							<form:textarea class="form-control summernote" name="editordata"
								path="detailDescription" id="detailDescription" />
						</div>
						<div class="form-group">
							<label>Avatar</label> <input type="file" name="productAvatar" >
						</div>
						<!-- 
						<div class="form-group">
							<input class="form-check-input" type="checkbox" value=""
								id="flexCheckDefault"> <label class="form-check-label"
								for="flexCheckDefault"> Default checkbox </label>
						</div>
						-->
						<button type="submit" class="btn btn-primary">Save</button>
					</form:form>
                </div>
            </div>
            <!-- /#page-wrapper -->

        </div>
        <!-- /#wrapper -->

        <!-- Js Plugins -->
    	<jsp:include page="/WEB-INF/views/back-end/common/js.jsp"></jsp:include>
        
		<script>
			$(document).ready(function() {
			  $('.summernote').summernote();
			});
		</script>
    </body>
</html>
