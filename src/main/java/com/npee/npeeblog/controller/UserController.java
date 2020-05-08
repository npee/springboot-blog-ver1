package com.npee.npeeblog.controller;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.repository.BlogJpaRepository;
import com.npee.npeeblog.model.entity.User;
import com.npee.npeeblog.model.repository.UserJpaRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

@Controller
@RequestMapping("/")
@RequiredArgsConstructor
@Slf4j
public class UserController {

    private final UserJpaRepository userJpaRepository;
    private final BlogJpaRepository blogJpaRepository;

    @GetMapping("/users")
    @ResponseBody
    public String readAllUsers() {
        return "User List";
    }

    @PostMapping("/user")
    public String createUser(
            @RequestParam String email,
            @RequestParam String password) {

        Optional<User> user = userJpaRepository.findByEmail(email);
        if (user.isPresent()) {
            log.debug("이미 존재하는 사용자입니다.");
            return "redirect:/";
        }

        Date date = new Date();
        SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
        String now = format.format(date);

        // parsing
        String[] splitEmail = email.split("@");
        String nickname = splitEmail[0];

        userJpaRepository.save(User.builder()
                .email(email)
                .password(password)
                .nickname(nickname)
                .registerDate(now)
                .build());

        blogJpaRepository.save(Blog.builder()
                .title(nickname + "의 블로그")
                .image("default url")
                .count(0L)
                .registerDate(now)
                .build());

        return "redirect:/";
    }
}
