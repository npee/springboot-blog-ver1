package com.npee.npeeblog.model.repository;

import com.npee.npeeblog.model.entity.Category;
import com.npee.npeeblog.model.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CategoryJpaRepository extends JpaRepository<Category, Long> {
    Optional<List<Category>> findAllByCategoryFromBlog_BlogNo(Long blogNo);
    Optional<Category> findByCategoryNo(Long categoryNo);
}
