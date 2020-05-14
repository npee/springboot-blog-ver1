package com.npee.npeeblog.model.repository;

import com.npee.npeeblog.model.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PostJpaRepository extends JpaRepository<Post, Long> {
}
