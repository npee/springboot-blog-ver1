package com.npee.npeeblog.model.repository;

import com.npee.npeeblog.model.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface PostJpaRepository extends JpaRepository<Post, Long> {
    Optional<Post> findByPostNo(Long postNo);
    Optional<List<Post>> findAllByPostFromBlog_BlogNo(Long blogNo);
    Optional<List<Post>> findAllByPostFromBlog_BlogFromUser_UserNo(Long userNo);
    Optional<List<Post>> findAllByPostFromCategory_CategoryNo(Long categoryNo);
}
