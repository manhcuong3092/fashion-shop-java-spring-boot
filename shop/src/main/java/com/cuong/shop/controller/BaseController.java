package com.cuong.shop.controller;

import java.lang.annotation.Annotation;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.cuong.shop.entities.Category;
import com.cuong.shop.services.CategoryService;
import com.google.common.eventbus.Subscribe;

public class BaseController {

	@Autowired
	private CategoryService categoryService;
	
	private String buildMenu() {
		StringBuilder menu = new StringBuilder();
		
		List<Category> categories = categoryService.getAllParents();
		for(Category c : categories) {
			menu.append("<li><a class='font-weight-bold' href=/shop/search-all?categorySeo=" + c.getSeo() + ">"  + c.getName());
			if(c.getChildren() != null && !c.getChildren().isEmpty()) {
				recursiveMenu(menu, c.getChildren());
			}
			menu.append("</a></li>");
		}
		
		return menu.toString();
	}
	
	private void recursiveMenu(StringBuilder menu, Set<Category> childen) {
		menu.append("<ul class=" + "\"pl-4 pt-3 mt-n5\"" + ">");
		for(Category c : childen) {
			menu.append("<li><a href=/shop/search-all?categorySeo=" + c.getSeo() + ">" + c.getName());
			if(c.getChildren() != null && !c.getChildren().isEmpty()) {
				recursiveMenu(menu, c.getChildren());
				menu.append("</a></li>");
			} else {
				menu.append("</a></li>");
			}
		}
		menu.append("</ul>");
	}
	
	@ModelAttribute("menu")
	public String getCategories() {
		return this.buildMenu();
	}
	
}
