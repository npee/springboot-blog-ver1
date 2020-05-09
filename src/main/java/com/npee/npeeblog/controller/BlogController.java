package com.npee.npeeblog.controller;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.entity.Category;
import com.npee.npeeblog.model.entity.User;
import com.npee.npeeblog.model.repository.BlogJpaRepository;
import com.npee.npeeblog.model.repository.CategoryJpaRepository;
import com.npee.npeeblog.model.repository.UserJpaRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/")
@AllArgsConstructor
public class BlogController {

    private final UserJpaRepository userJpaRepository;
    private final BlogJpaRepository blogJpaRepository;
    private final CategoryJpaRepository categoryJpaRepository;

    @GetMapping("/{nickname}")
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
}
