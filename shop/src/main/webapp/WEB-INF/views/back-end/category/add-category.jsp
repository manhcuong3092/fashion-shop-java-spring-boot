<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
    <div id="layoutSidenav_content">
      <main>
        <div style="height: 50px;"></div>
        <div class="container-fluid">
          <h2 class="mb-4">Thêm danh mục</h2>
          <form:form method="post" action='${pageContext.request.contextPath}/admin/add-category' modelAttribute="category">
          	<form:hidden path="id"/>
            <div class="form-group">
              <label>Tên *</label>
              <form:input type="text" class="form-control" path="name" />
              <small id="emailHelp" class="form-text text-muted"> </small>
            </div>
            <div class="form-group">
              <label>Mô tả *</label>
              <form:input type="text" class="form-control" path="description" />
            </div>
            <div class="form-group">
              <label>Danh mục cha *</label>
              <form:select class="form-control form-control-line" path="parentId" id="category">
              	<form:option value="${ null }">Không có</form:option>
                <form:options items="${categories}" itemValue="id" itemLabel="name" />
              </form:select>
            </div>
            <button type="submit" class="btn btn-primary mt-3">Lưu</button>
          </form:form>
        </div>
      </main>
      <jsp:include page="/WEB-INF/views/back-end/common/footer.jsp"></jsp:include>
</body>

</html>