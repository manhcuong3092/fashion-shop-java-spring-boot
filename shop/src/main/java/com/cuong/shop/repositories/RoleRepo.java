package com.cuong.shop.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cuong.shop.entities.Role;


public interface RoleRepo extends JpaRepository<Role, Integer> {

}
