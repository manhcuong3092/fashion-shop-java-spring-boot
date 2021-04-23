package com.cuong.shop.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cuong.shop.dto.AjaxResponse;
import com.cuong.shop.dto.ContactDTO;
import com.cuong.shop.entities.Contact;
import com.cuong.shop.repositories.ContactRepo;

@Controller
public class ContactController extends BaseController {
	
	@Autowired ContactRepo contactRepo;
	
	@RequestMapping(value = { "/contact" }, method = RequestMethod.GET)
	public String contact(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		String name = request.getParameter("name");
//		System.out.println("Contact URL [Name]: " + name);
		model.addAttribute("name", name);
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		model.addAttribute("contact", new ContactDTO());
		return "front-end/contact";
	}
	
//	//Cách 1
//	@RequestMapping(value = { "/contact1" }, method = RequestMethod.POST)
//	public String contact1(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
//			throws Exception {
//		String email = request.getParameter("email");
//		System.out.println("Contact[Email]: " + email);
//		return "front-end/contact";
//	}
	
//	//Cách 2
//	@RequestMapping(value = { "/contact2" }, method = RequestMethod.POST)
//	public String contact2(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
//			@ModelAttribute("contact") Contact contact) throws Exception {
//		System.out.println("Contact[Email]: " + contact.getEmail());
//		System.out.println("Contact[Name]: " + contact.getName());
//		System.out.println("Contact[Content]: " + contact.getContent());
//		return "front-end/contact";
//	}
	
	@RequestMapping(value = { "/contact" }, method = RequestMethod.POST)
	public ResponseEntity<AjaxResponse> contact3(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@RequestBody ContactDTO contactDTO)
			throws Exception {
		try {
			if(contactDTO.getName().isEmpty()) throw new Exception();
			if(contactDTO.getEmail().isEmpty()) throw new Exception();
			if(contactDTO.getContent().isEmpty()) throw new Exception();
			
			Contact contact = new Contact();
			contact.setName(contactDTO.getName());
			contact.setEmail(contactDTO.getEmail());
			contact.setContent(contactDTO.getContent());
			contact.setCreatedDate(new Date());
			contact.setStatus(false);
			
			contactRepo.save(contact);
			return ResponseEntity.ok(new AjaxResponse(200, "Gửi thành công."));
		} catch (Exception e) {
			return ResponseEntity.ok(new AjaxResponse(400, "Thông tin không hợp lệ."));
		}
	}
}
