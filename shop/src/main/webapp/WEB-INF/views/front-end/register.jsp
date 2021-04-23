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
                        <span>Đăng ký</span>
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
                <div class="col-lg-6 offset-lg-3">
                    <div class="register-form">
                    	<c:if test="${ not empty error }">
                    		<div class="alert alert-danger" role="alert">
							  ${ error }
							</div>
                    	</c:if>
                        <h2>Đăng ký</h2>
                        <form:form action="${base}/register" method="POST" modelAttribute="userRegister">
                            <div class="group-input">
                                <label for="username">Tên tài khoản *</label>
                                <form:input type="text" path="username" name="username" id="username" minlength="5" required="required" />
                                <small class="form-text text-muted" id="emailHelp"> Tên tài khoản ít nhất 5 ký tự </small>
                            </div>
                            <div class="group-input">
                                <label for="pass">Mật khẩu *</label>
                                <form:input type="password" name="password" path="password" id="pass" minlength="8" required="required" />
                                <small class="form-text text-muted" id="emailHelp"> Mật khẩu gồm ít nhất 8 ký tự </small>
                            </div>
                            <div class="group-input">
                                <label for="con-pass">Xác nhận mật khẩu *</label>
                                <form:input type="password" name="confirmPassword" path="confirmPassword" id="con-pass" minlength="8" required="required" />
                            </div>
                            <div class="group-input">
                            	<label for="fullname">Họ tên *</label>
                            	<form:input id="fullname" path="fullName" type="text" name="fullName" required="required" />
                            </div>
	                        <div class="group-input">
	                        	<label for="email">Email *</label>
	                        	<form:input id="email" type="email" path="email" name="email" required="required" />
	                        </div>
	                        <div class="group-input">
		                        <label for="phone">Số điện thoại *</label>
		                        <form:input id="phone" type="tel" path="phone" name="phone" pattern="[0-9]{10,11}" required="required" />
		                        <small class="form-text text-muted" id="emailHelp"> Số điện thoại gồm 10-11 chữ số </small>
	                        </div>
	                        <div class="group-input">
		                        <label for="address">Địa chỉ *</label>
		                        <form:input id="address" type="address" path="address" name="address" required="required" />
	                        </div>
                            <button type="submit" class="site-btn register-btn">ĐĂNG KÝ</button>
                        </form:form>
                        <div class="switch-login">
                            <a href="${ base }/login" class="or-login">Đăng nhập</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Register Form Section End -->
    
<jsp:include page="/WEB-INF/views/front-end/common/footer.jsp"></jsp:include>