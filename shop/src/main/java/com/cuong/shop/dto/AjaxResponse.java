package com.cuong.shop.dto;

public class AjaxResponse {
	private int status;
	private Object data;
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	public AjaxResponse(int status, Object data) {
		super();
		this.status = status;
		this.data = data;
	}
	
	
}
