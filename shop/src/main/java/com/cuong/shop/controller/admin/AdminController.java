package com.cuong.shop.controller.admin;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cuong.shop.services.SaleOrderService;
import com.cuong.shop.services.UserService;
import com.cuong.shop.dto.SaleOrderSearch;
import com.cuong.shop.entities.SaleOrder;
import com.cuong.shop.entities.User;
import com.cuong.shop.repositories.SaleOrderRepo;


@Controller
public class AdminController {
	
	@Autowired SaleOrderService saleOrderService;
	
	@Autowired SaleOrderRepo SaleOrderRepo;
	
	@Autowired UserService userService;

	@RequestMapping(value = { "/admin" }, method = RequestMethod.GET) 
	public String admin(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		SaleOrderSearch saleOrderSearch = new SaleOrderSearch();
		List<SaleOrder> saleOrders = saleOrderService.search(saleOrderSearch);
		List<SaleOrder> pendingOrderList = new ArrayList<SaleOrder>();
		int pendingOrders = 0, deliveringOrders = 0, successfulOrders = 0, canceledOrders = 0;
		for(SaleOrder saleOrder: saleOrders) {
			if(saleOrder.getOrderStatus().equals("Chờ xử lý")) {
				 pendingOrders++;
				 pendingOrderList.add(saleOrder);
			}
			if(saleOrder.getOrderStatus().equals("Đang giao hàng")) deliveringOrders++;
			if(saleOrder.getOrderStatus().equals("Giao hàng thành công")) successfulOrders++;
			if(saleOrder.getOrderStatus().equals("Đã hủy")) canceledOrders++;
		}
		
		
		model.addAttribute("pendingOrders", pendingOrders);
		model.addAttribute("deliveringOrders", deliveringOrders);
		model.addAttribute("successfulOrders", successfulOrders);
		model.addAttribute("canceledOrders", canceledOrders);
		
		return "back-end/index"; 
	}
	
	@RequestMapping(value = { "/admin/limit/{days}" }, method = RequestMethod.GET) 
	public String limitData(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable int days)
			throws Exception {
		SaleOrderSearch saleOrderSearch = new SaleOrderSearch();
		//get subtract days before
		Date limitDate = Date.from(LocalDate.now().minusDays(days).atStartOfDay(ZoneId.systemDefault()).toInstant());
		saleOrderSearch.setLimitDate(limitDate);
		List<SaleOrder> saleOrders = saleOrderService.search(saleOrderSearch);
		int pendingOrders = 0, deliveringOrders = 0, successfulOrders = 0, canceledOrders = 0;
		for(SaleOrder saleOrder: saleOrders) {
			if(saleOrder.getOrderStatus().equals("Chờ xử lý")) pendingOrders++;
			if(saleOrder.getOrderStatus().equals("Đang giao hàng")) deliveringOrders++;
			if(saleOrder.getOrderStatus().equals("Giao hàng thành công")) successfulOrders++;
			if(saleOrder.getOrderStatus().equals("Đã hủy")) canceledOrders++;
		}
		
		
		model.addAttribute("saleOrders", saleOrders);
		model.addAttribute("pendingOrders", pendingOrders);
		model.addAttribute("deliveringOrders", deliveringOrders);
		model.addAttribute("successfulOrders", successfulOrders);
		model.addAttribute("canceledOrders", canceledOrders);
		
		List<User> userList = userService.search(limitDate);
		model.addAttribute("userList", userList);
		
		
		return "back-end/index"; 
	}
	
	@RequestMapping(value = { "/403" }, method = RequestMethod.GET) 
	public String blank(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		return "back-end/403"; 
	}
	
}
