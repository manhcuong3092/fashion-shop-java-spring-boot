package com.cuong.shop.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_blog_categories")
public class BlogCategory extends BaseEntity {
	@Column(name= "name", length = 100, nullable = false)
	private String name;
	
	@Column(name= "description", length = 500, nullable = false)
	private String description;
	
	@Column(name = "seo", length = 1000, nullable = false)
	private String seo;
	
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "blogCategory", fetch = FetchType.LAZY)
	private List<Post> posts = new ArrayList<>();
	
	public void addPost(Post post) {
		posts.add(post);
		post.setBlogCategory(this);
	}
	
	public void removePost(Post post) {
		posts.remove(post);
		post.setBlogCategory(null);
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

	public void setDescription(String content) {
		this.description = content;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public List<Post> getPosts() {
		return posts;
	}

	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}
	
	
	
	
}
