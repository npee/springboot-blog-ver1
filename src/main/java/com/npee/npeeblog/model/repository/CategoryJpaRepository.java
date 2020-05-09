package com.npee.npeeblog.model.repository;

import com.npee.npeeblog.model.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CategoryJpaRepository extends JpaRepository<Category, Long> {
    List<Optional<Category>> findAllByBlogTable_BlogNo(Long blogNo);
}
