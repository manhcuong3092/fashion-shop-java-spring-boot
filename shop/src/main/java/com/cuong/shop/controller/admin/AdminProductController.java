package com.cuong.shop.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cuong.shop.dto.AjaxResponse;
import com.cuong.shop.dto.ProductSearch;
import com.cuong.shop.entities.Product;
import com.cuong.shop.repositories.CategoryRepo;
import com.cuong.shop.repositories.ProductRepo;
import com.cuong.shop.services.ProductService;



@Controller
public class AdminProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private CategoryRepo categoryRepo;
	
	@Autowired
	private ProductRepo productRepo;
	
	@RequestMapping(value = { "/admin/add-product" }, method = RequestMethod.GET)
	public String addProductGet(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("product") Product product) throws Exception {
		model.addAttribute("product", new Product());
		model.addAttribute("categories", categoryRepo.findAll());
		return "back-end/product/add-product";
	}
	
	@RequestMapping(value = { "/admin/add-product" }, method = RequestMethod.POST)
	public String addProductPost(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("product") Product product, @RequestParam("productAvatar") MultipartFile productAvatar,
			@RequestParam("images") MultipartFile[] images)  throws Exception {
//		MultipartFile[] productAvatar (multiple avatar)
		System.out.println(images.length);
		System.out.println(productAvatar.getOriginalFilename());
		try {
			productService.saveOrUpdate(product, productAvatar, images);
		} catch (Exception e) {
			model.addAttribute("categories", categoryRepo.findAll());
			model.addAttribute("error", "Kiểm tra lại thông tin");
			return "back-end/product/add-product"; 
		}
		return "redirect:/admin/products";
	}
	
	@RequestMapping(value = { "/admin/edit-product/{id}" }, method = RequestMethod.GET)
	public String editProductGet(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("product") Product product, @PathVariable("id") int productId)  throws Exception {
		model.addAttribute("product", productRepo.findById(productId).get());
		model.addAttribute("categories", categoryRepo.findAll());
		return "back-end/product/add-product";
	}
	
	@RequestMapping(value = { "/admin/products" }, method = RequestMethod.GET)
	public String getProducts(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)  throws Exception {
		ProductSearch productSearch = new ProductSearch();
//		productSearch.buildPaging(request);
//		List<Product> products = productService.search(productSearch);
//		model.addAttribute("productSearch", productSearch);
		model.addAttribute("products", productRepo.findAll());
		return "back-end/product/all-products";
	}
	
	@RequestMapping(value = { "/admin/products/search-all" }, method = RequestMethod.GET)
	public String getSearchProducts(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)  throws Exception {
		ProductSearch productSearch = new ProductSearch();
		productSearch.setSearchText(request.getParameter("searchText"));
		productSearch.buildPaging(request);
		List<Product> products = productService.search(productSearch);
		model.addAttribute("productSearch", productSearch);
		model.addAttribute("products", products);
		return "back-end/product/all-products";
	}
	
	@RequestMapping(value = { "/admin/products/delete/{id}" }, method = RequestMethod.DELETE)
	public ResponseEntity<AjaxResponse> deleteProduct(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("id") int productId)
			throws Exception {
		try {
			Product product =  productRepo.findById(productId).get();
			if(productService.delete(productId)) {
				return ResponseEntity.ok(new AjaxResponse(200, "Xóa thành công"));
			} else {
				return ResponseEntity.ok(new AjaxResponse(400, "Error"));
			}
		} catch (Exception e) {
			return ResponseEntity.ok(new AjaxResponse(400, "Error"));
		}
	}
}
