package com.cuong.shop.services;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cuong.shop.entities.Category;
import com.cuong.shop.repositories.CategoryRepo;


@Service
public class CategoryService {

	@Autowired
	CategoryRepo categoryRepo;
	
	@PersistenceContext
	EntityManager entityManager;
	
	@Transactional(rollbackOn = Exception.class)
	public void saveOrUpdate(Category category) throws Exception {
		try {
			categoryRepo.save(category);	
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	public Category search(String categorySeo) {
		String jpql = "SELECT c FROM Category c where c.seo = '" + categorySeo + "'";
		Query query = entityManager.createQuery(jpql, Category.class);
		try {
			return (Category) query.getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}
	
	

	public List<Category> getAllParents() {
		String jpql = "select * from tbl_category tc where tc.parent_id is null";
		Query query = entityManager.createNativeQuery(jpql, Category.class);
		return query.getResultList();
	}
}
