<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>  
   <jsp:include page="/WEB-INF/views/common/variables.jsp"></jsp:include>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!-- Partner Logo Section Begin -->
    <div class="partner-logo">
        <div class="container">
            <div class="logo-carousel owl-carousel">
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-1.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-2.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-3.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-4.png" alt="">
                    </div>
                </div>
                <div class="logo-item">
                    <div class="tablecell-inner">
                        <img src="img/logo-carousel/logo-5.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Partner Logo Section End -->

    <!-- Footer Section Begin -->
    <footer class="footer-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="footer-left">
                        <div class="footer-logo">
                            <a href="#"><img src="img/footer-logo.png" alt=""></a>
                        </div>
                        <ul>
                            <li>Địa chỉ: 60-49 Mai dịch, Cầu giấy, Hà Nội</li>
                            <li>Số điện thoại: +84 357.393.099</li>
                            <li>Email: Cuongdm3092@gmail.com</li>
                        </ul>
                        <div class="footer-social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-pinterest"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 offset-lg-1">
                    <div class="footer-widget">
                        <h5>Thông tin</h5>
                        <ul>
                            <li><a href="${ base }/contact">Về chúng tôi</a></li>
                            <li><a href="${ base }/check-out">Thanh toán</a></li>
                            <li><a href="${ base }/contact">Liên hệ</a></li>
                            <li><a href="#">Serivius</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-2">
                    <div class="footer-widget">
                        <h5>Tài khoản của tôi</h5>
                        <ul>
                            <li><a href="${ base }/user-infor">Tài khoản</a></li>
                            <li><a href="${ base }/contact">Liên hệ</a></li>
                            <li><a href="${ base }/cart">Giỏ hàng</a></li>
                            <li><a href="${ base }/shop">Shop</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="newslatter-item">
                        <h5>Đăng ký nhận tin ngay bây giờ</h5>
                        <p>Nhận email cập nhật về sản phẩm mới nhất và khuyến mãi đặc biệt.</p>
                        <form method="post" class="subscribe-form">
                            <input type="email" placeholder="Nhập email của bạn" id="subscriber_email">
                            <button type="button" onclick="SaveSubscriber();" class="site-btn">Đăng ký</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="copyright-reserved">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="copyright-text">
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </div>
                        <div class="payment-pic">
                            <img src="img/payment-method.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- Footer Section End -->

    <jsp:include page="/WEB-INF/views/front-end/common/js.jsp"></jsp:include>
     <!-- Js Plugins -->
    <script>
	    function SaveSubscriber() {
	    	// javascript object.
			var data = {};
	    	//data["Tên thuộc tính"] (getter, setter)
			data["email"] = $("#subscriber_email").val();
	    	if(data["email"].length == 0 || data["email"].indexOf('@') == -1){
	    		alert('Hãy nhập đúng email');
	    		return;
	    	}
			$.ajax({
				url: "/subscriber",
				type: "post",
				contentType: "application/json",
				data: JSON.stringify(data),
				
				dataType: "json",
				success: function(jsonResult) {
					if(jsonResult.status == 200) {
						$("#subscriber_email").val('');
						$(".toast").remove();
			            var notification = `
						  <div class="toast" style="position: fixed; top: 50px; right: 50px;">
						    <div class="toast-header">
						      <img src="/img/tick-xanh.png" class="rounded mr-2" style="width:20px; height:20px;" alt="...">
						      <strong class="mr-auto">Thông báo</strong>
						      <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
						        <span aria-hidden="true">&times;</span>
						      </button>
						    </div>
						    <div class="toast-body">
						    	Đăng ký nhận tin thành công
						    </div>
						  </div>
			            	`;
			            $('body').append(notification);
			            $(".toast").toast({ delay: 3000 });
			            $('.toast').toast('show');
					} else {
						alert('error');
					}
				},
				error: function (jqXhr, textStatus, errorMessage) { // error callback 
			        
			    }
			});
		}
    </script>
</body>

</html>