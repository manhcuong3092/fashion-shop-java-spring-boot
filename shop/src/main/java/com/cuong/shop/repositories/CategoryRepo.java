package com.cuong.shop.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.cuong.shop.entities.Category;


@Repository
public interface CategoryRepo extends JpaRepository<Category, Integer> {

}
