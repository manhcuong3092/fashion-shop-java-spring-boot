package com.cuong.shop.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cuong.shop.entities.Color;


public interface ColorRepo extends JpaRepository<Color, Integer> {

}
