package com.cuong.shop.entities;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import ch.qos.logback.core.subst.Token.Type;

@Entity
@Table(name= "tbl_posts")
public class Post extends BaseEntity {
	@Column(name = "title", length = 1000, nullable = false)
	private String title;
	
	@Column(name = "content", columnDefinition = "LONGTEXT", nullable = false)
	private String content;
	
	@Column(name = "seo", length = 1000, nullable = false)
	private String seo;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "blog_category_id")
	private BlogCategory blogCategory;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public BlogCategory getBlogCategory() {
		return blogCategory;
	}

	public void setBlogCategory(BlogCategory blogCategory) {
		this.blogCategory = blogCategory;
	}
	
	
	
}
