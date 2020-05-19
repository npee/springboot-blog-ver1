package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.entity.Category;
import com.npee.npeeblog.model.entity.Post;
import com.npee.npeeblog.model.entity.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class BlogServiceImpl implements BlogService, CategoryService, PostService{

    @Override
    public Blog builder(User user, String nickname) {
        return Blog.builder()
                .blogFromUser(user)
                .title(nickname + "의 블로그")
                .image("default url")
                .count(0L)
                .registerDate(LocalDateTime.now().plusHours(9L))
                .blogNo(user.getUserNo())
                .build();
    }

    @Override
    public Category builder(Blog blog) {
        return builder(blog, "샘플 카테고리");
    }

    @Override
    public Category builder(Blog blog, String category) {
        return builder(blog, category, "카테고리에 대한 설명을 작성해주세요.");
    }

    @Override
    public Category builder(Blog blog, String category, String description) {
        return Category.builder()
                .categoryFromBlog(blog)
                .category(category)
                .description(description)
                .build();
    }


    @Override
    public Post builder(Long postNo, Category category, Blog blog, String postTitle, String postBody) {
        if (postNo.equals(0L)) {
            postNo = null;
        }
        return Post.builder()
                .postNo(postNo)
                .postFromCategory(category)
                .postFromBlog(blog)
                .title(postTitle)
                .body(postBody)
                .count(0L)
                // 빈 댓글 리스트가 필요할까?
                .registerDate(LocalDateTime.now().plusHours(9L))
                .modifyDate(LocalDateTime.now().plusHours(9L))
                .build();
    }
}
