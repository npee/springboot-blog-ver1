package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.entity.Category;
import com.npee.npeeblog.model.entity.Post;
import com.npee.npeeblog.model.entity.User;
import com.npee.npeeblog.model.repository.BlogJpaRepository;
import com.npee.npeeblog.model.repository.CategoryJpaRepository;
import com.npee.npeeblog.model.repository.PostJpaRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class BlogServiceImpl implements BlogService, CategoryService, PostService{

    private final BlogJpaRepository blogJpaRepository;
    private final CategoryJpaRepository categoryJpaRepository;
    private final PostJpaRepository postJpaRepository;

    @Override
    public Blog builder(User user, String nickname) {
        return blogJpaRepository.save(Blog.builder()
                .userTable(user)
                .title(nickname + "의 블로그")
                .image("default url")
                .count(0L)
                .registerDate(LocalDateTime.now().plusHours(9L))
                .blogNo(user.getUserNo())
                .build());
    }

    @Override
    public Category builder(Blog blog, String category) {
        return categoryJpaRepository.save(Category.builder()
                .blogTable(blog)
                .category(category)
                .build());
    }

    @Override
    public Post builder(Category category, String postTitle, String postBody) {
        return postJpaRepository.save(Post.builder()
                .categoryTable(category)
                .title(postTitle)
                .body(postBody)
                .count(0L)
                // 빈 댓글 리스트가 필요할까?
                .registerDate(LocalDateTime.now().plusHours(9L))
                .modifyDate(LocalDateTime.now().plusHours(9L))
                .build());
    }
}
