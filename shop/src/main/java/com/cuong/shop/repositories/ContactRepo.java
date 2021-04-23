package com.cuong.shop.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cuong.shop.entities.Contact;


public interface ContactRepo extends JpaRepository<Contact, Integer> {

}
