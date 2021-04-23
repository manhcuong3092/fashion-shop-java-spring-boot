package com.cuong.shop.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cuong.shop.entities.SaleOrderProduct;


public interface SaleOrderProductRepo extends JpaRepository<SaleOrderProduct, Integer> {

}
