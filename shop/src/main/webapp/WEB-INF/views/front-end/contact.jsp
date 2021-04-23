<jsp:include page="/WEB-INF/views/front-end/common/header.jsp"></jsp:include>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>  
    
    <!-- Breadcrumb Section Begin -->
    <div class="breacrumb-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb-text">
                        <a href="#"><i class="fa fa-home"></i> Trang chủ</a>
                        <span>Liên hệ</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Breadcrumb Section Begin -->

    <!-- Map Section Begin -->
    <div class="map spad">
        <div class="container">
            <div class="map-inner">
            	<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d7447.6647804273825!2d105.7695445788713!3d21.039391465120183!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1svi!2s!4v1618642643462!5m2!1svi!2s" width="600" height="610" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                <div class="icon">
                    <i class="fa fa-map-marker"></i>
                </div>
            </div>
        </div>
    </div>
    <!-- Map Section Begin -->

    <!-- Contact Section Begin -->
    <section class="contact-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-5">
                    <div class="contact-title">
                        <h4>Liên hệ</h4>
                        <p>Bạn có thể đến tại địa chỉ dưới đây để liên hệ với cửa hàng.</p>
                    </div>
                    <div class="contact-widget">
                        <div class="cw-item">
                            <div class="ci-icon">
                                <i class="ti-location-pin"></i>
                            </div>
                            <div class="ci-text">
                                <span>Địa chỉ:</span>
                                <p>60-49 Mai dịch, Cầu giấy, Hà Nội</p>
                            </div>
                        </div>
                        <div class="cw-item">
                            <div class="ci-icon">
                                <i class="ti-mobile"></i>
                            </div>
                            <div class="ci-text">
                                <span>Số điện thoại:</span>
                                <p>+84 357.393.099</p>
                            </div>
                        </div>
                        <div class="cw-item">
                            <div class="ci-icon">
                                <i class="ti-email"></i>
                            </div>
                            <div class="ci-text">
                                <span>Email:</span>
                                <p>Cuongdm3092@gmail.com</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 offset-lg-1">
                    <div class="contact-form">
                        <div class="leave-comment">
                            <h4>Để lại lời nhắn</h4>
                            <p>Nhân viên của chúng tôi sẽ trả lời ngay những câu hỏi của bạn.</p>
                            <!-- Cách 1, dùng thuộc tính name (với form ít field) -->
                            <form method="post" action="${ base }/contact" class="comment-form">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <input type="text" placeholder="Họ tên" value="${name}" id="name" required>
                                    </div>
                                    <div class="col-lg-6">
                                        <input type="email" placeholder="Email" id="email" required>
                                    </div>
                                    <div class="col-lg-12">
                                        <textarea placeholder="Nội dung" id="content"></textarea>
                                        <button type="button" onclick="SaveContact();" class="site-btn">Gửi</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Contact Section End -->
<jsp:include page="/WEB-INF/views/front-end/common/footer.jsp"></jsp:include>
<script>
	    function SaveContact() {
	    	// javascript object.
			var data = {};
			data["email"] = $("#email").val().trim();
			data["name"] = $("#name").val().trim();
			data["content"] = $("#content").val().trim();
			
			if(!data.email || !data.name || !data.content){
				alert("Vui lòng nhập đủ thông tin.")
				return;
			}
			
			if(data.email.indexOf('@') == -1){
				alert("Email không hợp lệ.")
				return;
			}
			
			$.ajax({
				url: "/contact",
				type: "post",
				contentType: "application/json",
				data: JSON.stringify(data),
				
				dataType: "json",
				success: function(jsonResult) {
					$("#email").val('');
					$("#name").val('');
					$("#content").val('');
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
					      Gửi lời nhắn thành công
					    </div>
					  </div>
		            	`;
		            $('body').append(notification);
		            $(".toast").toast({ delay: 3000 });
		            $('.toast').toast('show');
				},
				error: function (jqXhr, textStatus, errorMessage) { // error callback 
					$(".toast").remove();
		            var notification = `
					  <div class="toast" style="position: fixed; top: 50px; right: 50px;">
					    <div class="toast-header">
					      <img src="/img/x_do.png" class="rounded mr-2" style="width:20px; height:20px;" alt="...">
					      <strong class="mr-auto">Thông báo</strong>
					      <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
					        <span aria-hidden="true">&times;</span>
					      </button>
					    </div>
					    <div class="toast-body">
					      Có lỗi xảy ra
					    </div>
					  </div>
		            	`;
		            $('body').append(notification);
		            $(".toast").toast({ delay: 3000 });
		            $('.toast').toast('show');
			    }
			});
		}
    </script>