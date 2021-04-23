package com.cuong.shop.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cuong.shop.dto.AjaxResponse;
import com.cuong.shop.dto.ContactDTO;
import com.cuong.shop.dto.ProductSearch;
import com.cuong.shop.dto.SaleOrderSearch;
import com.cuong.shop.entities.Category;
import com.cuong.shop.entities.Product;
import com.cuong.shop.entities.SaleOrder;
import com.cuong.shop.entities.Subscriber;
import com.cuong.shop.entities.User;
import com.cuong.shop.repositories.CategoryRepo;
import com.cuong.shop.repositories.ProductRepo;
import com.cuong.shop.repositories.SaleOrderProductRepo;
import com.cuong.shop.repositories.SaleOrderRepo;
import com.cuong.shop.repositories.SubscriberRepo;
import com.cuong.shop.services.ProductService;
import com.cuong.shop.services.SaleOrderService;
import com.google.common.eventbus.Subscribe;


@Controller
public class HomeController extends BaseController {

	/**
	 * @param model - Dùng để đẩy dữ liệu hoặc hứng dữ liệu từ tầng VIEW.
	 * @param request - Các thông tin người dùng yêu cầu.
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@Autowired
	CategoryRepo categoriesRepo;
	
	@Autowired
	ProductRepo productRepo;
	
	@Autowired
	ProductService productService;
	
	@Autowired 
	SubscriberRepo subscriberRepo;
	
	@RequestMapping(value = { "/", "/home", "/index", "/trangchu" }, method = RequestMethod.GET)
	public String index(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {;
		ProductSearch productSearch = new ProductSearch();
		productSearch.buildPaging(request);
		productSearch.setGender("Nam");
		List<Product> manProducts = productService.search(productSearch);
		productSearch.setGender("Nữ");
		List<Product> womanProducts = productService.search(productSearch);
		model.addAttribute("subscriber", new Subscriber());
		model.addAttribute("manProducts", manProducts);
		model.addAttribute("womanProducts", womanProducts);
		return "front-end/index";
	}


	
	@RequestMapping(value = { "/blog" }, method = RequestMethod.GET)
	public String blog(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		return "front-end/blog";
	}
	
	@RequestMapping(value = { "/blog-details" }, method = RequestMethod.GET)
	public String blogDetails(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		return "front-end/blog-details";
	}
	
	@RequestMapping(value = { "/faq" }, method = RequestMethod.GET)
	public String faq(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		return "front-end/faq";
	}
	
	@RequestMapping(value = { "/subscriber" }, method = RequestMethod.POST)
	public ResponseEntity<AjaxResponse> subscriber(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@RequestBody Subscriber subscriber)
			throws Exception {
		subscriberRepo.save(subscriber);
		return ResponseEntity.ok(new AjaxResponse(200, subscriber.getEmail()));
	}

}
