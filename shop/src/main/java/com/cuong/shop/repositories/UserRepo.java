package com.cuong.shop.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cuong.shop.entities.User;



public interface UserRepo extends JpaRepository<User, Integer> {

}
