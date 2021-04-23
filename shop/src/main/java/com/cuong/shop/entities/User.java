package com.cuong.shop.entities;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

@Entity
@Table(name = "tbl_users")
public class User extends BaseEntity implements UserDetails {
	@Column(name = "username", length = 1000, nullable = false)
	private String username;
	
	@Column(name = "password", length = 1000, nullable = false)
	private String password;
	
	@Column(name = "email", length = 1000, nullable = false)
	private String email;
	
	@Column(name = "fullname", length = 200, nullable = false)
	private String fullname;
	
	@Column(name = "address", length = 500, nullable = false)
	private String address;
	
	@Column(name = "phone", length = 45, nullable = false)
	private String phone;
	
	@Column(name = "avatar", length = 500, nullable = true)
	private String avatar;
	
	@ManyToMany(
		cascade = {CascadeType.PERSIST, CascadeType.REFRESH, CascadeType.REMOVE, CascadeType.DETACH},
		fetch = FetchType.EAGER)
	@JoinTable(name = "tbl_users_roles", joinColumns = @JoinColumn(name = "user_id"), inverseJoinColumns = @JoinColumn(name = "role_id"))
	private List<Role> roles = new ArrayList<Role>();
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "user", fetch = FetchType.LAZY)
	private List<SaleOrder> saleOrders = new ArrayList<SaleOrder>();
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "user", fetch = FetchType.LAZY)
	private List<Comment> comments = new ArrayList<Comment>();
	
	public void addRoles(Role role) {
		role.getUsers().add(this);
		roles.add(role);
	}
	
	public void removeRole(Role role) {
		role.getUsers().remove(this);
		roles.remove(role);
	}
	
	public void addSaleOrder(SaleOrder saleOrder) {
		saleOrders.add(saleOrder);
		saleOrder.setUser(this);
	}
	
	public void removeProductImages(SaleOrder saleOrder) {
		saleOrders.remove(saleOrder);
		saleOrder.setUser(null);
	}
	
	public void addComment(Comment comment) {
		comments.add(comment);
		comment.setUser(this);
	}
	
	public void removeComment(Comment comment) {
		comments.remove(comment);
		comment.setUser(null);
	}

	public String getUsername() {
		return username;
	}
	

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
	
	public List<SaleOrder> getSaleOrders() {
		return saleOrders;
	}

	public void setSaleOrders(List<SaleOrder> saleOrders) {
		this.saleOrders = saleOrders;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return this.roles;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		return this.getStatus();
	}
	
	
}
