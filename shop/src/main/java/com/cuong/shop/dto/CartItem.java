package com.cuong.shop.dto;

import java.math.BigDecimal;

public class CartItem {
	private int productId;
	private String productName;
	private int quantity;
	private BigDecimal priceUnit;
	private String avatar;
	private String size;
	private String color;
	
	
	public int getProductId() {
		return productId;
	}
	public void setProductId(int productId) {
		this.productId = productId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public BigDecimal getPriceUnit() {
		return priceUnit;
	}
	public void setPriceUnit(BigDecimal priceUnit) {
		this.priceUnit = priceUnit;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
	
}
