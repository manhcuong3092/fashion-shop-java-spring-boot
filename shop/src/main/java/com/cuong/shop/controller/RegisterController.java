package com.cuong.shop.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cuong.shop.dto.UserRegister;
import com.cuong.shop.entities.Role;
import com.cuong.shop.entities.User;
import com.cuong.shop.repositories.RoleRepo;
import com.cuong.shop.repositories.UserRepo;
import com.cuong.shop.services.UserService;

@Controller
public class RegisterController extends BaseController {
	
	@Autowired UserRepo userRepo;
	@Autowired RoleRepo roleRepo;
	@Autowired UserService userService;
	
	//get register page
	@RequestMapping(value = { "/register" }, method = RequestMethod.GET)
	public String register(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("userRegister") UserRegister userRegister)
			throws Exception {
		model.addAttribute("userRegister", new UserRegister()); 
		return "front-end/register"; 
	}
	
	
	//Validate register information and save
	@RequestMapping(value = { "/register" }, method = RequestMethod.POST)
	public String postRegister(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("userRegister") UserRegister userRegister)
			throws Exception {
		try {
			if (userRegister.getPassword().compareTo(userRegister.getConfirmPassword()) != 0)
				throw new Exception("Xác nhận mật khẩu không khớp");
			if (userRegister.getUsername().length() < 5)
				throw new Exception("Độ dài tên tài khoản phải lớn hơn 5");
			if (userRegister.getUsername().contains(" "))
				throw new Exception("Tên tài khoản không được chứa dấu cách");
			if (userRegister.getPassword().length() < 8)
				throw new Exception("Độ dài mật khẩu phải lớn hơn 8");
			if (userRegister.getEmail().isBlank() || userRegister.getAddress().isBlank() ||
					userRegister.getPhone().isBlank() || userRegister.getFullName().isBlank())
				throw new Exception("Các trường bắt buộc không được để trống.");
			if (!userRegister.getPhone().matches("[0-9]{10,11}"))
				throw new Exception("Số điện thoại không hợp lệ");
			StringTokenizer st = new StringTokenizer(userRegister.getFullName());
			if (st.countTokens() < 2)
				throw new Exception("Họ tên ít nhất 2 từ");
			if (userService.loadUserByUsername(userRegister.getUsername().toLowerCase()) != null)
				throw new Exception("Tên tài khoản này đã tồn tại");
			
			User user = new User();
			user.setUsername(userRegister.getUsername().toLowerCase());
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(4);
			user.setPassword(encoder.encode(userRegister.getPassword()));
			user.setEmail(userRegister.getEmail());
			user.setFullname(userRegister.getFullName());
			user.setPhone(userRegister.getPhone());
			user.setAddress(userRegister.getAddress());
			user.setCreatedDate(new Date());
			user.setRoles(getGuessRole());
			
			userRepo.save(user);
			return "redirect:/login";
		} catch (Exception e) {
			model.addAttribute("error", e.getMessage());
		}
		return "front-end/register"; 
	}


	private List<Role> getGuessRole() {
		List<Role> guessRole = new ArrayList<Role>();
		List<Role> roles = roleRepo.findAll();
		for(Role role: roles) {
			if(role.getName().equals("GUEST")) {
				guessRole.add(role);
				break;
			}
		}
		return guessRole;
	}
}
	
