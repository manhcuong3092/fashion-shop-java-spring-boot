package com.cuong.shop.services;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.cuong.shop.dto.SaleOrderSearch;
import com.cuong.shop.entities.SaleOrder;
import com.cuong.shop.repositories.SaleOrderRepo;


@Service
public class SaleOrderService {
	
	@Autowired
	SaleOrderRepo saleOrderRepo;
	
	@PersistenceContext
	EntityManager entityManager;
	
	public List<SaleOrder> search(SaleOrderSearch saleOrderSearch) {
		String jpql = "SELECT so FROM SaleOrder so where 1=1";
		
		if(!StringUtils.isEmpty(saleOrderSearch.getSeo())) {
			jpql = jpql + " AND so.seo = '" + saleOrderSearch.getSeo() + "'";
		}
		
		if(!StringUtils.isEmpty(saleOrderSearch.getCustomerName())) {
			jpql = jpql + " AND so.customerName = '" + saleOrderSearch.getCustomerName() + "'";
		}
		
		if(!StringUtils.isEmpty(saleOrderSearch.getCustomerAddress())) {
			jpql = jpql + " AND so.customerAddress = '" + saleOrderSearch.getCustomerAddress() + "'";
		}
		
		if(!StringUtils.isEmpty(saleOrderSearch.getOrderStatus())) {
			jpql = jpql + " AND so.orderStatus = '" + saleOrderSearch.getOrderStatus() + "'";
		}
		
		if(!StringUtils.isEmpty(saleOrderSearch.getUserId())) {
			jpql = jpql + " AND so.user.id = " + saleOrderSearch.getUserId();
		}
		
		if(saleOrderSearch.getLimitDate() != null) {
			jpql = jpql + " AND so.createdDate > :limitDate";
		}
		
		if(!StringUtils.isEmpty(saleOrderSearch.getUserId())) {
			jpql = jpql + " ORDER BY so.createdDate DESC";
		}
		
		Query query = entityManager.createQuery(jpql, SaleOrder.class);
		
		if(saleOrderSearch.getLimitDate() != null) {
			query.setParameter("limitDate", saleOrderSearch.getLimitDate());
		}
		
		if (saleOrderSearch.getOffset() != null) {
			saleOrderSearch.setCount(query.getResultList().size());
			
			query.setFirstResult(saleOrderSearch.getOffset());
		}
		// paging
		return query.getResultList();
	}
}
