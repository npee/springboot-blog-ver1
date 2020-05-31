package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.*;
import com.npee.npeeblog.model.repository.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Slf4j
public class BlogServiceImpl implements BlogService, CategoryService, PostService, ReplyService{

    private final UserJpaRepository userJpaRepository;
    private final BlogJpaRepository blogJpaRepository;
    private final CategoryJpaRepository categoryJpaRepository;
    private final PostJpaRepository postJpaRepository;
    private final ReplyJpaRepository replyJpaRepository;

    @Override
    public void initSession(String nickname, HttpSession session) {
        Optional<User> optBloger;
        Optional<Blog> optBlog;
        Optional<List<Category>> optCategories;
        Optional<List<Post>> optPosts;

        session.removeAttribute("bloger");
        session.removeAttribute("blog");
        session.removeAttribute("categoires");
        session.removeAttribute("posts");

        optBloger = userJpaRepository.findByNickname(nickname);
        if (optBloger.isPresent()) {
            session.setAttribute("bloger", optBloger.get());

            optBlog = blogJpaRepository.findByBlogNo(optBloger.get().getUserNo());
            optBlog.ifPresent(blog -> session.setAttribute("blog", blog));

            if (optBlog.isPresent()) {
                optCategories = categoryJpaRepository.findAllByCategoryFromBlog_BlogNo(optBlog.get().getBlogNo());
                optCategories.ifPresent(categories -> session.setAttribute("categories", categories));

                optPosts = postJpaRepository.findAllByPostFromBlog_BlogNo(optBlog.get().getBlogNo());
                optPosts.ifPresent(posts -> session.setAttribute("posts", posts));
            }
        }
    }

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
        return builder(blog, null, category, description);
    }

    @Override
    public Category builder(Blog blog, Long categoryNo, String category, String description) {
        return Category.builder()
                .categoryNo(categoryNo)
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

    @Override
    public Reply builder(Long replyNo, String reply, String isBlind, Post post, User user) {
        return Reply.builder()
                .replyNo(replyNo)
                .reply(reply)
                .isBlind(isBlind)
                .registerDate(LocalDateTime.now().plusHours(9L))
                .modifyDate(LocalDateTime.now().plusHours(9L))
                .replyFromPost(post)
                .replyFromUser(user)
                .build();
    }
}
