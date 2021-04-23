package com.cuong.shop.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cuong.shop.entities.SaleOrder;


public interface SaleOrderRepo extends JpaRepository<SaleOrder, Integer> {

}
