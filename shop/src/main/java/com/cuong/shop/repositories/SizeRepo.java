package com.cuong.shop.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cuong.shop.entities.Size;


public interface SizeRepo extends JpaRepository<Size, Integer> {

}
