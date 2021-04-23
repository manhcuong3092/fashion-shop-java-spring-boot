package com.cuong.shop.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cuong.shop.dto.AjaxResponse;
import com.cuong.shop.dto.ProductSearch;
import com.cuong.shop.dto.QueryResultInfor;
import com.cuong.shop.dto.Subscriber;
import com.cuong.shop.entities.Category;
import com.cuong.shop.entities.Color;
import com.cuong.shop.entities.Comment;
import com.cuong.shop.entities.Product;
import com.cuong.shop.entities.Size;
import com.cuong.shop.entities.User;
import com.cuong.shop.repositories.CategoryRepo;
import com.cuong.shop.repositories.CommentRepo;
import com.cuong.shop.repositories.ProductRepo;
import com.cuong.shop.services.CategoryService;
import com.cuong.shop.services.ProductService;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class ProductController extends BaseController {
	
	@Autowired ProductService productService;
	
	@Autowired CategoryRepo categoryRepo;
	
	@Autowired CategoryService categoryService;
	
	@Autowired CommentRepo commentRepo;
	
	@Autowired ProductRepo productRepo;
	
	@RequestMapping(value = { "/product/{productSeo}" }, method = RequestMethod.GET)
	public String product(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("productSeo") String productSeo)
			throws Exception {
		ProductSearch productSearch = new ProductSearch();
		productSearch.setSeo(productSeo);
		productSearch.buildPaging(request);
		List<Category> categories = categoryService.getAllParents();
		model.addAttribute("product", productService.search(productSearch).get(0));
		model.addAttribute("categories", categories);
		return "front-end/product";
	}
	
	@RequestMapping(value = { "/product/{productSeo}/comment" }, method = RequestMethod.POST)
	public ResponseEntity<AjaxResponse> comment(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("productSeo") String productSeo, @RequestBody Comment comment)
			throws Exception {
		ProductSearch productSearch = new ProductSearch();
		productSearch.setSeo(productSeo);
		Product product = productService.search(productSearch).get(0);
		comment.setProduct(product);
		comment.setCreatedDate(new Date());
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal instanceof UserDetails) {
			User user = (User) principal;
			comment.setEmail(user.getEmail());
			comment.setName(user.getFullname());
			comment.setUser(user);
		}
		commentRepo.save(comment);
		ObjectMapper mapper = new ObjectMapper();
		String json = ""; 
		try {
		     json = mapper.writeValueAsString(comment);
		} catch (IOException e) {
		    e.printStackTrace();
		}
		return ResponseEntity.ok(new AjaxResponse(200, json));
	}
	
	@RequestMapping(value = { "/shop" }, method = RequestMethod.GET)
	public String shop(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		ProductSearch productSearch = new ProductSearch();
		productSearch.buildPaging(request);
		List<Product> products = productService.search(productSearch);
		QueryResultInfor queryResultInfor = productService.getQueryResultInfor();
		List<Category> categories = categoryService.getAllParents();
		model.addAttribute("queryResultInfor", queryResultInfor);
		model.addAttribute("productSearch", productSearch);
		model.addAttribute("products", products);
		model.addAttribute("categories", categories);
		return "front-end/shop";
	}
	
	/*
	 * Get all request query parameters and return filtered result  
	 * */	
	@RequestMapping(value = { "/shop/search-all" }, method = RequestMethod.GET)
	public String searchProduct(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		ProductSearch productSearch = new ProductSearch();
		
		if(request.getParameter("searchText") != null) {
			System.out.println(request.getParameter("searchText"));
			productSearch.setSearchText(request.getParameter("searchText"));
			map.put("searchText", request.getParameter("searchText"));
		}
		if(request.getParameter("gender") != null) {
			productSearch.setGender(request.getParameter("gender"));
			map.put("gender", request.getParameter("gender"));
		}
		if(request.getParameter("size") != null) {
			productSearch.setSize(request.getParameter("size"));
			map.put("size", request.getParameter("size"));
		}
		if(request.getParameter("color") != null) {
			productSearch.setColor(request.getParameter("color"));
			map.put("color", request.getParameter("color"));
		}
		if(request.getParameter("order") != null) {
			productSearch.setOrder(request.getParameter("order"));
			map.put("order", request.getParameter("order"));
		}
		if(request.getParameter("categorySeo") != null) {
			Category category = categoryService.search(request.getParameter("categorySeo"));
			if(category != null) {
				productSearch.setCategoryId(category.getId());
			} else {
				productSearch.setCategoryId(-1);
			}
			map.put("categorySeo", request.getParameter("categorySeo"));
		}
		if(request.getParameter("min") != null) {
			try {
				productSearch.setMin(new BigDecimal(request.getParameter("min")));
				map.put("min", request.getParameter("min"));
				System.out.println(request.getParameter("min"));
			} catch (Exception e) {
				productSearch.setMin(new BigDecimal("-1"));
			}
		}
		if(request.getParameter("max") != null) {
			try {
				productSearch.setMax(new BigDecimal(request.getParameter("max")));
				map.put("max", request.getParameter("max"));
			} catch (Exception e) {
				productSearch.setMin(new BigDecimal("-1"));
			}
		}
		productSearch.buildPaging(request);
		List<Product> products = productService.search(productSearch);
		QueryResultInfor queryResultInfor = productService.getQueryResultInfor();
		List<Category> categories = categoryService.getAllParents();
		model.addAttribute("productSearch", productSearch);
		model.addAttribute("products", products);
		model.addAttribute("order", request.getParameter("order"));
		model.addAttribute("queryMap", map);
		model.addAttribute("queryResultInfor", queryResultInfor);
		model.addAttribute("categories", categories);
		model.addAttribute("min", request.getParameter("min"));
		model.addAttribute("max", request.getParameter("max"));
		return "front-end/shop";
	}
	
	
}
