package com.cuong.shop.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cuong.shop.dto.AjaxResponse;
import com.cuong.shop.dto.OrderStatus;
import com.cuong.shop.dto.SaleOrderSearch;
import com.cuong.shop.entities.SaleOrder;
import com.cuong.shop.repositories.SaleOrderRepo;
import com.cuong.shop.services.SaleOrderService;


@Controller
public class AdminSaleOrderController {
	
	@Autowired
	SaleOrderRepo saleOrderRepo;
	
	@Autowired
	SaleOrderService saleOrderService;
	
	@RequestMapping(value = { "/admin/sale-orders" }, method = RequestMethod.GET)
	public String getSaleOrders(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)  throws Exception {
		SaleOrderSearch saleOrderSearch = new SaleOrderSearch();
		saleOrderSearch.buildPaging(request);
		List<SaleOrder> saleOrders = saleOrderService.search(saleOrderSearch);
		model.addAttribute("saleOrderSearch", saleOrderSearch);
		model.addAttribute("saleOrders", saleOrders);
		return "back-end/order/all-orders";
	}
	
	@RequestMapping(value = { "/admin/pending-orders" }, method = RequestMethod.GET)
	public String getPendlingOrders(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)  throws Exception {
		SaleOrderSearch saleOrderSearch = new SaleOrderSearch();
		saleOrderSearch.buildPaging(request);
		saleOrderSearch.setOrderStatus("Chờ xử lý");
		List<SaleOrder> saleOrders = saleOrderService.search(saleOrderSearch);
		model.addAttribute("saleOrderSearch", saleOrderSearch);
		model.addAttribute("saleOrders", saleOrders);
		return "back-end/order/all-orders";
	}
	
	@RequestMapping(value = { "/admin/delivering-orders" }, method = RequestMethod.GET)
	public String getDeliveringOrders(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)  throws Exception {
		SaleOrderSearch saleOrderSearch = new SaleOrderSearch();
		saleOrderSearch.buildPaging(request);
		saleOrderSearch.setOrderStatus("Đang giao hàng");
		List<SaleOrder> saleOrders = saleOrderService.search(saleOrderSearch);
		model.addAttribute("saleOrderSearch", saleOrderSearch);
		model.addAttribute("saleOrders", saleOrders);
		return "back-end/order/all-orders";
	}
	
	@RequestMapping(value = { "/admin/successful-orders" }, method = RequestMethod.GET)
	public String getSuccessfulOrders(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)  throws Exception {
		SaleOrderSearch saleOrderSearch = new SaleOrderSearch();
		saleOrderSearch.buildPaging(request);
		saleOrderSearch.setOrderStatus("Giao hàng thành công");
		List<SaleOrder> saleOrders = saleOrderService.search(saleOrderSearch);
		model.addAttribute("saleOrderSearch", saleOrderSearch);
		model.addAttribute("saleOrders", saleOrders);
		return "back-end/order/all-orders";
	}
	
	@RequestMapping(value = { "/admin/canceled-orders" }, method = RequestMethod.GET)
	public String getProducts(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)  throws Exception {
		SaleOrderSearch saleOrderSearch = new SaleOrderSearch();
		saleOrderSearch.buildPaging(request);
		saleOrderSearch.setOrderStatus("Đã hủy");
		List<SaleOrder> saleOrders = saleOrderService.search(saleOrderSearch);
		model.addAttribute("saleOrderSearch", saleOrderSearch);
		model.addAttribute("saleOrders", saleOrders);
		return "back-end/order/all-orders";
	}
	
	@RequestMapping(value = { "/admin/order/{orderCode}" }, method = RequestMethod.GET)
	public String getDetailOrder(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable String orderCode)  throws Exception {
		SaleOrderSearch saleOrderSearch = new SaleOrderSearch();
		saleOrderSearch.buildPaging(request);
		saleOrderSearch.setSeo(orderCode);
		List<SaleOrder> saleOrders = saleOrderService.search(saleOrderSearch);
		model.addAttribute("saleOrderSearch", saleOrderSearch);
		model.addAttribute("saleOrder", saleOrders.get(0));
		return "back-end/order/order-detail";
	}
	
	@RequestMapping(value = { "/admin/order/{orderId}" }, method = RequestMethod.PATCH)
	public ResponseEntity<AjaxResponse> updateStatus(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable int orderId, @RequestBody OrderStatus orderStatus)  throws Exception {
		SaleOrder saleOrder = saleOrderRepo.findById(orderId).get(); 
		saleOrder.setOrderStatus(orderStatus.getStatus());
		saleOrderRepo.save(saleOrder);
		return ResponseEntity.ok(new AjaxResponse(200, orderStatus));
	}
	
	@RequestMapping(value = { "/admin/order/delete/{orderId}" }, method = RequestMethod.DELETE)
	public ResponseEntity<AjaxResponse> deleteOrder(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable int orderId)  throws Exception {
		saleOrderRepo.deleteById(orderId);
		return ResponseEntity.ok(new AjaxResponse(200, "OK"));
	}
}
