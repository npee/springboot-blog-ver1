package com.npee.npeeblog.model.repository;

import com.npee.npeeblog.model.entity.Blog;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface BlogJpaRepository extends JpaRepository<Blog, Long> {
    Optional<Blog> findByBlogNo(Long blogNo);
}
