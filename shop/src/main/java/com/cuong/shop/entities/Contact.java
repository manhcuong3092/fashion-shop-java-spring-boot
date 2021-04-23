package com.cuong.shop.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_contact")
public class Contact extends BaseEntity {
	@Column(name = "name", length = 1000, nullable = false)
	private String name;

	@Column(name = "email", length = 1000, nullable = false)
	private String email;
	
	@Column(name = "content", length = 1000, nullable = false)
	private String content;
	
	@Column(name = "request_type", length = 1000, nullable = true)
	private String requestType;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRequestType() {
		return requestType;
	}

	public void setRequestType(String requestType) {
		this.requestType = requestType;
	}
	
	
	
}
