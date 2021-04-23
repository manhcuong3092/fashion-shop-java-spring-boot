package com.cuong.shop.controller;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cuong.shop.entities.User;
import com.cuong.shop.repositories.UserRepo;
import com.cuong.shop.services.UserService;

@Controller
public class UserInforController extends BaseController {
	
	@Autowired UserService userService;
	
	@Autowired UserRepo userRepo;
	
	//get user infor page
	@RequestMapping(value = { "/user-infor" }, method = RequestMethod.GET)
	public String getUserInfor(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User user = (User) principal;
		model.addAttribute("user", user); 
		return "front-end/user-infor"; 
	}
	
	@RequestMapping(value = { "/user-infor" }, method = RequestMethod.POST)
	public String postUserInfor(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@RequestParam("userAvatar") MultipartFile userAvatar) throws Exception {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		User user = (User) principal;
		try {
			Integer id = Integer.parseInt(request.getParameter("id"));
			if(id.intValue() != user.getId().intValue())
				throw new Exception("Người dùng không hợp lệ.");
			
			User userInDB = userRepo.findById(id).get();
			
			userInDB.setFullname(request.getParameter("fullname"));
			userInDB.setEmail(request.getParameter("email"));
			userInDB.setAddress(request.getParameter("address"));
			userInDB.setPhone(request.getParameter("phoneNumber"));
			
			userService.saveOrUpdate(userInDB, userAvatar);
			user = userInDB;
			model.addAttribute("success", "Thay đổi thông tin thành công");
			
		} catch (NumberFormatException e) {
			model.addAttribute("error", "Có lỗi xảy ra");
		} catch (Exception e) {
			model.addAttribute("error", e.getMessage());
		} 
		model.addAttribute("user", user);
		return "front-end/user-infor"; 
	}

}
