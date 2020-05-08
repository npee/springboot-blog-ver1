package com.npee.npeeblog.controller;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.repository.BlogJpaRepository;
import com.npee.npeeblog.model.entity.User;
import com.npee.npeeblog.model.repository.UserJpaRepository;
import com.npee.npeeblog.service.BlogServiceImpl;
import com.npee.npeeblog.service.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
@Slf4j
public class UserController {

    private final UserJpaRepository userJpaRepository;
    private final BlogJpaRepository blogJpaRepository;
    private final UserServiceImpl userService;
    private final BlogServiceImpl blogService;

    @GetMapping("/users")
    @ResponseBody
    public String readAllUsers() {
        return "User List";
    }

    @GetMapping("/signup")
    public String signup_get() {
        return "/sign/signup";
    }

    @PostMapping("/signup")
    public String signup(
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String nickname) {

        Optional<User> user = userJpaRepository.findByEmail(email);
        if (user.isPresent()) {
            log.debug("이미 존재하는 사용자입니다.");
            return "redirect:/";
        }

        User tempUser = userService.builder(email, password, nickname);
        blogService.builder(tempUser, nickname);

        log.debug("singup success");

        return "redirect:/";
    }

    @GetMapping("/signin")
    public String signin_get() {
        log.debug("call signin page");
        return "/sign/signin";
    }

    @PostMapping("/signin")
    public String signin(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session) {

        Optional<User> user = userJpaRepository.findByEmailAndPassword(email, password);

        session.setAttribute("user", user);
        log.debug("user added");
        return "redirect:/";
    }

    @GetMapping("/signout")
    public String signout(HttpSession session) {
        session.invalidate();
        log.debug("session invalidated");
        return "/sign/signout";
    }
}
