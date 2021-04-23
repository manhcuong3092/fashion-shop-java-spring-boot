package com.cuong.shop.dto;

import java.math.BigDecimal;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.util.StringUtils;

public class ProductSearch {

	private String seo;
	private Integer categoryId;
	private String searchText;
	private String gender;
	private String size;
	private String color;
	private String order;
	private BigDecimal min;
	private BigDecimal max;

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

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}


	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public void setOffset(Integer offset) {
		this.offset = offset;
	}
	
	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
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

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public BigDecimal getMin() {
		return min;
	}

	public void setMin(BigDecimal min) {
		this.min = min;
	}

	public BigDecimal getMax() {
		return max;
	}

	public void setMax(BigDecimal max) {
		this.max = max;
	}
}
