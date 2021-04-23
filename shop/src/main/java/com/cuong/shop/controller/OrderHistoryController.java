package com.cuong.shop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cuong.shop.dto.SaleOrderSearch;
import com.cuong.shop.entities.SaleOrder;
import com.cuong.shop.entities.User;
import com.cuong.shop.services.SaleOrderService;

@Controller
public class OrderHistoryController extends BaseController {
	
	@Autowired
	SaleOrderService saleOrderService;
	
	/*
	 * Return user's order list
	 * */
	@RequestMapping(value = { "/order" }, method = RequestMethod.GET)
	public String orderHistory(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User user = (User) principal;
		SaleOrderSearch saleOrderSearch = new SaleOrderSearch();
		saleOrderSearch.setUserId(user.getId());
		List<SaleOrder> saleOrders = saleOrderService.search(saleOrderSearch);
		model.addAttribute("saleOrders", saleOrders);
		return "front-end/order-history";
	}
	
	/*
	 * Return user's order detail
	 * */
	@RequestMapping(value = { "/order/{orderSeo}" }, method = RequestMethod.GET)
	public String orderDetail(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("orderSeo") String orderSeo)
			throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User user = (User) principal;
		SaleOrderSearch saleOrderSearch = new SaleOrderSearch();
		saleOrderSearch.setUserId(user.getId());
		saleOrderSearch.setSeo(orderSeo);
		List<SaleOrder> saleOrders = saleOrderService.search(saleOrderSearch);
		if(saleOrders.size() == 0) {
			return "back-end/404";
		}
		model.addAttribute("order", saleOrders.get(0));
		return "front-end/order-detail";
	}
}
