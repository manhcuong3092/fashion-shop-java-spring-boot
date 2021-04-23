package com.cuong.shop.entities;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name = "tbl_category")
public class Category extends BaseEntity {

	@Column(name = "name", nullable = false)
	private String name;

	@Column(name = "description", length = 1000, nullable = true)
	private String description;

	@Column(name = "seo", length = 1000, nullable = false)
	private String seo;
	
	@Column(name = "parent_id", nullable = true)
	private Integer parentId;
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "category", fetch = FetchType.LAZY)
	private List<Product> products = new ArrayList<Product>();
	
	@OneToMany(fetch = FetchType.EAGER)
	@JoinColumn(name = "parent_id")
	private Set<Category> children = new HashSet<Category>();

	public void addProduct(Product product) {
		products.add(product);
		product.setCategory(this);
	}
	
	public void removeProduct(Product product) {
		products.remove(product);
		product.setCategory(null);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public List<Product> getProducts() {
		return products;
	}

	public Set<Category> getChildren() {
		return children;
	}

	public void setChilden(Set<Category> children) {
		this.children = children;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	
	
}
