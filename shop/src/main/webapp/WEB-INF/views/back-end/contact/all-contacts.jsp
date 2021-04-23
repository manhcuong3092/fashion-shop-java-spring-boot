<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>

<!-- JSTL -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/back-end/common/header.jsp"></jsp:include>
    <div id="layoutSidenav_content">
      <main>
        <div class="container-fluid">
          <h1 class="mt-4">Liên hệ</h1>
          <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
            <li class="breadcrumb-item active">Liên hệ</li>
          </ol>
          <div class="card mb-4">
            <div class="card-header">
              <i class="fas fa-table mr-1"></i>
              Danh sách liên hệ
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <tr>
                      <th>Họ tên</th>
                      <th>Email</th>
                      <th>Nội dung</th>
                      <th>Ngày gửi</th>
                      <th class="text-center">Trạng thái</th>
                      <th>Hành động</th>
                      <th>Xóa</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Họ tên</th>
                      <th>Email</th>
                      <th>Nội dung</th>
                      <th>Ngày gửi</th>
                      <th class="text-center">Trạng thái</th>
                      <th>Hành động</th>
                      <th>Xóa</th>
                    </tr>
                  </tfoot>
                  <tbody>
                  	<c:forEach items="${ contacts }" var="contact">
                  		<tr id="contact_${ contact.id }">
	                      <td>${ contact.name }</td>
	                      <td>${ contact.email }</td>
	                      <td>${ contact.content }</td>
	                      <td><fmt:formatDate pattern = "dd-MM-YYYY  hh:mm" value = "${contact.createdDate}" /></td>
	                      <td id="contact_${ contact.id }_status">
	                      	<c:choose>
	                      		<c:when test="${ contact.status }">
	                      			<p class="text-success">Đã phản hồi</p>
	                      		</c:when>
	                      		<c:otherwise>
	                      			<p class="text-secondary">Chưa phản hồi</p>
	                      		</c:otherwise>
	                      	</c:choose>
	                      </td>
	                      <td id="contact_${ contact.id }_action">
	                      	<c:if test="${ !contact.status }">
	                      		<button class="btn btn-success" onclick="responseContact(${contact.id})"><i class="fas fa-clipboard-check"></i></button>
	                      	</c:if>
	                      </td>
	                      <td><button class="btn btn-secondary" onclick="deleteContact(${contact.id})"><i class="fas fa-trash-alt"></i></button></td>
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