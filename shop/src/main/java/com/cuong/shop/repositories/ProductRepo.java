package com.cuong.shop.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cuong.shop.entities.Product;


public interface ProductRepo extends JpaRepository<Product, Integer> {

}
