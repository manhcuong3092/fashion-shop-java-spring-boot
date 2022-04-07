package com.cuong.shop.controller.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cuong.shop.dto.AjaxResponse;
import com.cuong.shop.entities.User;
import com.cuong.shop.repositories.RoleRepo;
import com.cuong.shop.repositories.UserRepo;
import com.cuong.shop.services.UserService;


@Controller
public class AdminUserController {
	
	@Autowired UserRepo userRepo;
	
	@Autowired RoleRepo roleRepo;
	
	@Autowired UserService userService;

	@RequestMapping(value = { "/admin/users" }, method = RequestMethod.GET) 
	public String users(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		List<User> users = userRepo.findAll();
		model.addAttribute("users", users);
		return "back-end/user/all-users"; 
	}

	@RequestMapping(value = { "/admin/add-user" }, method = RequestMethod.GET) 
	public String getAddUser(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		model.addAttribute("user", new User());
		model.addAttribute("roles", roleRepo.findAll());
		return "back-end/user/add-user"; 
	}
	
	@RequestMapping(value = { "/admin/edit-user/{userId}" }, method = RequestMethod.GET) 
	public String getEditUser(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable int userId)
			throws Exception {
		User user = userRepo.findById(userId).get();
		model.addAttribute("user", user);
		model.addAttribute("roles", roleRepo.findAll());
		return "back-end/user/add-user"; 
	}
	
	@RequestMapping(value = { "/admin/your-profile" }, method = RequestMethod.GET) 
	public String getYourProfile(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User user;
		if (principal instanceof UserDetails) {
			user = (User) principal;
		} else {
			return "back-end/403"; 
		}
		System.out.println(user.getId());
		model.addAttribute("user", user);
		model.addAttribute("roles", roleRepo.findAll());
		return "back-end/user/add-user"; 
	}
	
	@RequestMapping(value = { "/admin/add-user" }, method = RequestMethod.POST) 
	public String postAddUser(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute User user, @RequestParam("userAvatar") MultipartFile userAvatar)
			throws Exception {
		try {
			userService.saveOrUpdate(user, userAvatar);
		} catch (Exception e) {
			model.addAttribute("error", e.getMessage());
			model.addAttribute("user", new User());
			model.addAttribute("roles", roleRepo.findAll());
			return "back-end/user/add-user";
		}
		return "redirect:/admin/users"; 
	}

	@RequestMapping(value = { "/admin/users/delete/{id}" }, method = RequestMethod.DELETE)
	public ResponseEntity<AjaxResponse> deleteProduct(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("id") int userId)
			throws Exception {
		try {
			User user =  userRepo.findById(userId).get();
			if(userService.delete(userId)) {
				return ResponseEntity.ok(new AjaxResponse(200, "Xóa thành công"));
			} else {
				return ResponseEntity.ok(new AjaxResponse(400, "Error"));
			}
		} catch (Exception e) {
			return ResponseEntity.ok(new AjaxResponse(400, "Error"));
		}
	}
}
