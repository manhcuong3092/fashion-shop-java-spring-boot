package com.cuong.shop.controller.admin;

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

import com.cuong.shop.Utilities;
import com.cuong.shop.dto.AjaxResponse;
import com.cuong.shop.entities.Category;
import com.cuong.shop.repositories.CategoryRepo;
import com.cuong.shop.services.CategoryService;


@Controller
public class AdminCategoryController {
	@Autowired
	private CategoryRepo categoryRepo;
	
	@Autowired
	private CategoryService categoryService;
	
	@RequestMapping(value = { "/admin/add-category" }, method = RequestMethod.GET)
	public String addCategoryGet(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("category") Category category) throws Exception {
		model.addAttribute("category", new Category());
		model.addAttribute("categories", categoryRepo.findAll());
		return "back-end/category/add-category";
	}
	
	@RequestMapping(value = { "/admin/add-category" }, method = RequestMethod.POST)
	public String addCategoryPost(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("category") Category category) throws Exception {
		category.setSeo(Utilities.seo(category.getName()+ " " + System.currentTimeMillis()));
		categoryService.saveOrUpdate(category);
//		model.addAttribute("categories", categoryRepo.findAll());
		return "redirect:/admin/categories";
	}
	
	@RequestMapping(value = { "/admin/edit-category/{id}" }, method = RequestMethod.GET)
	public String addCategoryGet(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("category") Category category, @PathVariable("id") int categoryId) throws Exception {
		model.addAttribute("category", categoryRepo.findById(categoryId).get());
		model.addAttribute("categories", categoryRepo.findAll());
//		
		return "back-end/category/add-category";
	}
	
	@RequestMapping(value = { "/admin/categories" }, method = RequestMethod.GET)
	public String categoriesGet(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		model.addAttribute("categories", categoryRepo.findAll());
		return "back-end/category/all-categories";
	}
	
	@RequestMapping(value = { "/admin/categories/delete/{id}" }, method = RequestMethod.DELETE)
	public ResponseEntity<AjaxResponse> deleteCategory(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("id") int categoryId) {
		try {
			Category category = categoryRepo.findById(categoryId).get();
			categoryRepo.deleteById(categoryId);
			return ResponseEntity.ok(new AjaxResponse(200, category));
		} catch (Exception e) {
			return ResponseEntity.ok(new AjaxResponse(400, "Error"));
		}
	}
}
