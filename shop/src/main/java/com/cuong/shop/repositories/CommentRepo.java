package com.cuong.shop.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cuong.shop.entities.Comment;


public interface CommentRepo extends JpaRepository<Comment, Integer> {

}
