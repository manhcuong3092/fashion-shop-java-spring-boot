$(document).ready(function(){
		
	$('#postComment').click(function () {
	    var data = {};
	    data.name = $("#commentName").val();
	    data.email = $("#commentEmail").val();
	    data.content = $("#commentContent").val();
	    
	    var star = $("input[name='star']:checked").val();
	    data.star = parseInt(star);
	    
	    if(!data.content || !data.email || !data.name){
	    	alert('Vui lòng điền đầy đủ thông tin');
	    	return;
	    }
	    
	    var productPath = window.location.pathname + '/comment';
	    $.ajax({
	        url: productPath,
	        type: "post",
	        contentType: "application/json",
	        data: JSON.stringify(data),
	        dataType: "json",
	        success: function (jsonResult) {
	            //show frontend cart
	            var objectData = JSON.parse(jsonResult.data);
	            var date = new Date(objectData.createdDate);
	            var star = "";
	            for(let i = 1; i<= 5; i++){
	            	if (i <= objectData.star){
	            		star += '<i class="fa fa-star"></i> '
	            	} else {
	            		star += '<i class="fa fa-star-o"></i> '
	            	}
	            }
	            $('#comments').append(
            		'<div class="co-item">' + 
            			'<div class="avatar-pic">' +
                    		'<img src="/img/user.png" alt="">' +
                		'</div>' +
                        '<div class="avatar-text">' +
                        	'<div class="at-rating">' + star + '</div>' +
                            '<h5>' + objectData.name + ' <span>' + date.getDate() + ' THG ' + (date.getMonth() + 1) + ', ' + date.getFullYear() + '</span></h5>' +
                            '<div class="at-reply">' + objectData.content + '</div>' +
                        '</div>' +
                    '</div>'		
	            );
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
				      Gửi đánh giá thành công
				    </div>
				  </div>
	            	`;
	            $('body').append(notification);
	            $(".toast").toast({ delay: 3000 });
	            $('.toast').toast('show');
	            
	            $("#commentName").val('');
	            $("#commentEmail").val('');
	            $("#commentContent").val('');
	        },
	        error: function (jqXhr, textStatus, errorMessage) { // error callback 
	            alert('Có lỗi xảy ra');
	            alert(textStatus);
	        }
	    });
	});
})
	
function addProductToCart(productId){
	var quantity = $('#quantity').val();
	var size = $("input[name='size']:checked").val();
    var color = $("input[name='color']:checked").val();
    if(!size){
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
		      Hãy chọn kích cỡ
		    </div>
		  </div>
        	`;
        $('body').append(notification);
        $(".toast").toast({ delay: 3000 });
        $('.toast').toast('show');
        return;
    }
    if(!color){
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
		      Hãy chọn màu
		    </div>
		  </div>
        	`;
        $('body').append(notification);
        $(".toast").toast({ delay: 3000 });
        $('.toast').toast('show');
        return;
    } 
	if(!parseInt(quantity)){
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
		      Số lượng không hợp lệ
		    </div>
		  </div>
        	`;
        $('body').append(notification);
        $(".toast").toast({ delay: 3000 });
        $('.toast').toast('show');
		$('#quantity').val(1);
		return;
	}
	quantity = parseInt(quantity);
	Cart.addToCart(productId, quantity, size, color);
}	