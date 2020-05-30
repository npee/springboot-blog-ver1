package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.entity.Category;
import com.npee.npeeblog.model.entity.Post;
import com.npee.npeeblog.model.entity.User;
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
public class BlogServiceImpl implements BlogService, CategoryService, PostService{

    private final UserJpaRepository userJpaRepository;
    private final BlogJpaRepository blogJpaRepository;
    private final CategoryJpaRepository categoryJpaRepository;
    private final PostJpaRepository postJpaRepository;
    private final ReplyJpaRepository replyJpaRepository;

    @Override
    public void initSession(String nickname, HttpSession session) {
        Optional<User> bloger;
        Optional<Blog> blog;
        Optional<List<Category>> categories;
        Optional<List<Post>> posts;

        session.removeAttribute("bloger");
        session.removeAttribute("blog");
        session.removeAttribute("categoires");
        session.removeAttribute("posts");

        bloger = userJpaRepository.findByNickname(nickname);
        if (bloger.isPresent()) {
            session.setAttribute("bloger", bloger.get());

            blog = blogJpaRepository.findByBlogNo(bloger.get().getUserNo());
            blog.ifPresent(myblog -> session.setAttribute("blog", myblog));

            if (blog.isPresent()) {
                categories = categoryJpaRepository.findAllByCategoryFromBlog_BlogNo(blog.get().getBlogNo());
                categories.ifPresent(myCategories -> session.setAttribute("categories", myCategories));

                posts = postJpaRepository.findAllByPostFromBlog_BlogNo(blog.get().getBlogNo());
                posts.ifPresent(myPosts -> session.setAttribute("posts", myPosts));
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
}
