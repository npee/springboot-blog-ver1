package com.npee.npeeblog.model.repository;

import com.npee.npeeblog.model.entity.Category;
import com.npee.npeeblog.model.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

public interface CategoryJpaRepository extends JpaRepository<Category, Long> {
    Optional<List<Category>> findAllByCategoryFromBlog_BlogNo(Long blogNo);
    Optional<Category> findByCategoryNo(Long categoryNo);
    @Transactional // 삭제 메서드에는 @Transactional이 들어가지 않는다? - TransactionRequiredException
    Optional<Category> deleteByCategoryNo(Long categoryNo);
}
