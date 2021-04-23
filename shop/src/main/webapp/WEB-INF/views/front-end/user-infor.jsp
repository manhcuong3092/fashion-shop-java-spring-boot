	<jsp:include page="/WEB-INF/views/front-end/common/header.jsp"></jsp:include>
	<jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
	<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
	<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
    <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
    
    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text">
                        <a href="/home"><i class="fa fa-home"></i> Trang chủ</a>
                        <span>Thông tin người dùng</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Form Section Begin -->

    <!-- Register Section Begin -->
    <div class="register-login-section spad">
        <div class="container">
            <div class="row">
            	<div class="col-lg-1"></div>
                <div class="col-lg-10">
                	<c:if test="${ not empty success }">
                		<div class="alert alert-success" role="alert">
						  ${ success }
						</div>
                	</c:if>
                	<c:if test="${ not empty error }">
                		<div class="alert alert-danger" role="alert">
						  ${ error }
						</div>
                	</c:if>
                    <div class="register-form">
                    	<div class="register-form">
                    		<h2>Thông tin người dùng</h2>
                    		<form action="${ base }/user-infor" method="POST" enctype="multipart/form-data">
                    			<input type="hidden" value="${ user.id }" name="id"/>
                    			<div class="mb-3">
                    				<label class="form-label" for="avatar">Ảnh đại diện</label>
                    				<div>
                    					<img src="${ base }/upload/${ user.avatar }" style="max-width: 250px; max-height: 250px">
                    				</div>
                    				<input class="form-control mt-3" id="avatar" type="file" name="userAvatar"/>
                    			</div>
                   				<div class="group-input">
                   					<label for="fullname">Họ tên *</label>
                   					<input id="fullname" type="text" name="fullname" value="${ user.fullname }" required/>
                   				</div>
                   				<div class="group-input">
                   					<label for="email">Email *</label>
                   					<input id="email" type="email" name="email" value="${ user.email }" required/>
                   				</div>
                   				<div class="group-input">
                   					<label for="phone">Số điện thoại *</label>
                   					<input id="phone" type="text" pattern="[0-9]{10,11}" name="phoneNumber" value="${ user.phone }" required/>
                   				</div>
                   				<div class="group-input">
                   					<label for="address">Địa chỉ *</label>
                   					<input id="address" type="text" name="address" value="${ user.address }" required/>
                   				</div>
                   				<button class="site-btn register-btn" type="submit">Thay đổi</button>
                   			</form>
                   		</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Register Form Section End -->
    
<jsp:include page="/WEB-INF/views/front-end/common/footer.jsp"></jsp:include>