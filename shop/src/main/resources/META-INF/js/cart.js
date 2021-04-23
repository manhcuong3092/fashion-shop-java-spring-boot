var Cart = {
	addToCart: function(productId, quantity, size, color){
		var data = {};
	    data.productId = productId;
	    data.quantity = quantity;
	    data.size = size;
	    data.color = color;

	    $.ajax({
	        url: "/cart/add",
	        type: "post",
	        contentType: "application/json",
	        data: JSON.stringify(data),
	        dataType: "json",
	        success: function (objectData) {
	        	updateCart(objectData);
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
				      Đã thêm sản phẩm vào giỏ hàng
				    </div>
				  </div>
	            	`;
	            $('body').append(notification);
	            $(".toast").toast({ delay: 3000 });
	            $('.toast').toast('show');
	        },
	        error: function (jqXhr, textStatus, errorMessage) { // error callback 
	            alert('Có lỗi xảy ra');
	            alert(textStatus);
	        }
	    });
	},
	
	changeQuantity: function(productId, size, color, quantity, totalPriceItemHtml){
		var data = {
		      productId: productId,
		      size: size,
		      color: color,
		      quantity: parseInt(quantity)
		    }
		$.ajax({
	      url: '/cart/changeQuantity/' + productId + '/' + size + '/' + color,
	      type: "post",
	      contentType: "application/json",
	      data: JSON.stringify(data),
	      dataType: "json",
	      success: function(objectData) {
	    	  updateCart(objectData);
	          let productItem = objectData.data.cartItems.find(function(item){
	        	 return item.productId == productId && item.color === color && item.size === size;
	          });
	          totalPriceItemHtml.html((productItem.priceUnit*productItem.quantity).toLocaleString('vi-VI', { style: 'currency', currency: 'VND' }));
	      },
	      error: function (jqXhr, textStatus, errorMessage) { // error callback 
	    	  alert('error')
	      }
	    });
	},
	
	deleteItem: function(productId, size, color){
		var item = event.target.parentNode.parentNode;
		var itemInCartPage = productId + '__' + size + '__' + color;
		$.ajax({
			url: "/cart/delete/" + productId + "/" + size + "/" + color,
	        type: "delete",
	        contentType: "application/json",
	        success: function(objectData){
	        	updateCart(objectData);
	        	$(item).remove();
	        	$("#" + itemInCartPage).remove();
	        },
	        error: function (jqXhr, textStatus, errorMessage) { // error callback 
	            alert('Có lỗi xảy ra');
	            alert(textStatus);
	        }
		})
	},
}

function updateCart(objectData){
	$("#cart-items").empty();
    $("#totalCart").text(objectData.data.totalItems);
    $(".totalPrice").html(objectData.data.totalPrice.toLocaleString('vi-VI', { style: 'currency', currency: 'VND' }))
    $(".cart-total").text(objectData.data.totalPrice.toLocaleString('vi-VI', { style: 'currency', currency: 'VND' }));
    for(let item of objectData.data.cartItems){
    	$("#cart-items").append(
    		'<tr>' + 
                '<td class="si-pic"><img src="/upload/' + item.avatar  + '"alt=""></td>' + 
                '<td class="si-text">'+
                    '<div class="product-selected">' + 
                        '<p>' + item.priceUnit.toLocaleString('vi-VI', { style: 'currency', currency: 'VND' }) + ' x ' + item.quantity + '</p>' + 
                        '<h6>' + item.productName + ' - ' + item.size + ' -  ' + item.color + '</h6>' +
                    '</div>' +
                '</td>' +
                '<td class="si-close">' +
                    '<i class="ti-close" onclick="Cart.deleteItem(' + item.productId + ', \'' + item.size + '\', \'' + item.color + '\')"></i>' +
                '</td>' +
            '</tr>'
        )
    }
}
