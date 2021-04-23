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
          <h2 class="mb-4">Thông tin người dùng</h2>
          <c:if test="${ not empty error }">
          	<div class="alert alert-danger" role="alert">
          		${ error }
			</div>
          </c:if>
          <form:form method="post" enctype="multipart/form-data" action='${pageContext.request.contextPath}/admin/add-user' modelAttribute="user">
          	<form:hidden path="id"/>
            <div class="form-group">
              <label>Tên tài khoản *</label>
              <form:input type="text" class="form-control" path="username" required="required" readonly="${ not empty user.username }" minLength="6" />
              <small id="emailHelp" class="form-text text-muted"></small>
            </div>
            <div class="form-group">
              <label>Mật khẩu *</label>
              <form:input type="password" class="form-control" path="password" required="required" minLength="8" readonly="${ not empty user.password }" />
            </div>
            <div class="form-group">
              <label>Họ tên *</label>
              <form:input type="text" class="form-control" path="fullname" requirerd="required" />
            </div>
            <div class="form-group">
              <label>Email *</label>
              <form:input type="email" class="form-control" path="email" requirerd="required" />
            </div>
            <div class="form-group">
              <label>Địa chỉ *</label>
              <form:input type="text" class="form-control" path="address" requirerd="required" />
            </div>
            <div class="form-group">
              <label>Số điện thoại *</label>
              <form:input type="text" pattern="[0-9]{10,11}" class="form-control" path="phone" requirerd="required" />
            </div>
            <div class="form-group">
          	  <c:if test = "${fn:length(user.avatar) > 0}">
			    <img src="${base}/upload/${user.avatar}" style='width:200px; height:200px; object-fit: center' alt='' />
			  </c:if>
			  <div class="mt-2"></div>
			  <form:hidden path="avatar"/>
              <label>Ảnh đại diện</label> <input type="file"  name="userAvatar">
            </div>
            <div class="form-group">
              <label>Vai trò *</label>
              <form:select class="form-control form-control-line" path="roles[0].id" id="role">
                <form:options items="${roles}" itemValue="id" itemLabel="name" />
              </form:select>
            </div>
            <div class="form-check">
              <form:checkbox class="form-check-input" path="status" id="flexCheckDefault"/>
              <label class="form-check-label" for="flexCheckDefault">
                Active
              </label>
            </div>
            <button type="submit" class="btn btn-primary mt-3">Lưu</button>
          </form:form>
        </div>
      </main>
      <jsp:include page="/WEB-INF/views/back-end/common/footer.jsp"></jsp:include>
   </body>
</html>