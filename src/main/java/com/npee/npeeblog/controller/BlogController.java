package com.npee.npeeblog.controller;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.entity.Category;
import com.npee.npeeblog.model.entity.Post;
import com.npee.npeeblog.model.entity.User;
import com.npee.npeeblog.model.repository.BlogJpaRepository;
import com.npee.npeeblog.model.repository.CategoryJpaRepository;
import com.npee.npeeblog.model.repository.UserJpaRepository;
import com.npee.npeeblog.service.BlogServiceImpl;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/{nickname}")
@AllArgsConstructor
@Slf4j
public class BlogController {

    private final UserJpaRepository userJpaRepository;
    private final BlogJpaRepository blogJpaRepository;
    private final CategoryJpaRepository categoryJpaRepository;
    private final BlogServiceImpl blogService;

    @GetMapping
    public String blogMain(@PathVariable String nickname, HttpSession session) {
        // PathVariable에 해당하는 nickname을 가진 User의 블로그 정보로
        // 세션의 내용을 모두 교체한 후 페이지를 불러온다

        // Optional<User> bloger = userJpaRepository.findByUserPk_Nickname(nickname);
        Optional<User> bloger = userJpaRepository.findByNickname(nickname);
        session.setAttribute("bloger", bloger);

        if (bloger.isPresent()) {
            // Optional<Blog> blog = blogJpaRepository.findByBlogNo(bloger.get().getBlogTable().getBlogNo());
            Optional<Blog> blog = blogJpaRepository.findByBlogNo(bloger.get().getUserNo());
            session.setAttribute("blog", blog);

            List<Optional<Category>> categories = categoryJpaRepository.findAllByBlogTable_BlogNo(blog.get().getBlogNo());
            session.setAttribute("categories", categories);
        }

        return "blog/blog";
    }

    @PostMapping("/write")
    public String write(@PathVariable String nickname,
                        @RequestParam Long categoryNo,
                        @RequestParam String postTitle,
                        @RequestParam String postBody,
                        HttpSession session) {

        Category category = categoryJpaRepository.findById(categoryNo).get();
        Post post = blogService.builder(category, postTitle, postBody);

        // log.debug("New Post Created: " + post.toString());

        session.setAttribute("post", post);

        return "blog/blog";
    }

    @GetMapping("/{post}")
    public String read(@PathVariable Long post, HttpSession session) {

        return "blog/post";
    }
}
