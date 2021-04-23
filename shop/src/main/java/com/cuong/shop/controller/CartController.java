package com.cuong.shop.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
import com.cuong.shop.dto.Cart;
import com.cuong.shop.dto.CartItem;
import com.cuong.shop.entities.Product;
import com.cuong.shop.entities.SaleOrder;
import com.cuong.shop.entities.SaleOrderProduct;
import com.cuong.shop.entities.User;
import com.cuong.shop.repositories.ProductRepo;
import com.cuong.shop.repositories.SaleOrderRepo;
import com.cuong.shop.services.EmailService;

@Controller
public class CartController extends BaseController {
	
	@Autowired ProductRepo productRepo;
	
	@Autowired SaleOrderRepo saleOrderRepo;
	
	@Autowired EmailService emailService;
	
	@RequestMapping(value = { "/cart" }, method = RequestMethod.GET)
	public String cart(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		HttpSession httpSession = request.getSession();
		
		return "front-end/shopping-cart";
	}
	
	/*
	 * Add item to cart by ajax
	 * */
	@RequestMapping(value = { "/cart/add" }, method = RequestMethod.POST)
	public ResponseEntity<AjaxResponse> addToCart(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response, @RequestBody CartItem cartItem) {
		HttpSession httpSession = request.getSession();
		
		Cart cart = null;
		if (httpSession.getAttribute("cart") != null) {
			cart = (Cart) httpSession.getAttribute("cart");
		} else {
			cart = new Cart();
			httpSession.setAttribute("cart", cart);
		}

		List<CartItem> cartItems = cart.getCartItems();
		boolean isExists = false;
		for (CartItem item : cartItems) {
			if (item.getProductId() == cartItem.getProductId() && item.getColor().equals(cartItem.getColor()) &&
					item.getSize().equals(cartItem.getSize())) {
				isExists = true;
				item.setQuantity(item.getQuantity() + cartItem.getQuantity());
			}
		}

		if (!isExists) {
			Product productInDb = productRepo.getOne(cartItem.getProductId());
			cartItem.setProductName(productInDb.getTitle());
			cartItem.setAvatar(productInDb.getAvatar());
			if(productInDb.getPriceSale() != null) {
				cartItem.setPriceUnit(productInDb.getPriceSale());
			} else {
				cartItem.setPriceUnit(productInDb.getPrice());
			}
			cart.getCartItems().add(cartItem);
		}
		int total = getTotalItems(request);
		cart.setTotalItems(total);
		
		BigDecimal totalPrice = getTotalPrice(request);
		cart.setTotalPrice(totalPrice);
		
		httpSession.setAttribute("total", total);
		httpSession.setAttribute("totalPrice", totalPrice);
		
		return ResponseEntity.ok(new AjaxResponse(200, cart));
	}
	
	/*
	 * Count number of items in cart
	 * */
	private int getTotalItems(final HttpServletRequest request) {
		HttpSession httpSession = request.getSession();

		if (httpSession.getAttribute("cart") == null) {
			return 0;
		}
		
		Cart cart = (Cart) httpSession.getAttribute("cart");
		List<CartItem> cartItems = cart.getCartItems();
		
		int total = 0;
		for (CartItem item : cartItems) {
			total += item.getQuantity();
		}
		
		return total;
	}
	
	/*
	 * Calculate total price of cart
	 * */
	private BigDecimal getTotalPrice(final HttpServletRequest request) {
		HttpSession httpSession = request.getSession();
		if (httpSession.getAttribute("cart") == null) {
			return BigDecimal.ZERO;
		}
		
		Cart cart = (Cart) httpSession.getAttribute("cart");
		List<CartItem> cartItems = cart.getCartItems();
		
		BigDecimal totalPrice = BigDecimal.ZERO;
		for (CartItem item : cartItems) {
			totalPrice = totalPrice.add(item.getPriceUnit().multiply(new BigDecimal(item.getQuantity())));
		}
		
		return totalPrice;
	}

	/*
	 * Change quantity of item by ajax
	 * */
	@RequestMapping(value = { "/cart/changeQuantity/{productId}/{size}/{color}" }, method = RequestMethod.POST)
	public ResponseEntity<AjaxResponse> changeQuantity(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable int productId, @RequestBody CartItem cartItem)
			throws Exception {
		HttpSession httpSession = request.getSession();
		Cart cart = null;
		if (httpSession.getAttribute("cart") != null) {
			cart = (Cart) httpSession.getAttribute("cart");
		} else {
			cart = new Cart();
			httpSession.setAttribute("cart", cart);
		}
		
		List<CartItem> cartItems = cart.getCartItems();
		boolean isExists = false;
		for (CartItem item : cartItems) {
			if (item.getProductId() == cartItem.getProductId() 
					&& item.getColor().compareToIgnoreCase(cartItem.getColor()) == 0
					&& item.getSize().compareToIgnoreCase(cartItem.getSize()) == 0) {
				isExists = true;
				item.setQuantity(cartItem.getQuantity());
				break;
			}
		}
		
		if (isExists) {
			int total = getTotalItems(request);
			cart.setTotalItems(total);
			
			BigDecimal totalPrice = getTotalPrice(request);
			cart.setTotalPrice(totalPrice);
			
			httpSession.setAttribute("total", total);
			httpSession.setAttribute("totalPrice", totalPrice);
			
			return ResponseEntity.ok(new AjaxResponse(200, cart));
		}
		return new ResponseEntity<AjaxResponse>(HttpStatus.BAD_REQUEST);
	}

	
	/*
	 * Delete item in cart by ajax
	 * */
	@RequestMapping(value = { "/cart/delete/{productId}/{size}/{color}" }, method = RequestMethod.DELETE)
	public ResponseEntity<AjaxResponse> deleteItem(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable int productId, @PathVariable String size, @PathVariable String color)
			throws Exception {
		HttpSession httpSession = request.getSession();
		Cart cart = null;
		if (httpSession.getAttribute("cart") != null) {
			cart = (Cart) httpSession.getAttribute("cart");
		} else {
			cart = new Cart();
			httpSession.setAttribute("cart", cart);
		}
		
		List<CartItem> cartItems = cart.getCartItems();
		boolean isExists = false;
		for (CartItem item : cartItems) {
			if (item.getProductId() == productId && item.getColor().compareToIgnoreCase(color) == 0
					&& item.getSize().compareToIgnoreCase(size) == 0) {
				isExists = true;
				cartItems.remove(item);
				break;
			}
		}
		if (isExists) {
			int total = getTotalItems(request);
			cart.setTotalItems(total);
			
			BigDecimal totalPrice = getTotalPrice(request);
			cart.setTotalPrice(totalPrice);
			
			httpSession.setAttribute("total", total);
			httpSession.setAttribute("totalPrice", totalPrice);
			
			return ResponseEntity.ok(new AjaxResponse(200, cart));
		}
		return new ResponseEntity<AjaxResponse>(HttpStatus.BAD_REQUEST);
	}
	
	/*
	 * Render checkout page
	 * */
	@RequestMapping(value = { "/check-out" }, method = RequestMethod.GET)
	public String checkOut(final ModelMap model, final HttpServletRequest request, final HttpServletResponse response)
			throws Exception {
		return "front-end/check-out";
	}
	
	/*
	 * Post checkout form, store to database 
	 * */
	@RequestMapping(value = { "/check-out" }, method = RequestMethod.POST)
	public String addProduct_Post(final ModelMap model, final HttpServletRequest request,
			final HttpServletResponse response) throws Exception {
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String fullName = request.getParameter("fullname");
		String address = request.getParameter("address");
		
		SaleOrder saleOrder = new SaleOrder();
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (principal instanceof UserDetails) {
			User user = (User) principal;
			email = user.getEmail();
			phone = user.getPhone();
			fullName = user.getFullname();
			address = user.getAddress();
			saleOrder.setUser(user);;
		}
		
		HttpSession httpSession = request.getSession();
		Cart cart = (Cart) httpSession.getAttribute("cart");
		if(cart == null || cart.getCartItems().size() == 0) {
			model.addAttribute("error", "Bạn chưa có hàng trong giỏ");
			return "front-end/check-out";
		}
		List<CartItem> cartItems = cart.getCartItems();
		
		//validate
		try {
			if(fullName.length() == 0 || address.length() == 0 || email.length() == 0 || phone.length() == 0)
				throw new Exception();
			if(!phone.matches("[0-9]{10,11}"))
				throw new Exception();
			if(!email.contains("@"))
				throw new Exception();
		} catch (Exception e) {
			model.addAttribute("error", "Thông tin nhập không hợp lệ");
			return "front-end/check-out";
		}
		
		saleOrder.setCode("ORDER-"+System.currentTimeMillis());
		saleOrder.setSeo("ORDER-"+System.currentTimeMillis());
		saleOrder.setCustomerName(fullName);
		saleOrder.setCustomerAddress(address);
		saleOrder.setCustomerEmail(email);
		saleOrder.setCustomerPhone(phone);
		saleOrder.setTotal(cart.getTotalPrice());
		saleOrder.setCreatedDate(new Date());
		saleOrder.setOrderStatus("Chờ xử lý");
		
		for(CartItem item : cartItems) {
			SaleOrderProduct saleOrderProduct = new SaleOrderProduct();
			saleOrderProduct.setProduct(productRepo.getOne(item.getProductId()));
			saleOrderProduct.setQuantity(item.getQuantity());
			saleOrderProduct.setColor(item.getColor());
			saleOrderProduct.setSize(item.getSize());
			saleOrderProduct.setPrice(item.getPriceUnit());
			saleOrder.addSaleOrderProduct(saleOrderProduct);
		}
		
		saleOrderRepo.save(saleOrder);
		
		//after finish payment, cart must be clean 
		resetCart(request);
		
		//sendEmail
		emailService.sendEmail(saleOrder, email);
		
		model.addAttribute("success", "Đặt hàng thành công!");
		
		return "front-end/check-out";
	}
	
	private void resetCart(final HttpServletRequest request) {
		HttpSession httpSession = request.getSession();
		httpSession.setAttribute("cart", new Cart());
		httpSession.setAttribute("total", 0);
		httpSession.setAttribute("totalPrice", 0);
	}
}
