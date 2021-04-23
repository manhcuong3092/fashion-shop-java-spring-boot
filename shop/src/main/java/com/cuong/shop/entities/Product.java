package com.cuong.shop.entities;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_products")
public class Product extends BaseEntity {
	
	@Column(name = "title", length = 1000, nullable = false)
	private String title;
	
	@Column(name = "price", precision = 13, scale = 2, nullable = false)
	private BigDecimal price;
	
	@Column(name = "price_sale", precision = 13, scale = 2, nullable = true)
	private BigDecimal priceSale;
	
	@Column(name = "short_description", length = 3000, nullable = false)
	private String shortDescription;
	
	@Lob
	@Column(name = "detail_description", columnDefinition = "LONGTEXT", nullable = false)
	private String detailDescription;
	
	@Column(name = "gender", length = 45, nullable = true)
	private String gender;
	
	@Column(name = "avatar", nullable = true)
	private String avatar; 
	
	@Column(name = "seo", length = 1000, nullable = true)
	private String seo;
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "product", fetch = FetchType.EAGER)
	private Set<ProductImages> productImages = new HashSet<ProductImages>();
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "product", fetch = FetchType.EAGER)
	private Set<Comment> comments = new HashSet<Comment>();
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "product", fetch = FetchType.LAZY)
	private List<Size> sizes = new ArrayList<Size>();
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "product", fetch = FetchType.LAZY)
	private List<Color> colors = new ArrayList<Color>();
	
	public void addProductImages(ProductImages productImage) {
		productImages.add(productImage);
		productImage.setProduct(this);
	}
	
	public void removeProductImages(ProductImages productImage) {
		productImages.remove(productImage);
		productImage.setProduct(null);
	}
	
	public void addProductComments(Comment comment) {
		comments.add(comment);
		comment.setProduct(this);
	}
	
	public void removeProductComments(Comment comment) {
		comments.remove(comment);
		comment.setProduct(null);
	}
	
	public void addColor(Color color) {
		colors.add(color);
		color.setProduct(this);
	}
	
	public void removeColor(Color color) {
		colors.remove(color);
		color.setProduct(null);
	}
	
	public void addSize(Size size) {
		sizes.add(size);
		size.setProduct(this);
	}
	
	public void removeSize(Size size) {
		sizes.remove(size);
		size.setProduct(null);
	}
	

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_id")
	private Category category;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getPriceSale() {
		return priceSale;
	}

	public void setPriceSale(BigDecimal priceSale) {
		this.priceSale = priceSale;
	}

	public String getShortDescription() {
		return shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public String getDetailDescription() {
		return detailDescription;
	}

	public void setDetailDescription(String detailDescription) {
		this.detailDescription = detailDescription;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	} 

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Set<ProductImages> getProductImages() {
		return productImages;
	}

	public void setProductImages(Set<ProductImages> productImages) {
		this.productImages = productImages;
	}

	public Set<Comment> getComments() {
		return comments;
	}

	public void setComments(Set<Comment> comments) {
		this.comments = comments;
	}

	public List<Size> getSizes() {
		return sizes;
	}

	public void setSizes(List<Size> sizes) {
		this.sizes = sizes;
	}

	public List<Color> getColors() {
		return colors;
	}

	public void setColors(List<Color> colors) {
		this.colors = colors;
	}
	
	
	
}
