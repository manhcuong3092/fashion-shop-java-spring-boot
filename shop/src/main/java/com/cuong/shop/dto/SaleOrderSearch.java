package com.cuong.shop.dto;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.util.StringUtils;

public class SaleOrderSearch {

	private String seo;
	private Integer userId;
	private String customerName;
	private String customerAddress;
	private String orderStatus;
	private Date limitDate;
	
	public Integer offset = null;
	public Integer count = null;
	
	public void buildPaging(HttpServletRequest request) {
		if (!StringUtils.isEmpty(request.getParameter("offset"))) {
			this.offset = Integer.parseInt(request.getParameter("offset"));
		} else {
			this.offset = 0;
		}
	}

	public Integer getOffset() {
		return offset;
	}

	public void setOffset(Integer offset) {
		this.offset = offset;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}
	
	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getCustomerAddress() {
		return customerAddress;
	}

	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}

	public String getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}

	public Date getLimitDate() {
		return limitDate;
	}

	public void setLimitDate(Date limitDate) {
		this.limitDate = limitDate;
	}
	
}
