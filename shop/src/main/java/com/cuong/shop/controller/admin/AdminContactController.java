package com.cuong.shop.controller.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cuong.shop.dto.AjaxResponse;
import com.cuong.shop.entities.Contact;
import com.cuong.shop.repositories.ContactRepo;


@Controller
public class AdminContactController {
	@Autowired
	private ContactRepo contactRepo;
	
	@RequestMapping(value = { "/admin/contacts" }, method = RequestMethod.GET)
	public String allContacts(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) 
			throws Exception {
		model.addAttribute("contacts", contactRepo.findAll());
		return "back-end/contact/all-contacts";
	}
	
	@RequestMapping(value = { "/admin/contact/{contactId}" }, method = RequestMethod.PATCH)
	public ResponseEntity<AjaxResponse> responseContact(final ModelMap model, final HttpServletRequest request, 
			final HttpServletResponse response, @PathVariable("contactId") int contactId) throws Exception {
		Contact contact = contactRepo.findById(contactId).get();
		contact.setStatus(true);
		contactRepo.save(contact);
		return ResponseEntity.ok(new AjaxResponse(200, "OK"));
	}
	
	@RequestMapping(value = { "/admin/contact/delete/{contactId}" }, method = RequestMethod.DELETE)
	public ResponseEntity<AjaxResponse> deleteContact(final ModelMap model, final HttpServletRequest request, 
			final HttpServletResponse response, @PathVariable("contactId") int contactId) throws Exception {
		Contact contact = contactRepo.findById(contactId).get();
		contactRepo.delete(contact);
		return ResponseEntity.ok(new AjaxResponse(200, "OK"));
	}
}