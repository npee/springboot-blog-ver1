package com.npee.npeeblog.controller;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.repository.BlogJpaRepository;
import com.npee.npeeblog.model.repository.UserJpaRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
@Slf4j
public class HomeController {
    private final UserJpaRepository userJpaRepository;
    private final BlogJpaRepository blogJpaRepository;

    @GetMapping
    public String getString(HttpSession session) {
        log.debug("홈 화면[GET]");

        List<Blog> blogs = blogJpaRepository.findAll();
        session.setAttribute("blogs", blogs);
        return "index";
    }
}
