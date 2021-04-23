function changeStatus(orderId, status){
	var data = {
		orderId: orderId,
		status: status
	}
	$.ajax({
	  url: '/admin/order/' + orderId,
      type: "patch",
      contentType: "application/json",
      data: JSON.stringify(data),
      dataType: "json",
      success: function(objectData) {
          console.log(objectData);
          var children = $('#order_' + orderId).children();
          if(objectData.data.status === 'Đang giao hàng'){
        	  children[0].remove();
        	  $('#order_' + orderId).prepend(
        		  '<button class="btn btn-success m-1" onclick="changeStatus(' + orderId + ',\'Giao hàng thành công\')"><i class="fas fa-clipboard-check"></i></button>'	  
        	  )
        	  $('#order_' + orderId + '_status').empty();
        	  $('#order_' + orderId + '_status').append(
        		  '<p class="text-primary">' + objectData.data.status + '</p>'
        	  );
          }
          else if(objectData.data.status === 'Giao hàng thành công'){
        	  children[0].remove();
        	  children[1].remove();
        	  $('#order_' + orderId + '_status').empty();
        	  $('#order_' + orderId + '_status').append(
            		  '<p class="text-success">' + objectData.data.status + '</p>'
            	  );
          }
          else if(objectData.data.status === 'Đã hủy'){
        	  children[0].remove();
        	  children[1].remove();
        	  $('#order_' + orderId + '_status').empty();
        	  $('#order_' + orderId + '_status').append(
            		  '<p class="text-danger">' + objectData.data.status + '</p>'
            	  );
          }
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
			      Thao tác thành công.
			    </div>
			  </div>
          	`;
          $('body').append(notification);
          $(".toast").toast({ delay: 3000 });
          $('.toast').toast('show');
      },
      error: function (jqXhr, textStatus, errorMessage) { // error callback 
    	  alert('error')
      }
	})
}

function deleteOrder(orderId){
	var x = confirm("Bạn có muốn xóa đơn hàng này không?");
	if (x == false){
		return;
	}
	$.ajax({
	  url: '/admin/order/delete/' + orderId,
      type: "delete",
      contentType: "application/json",
      dataType: "json",
      success: function(objectData) {
    	  $('#row_order_' + orderId).remove();
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
			      Thao tác thành công.
			    </div>
			  </div>
          	`;
          $('body').append(notification);
          $(".toast").toast({ delay: 3000 });
          $('.toast').toast('show');
      },
      error: function (jqXhr, textStatus, errorMessage) { // error callback 
    	  alert('error')
      }
	})
}

function responseContact(contactId){
	$.ajax({
		  url: '/admin/contact/' + contactId,
	      type: "patch",
	      contentType: "application/json",
	      dataType: "json",
	      success: function(objectData) {
	    	  $("#contact_"+ contactId + "_action").empty();
	    	  $("#contact_"+ contactId + "_status").empty();
	    	  $("#contact_"+ contactId + "_status").append('<p class="text-success">Đã phản hồi</p>');
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
				      Thao tác thành công.
				    </div>
				  </div>
	          	`;
	          $(".toast").remove();
	          $('body').append(notification);
	          $(".toast").toast({ delay: 3000 });
	          $('.toast').toast('show');
	      },
	      error: function (jqXhr, textStatus, errorMessage) { // error callback 
	    	  alert('error');
	      }
		})
}

function deleteContact(contactId){
	var x = confirm("Bạn chắc chắn muốn xóa lời nhắn liên hệ này chứ?");
	if(x == false){
		return;
	}
	$.ajax({
		  url: '/admin/contact/delete/' + contactId,
	      type: "delete",
	      contentType: "application/json",
	      dataType: "json",
	      success: function(objectData) {
	    	  $("#contact_"+ contactId).remove();
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
				      Thao tác thành công.
				    </div>
				  </div>
	          	`;
	          $(".toast").remove();
	          $('body').append(notification);
	          $(".toast").toast({ delay: 3000 });
	          $('.toast').toast('show');
	      },
	      error: function (jqXhr, textStatus, errorMessage) { // error callback 
	    	  alert('error');
	      }
		})
}