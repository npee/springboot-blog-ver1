package com.npee.npeeblog.controller;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.entity.User;
import com.npee.npeeblog.model.repository.BlogJpaRepository;
import com.npee.npeeblog.model.repository.CategoryJpaRepository;
import com.npee.npeeblog.model.repository.UserJpaRepository;
import com.npee.npeeblog.service.BlogServiceImpl;
import com.npee.npeeblog.service.UserServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Optional;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
@Slf4j
public class UserController {

    private final UserJpaRepository userJpaRepository;
    private final BlogJpaRepository blogJpaRepository;
    private final CategoryJpaRepository categoryJpaRepository;
    private final UserServiceImpl userService;
    private final BlogServiceImpl blogService;

    @GetMapping("/signup")
    public String signup_get() {
        log.debug("회원가입 페이지[GET]");

        return "/sign/signup";
    }

    @PostMapping("/signup")
    public String signup(
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String nickname) {
        log.debug("회원가입 페이지[POST]");

        /**
         * 해당 이메일이 DB에 이미 존재하면 회원가입을 중지하고 홈 화면으로 리다이렉트
         */
        Optional<User> user = userJpaRepository.findByEmail(email);
        if (user.isPresent()) {
            log.debug("이미 존재하는 사용자입니다.");
            return "redirect:/";
        }

        User tempUser = userJpaRepository.save(userService.builder(email, password, nickname));
        Blog tempBlog = blogJpaRepository.save(blogService.builder(tempUser, nickname));
        categoryJpaRepository.save(blogService.builder(tempBlog));

        log.debug("회원가입 성공!");
        log.debug(tempUser.toString());

        return "redirect:/";
    }

    @GetMapping("/signin")
    public String signin_get(HttpServletRequest request, HttpSession session) {
        log.debug("로그인 페이지[GET]");

        /**
         * 마지막 방문 페이지 URL 얻어서 세션에 등록
         */
        log.debug("Http Header에서 referer를 추출하여 세션에 등록합니다...");
        String referer = request.getHeader("referer");

        /**
         * 세션에 사용자가 존재하면 이전 페이지로 리다이렉트
         * 잘못된 접근(사용자가 URL을 통하여 로그인 페이지에 직접 접근하는 경우)
         */
        if (session.getAttribute("user") != null) {
            log.debug("세션에 사용자가 존재합니다. 비정상적인 접근으로 판단됩니다...");
            log.debug("Base url으로 리다이렉트됩니다.");
            return "redirect:/";
        }

        /**
         * Referer 조건부 변경
         * 인증 관련 페이지에서 로그인 페이지로 넘어가는 경우
         * 로그인 성공 시 이전 페이지로 이동할 필요가 없으므로 홈 화면으로 리다이렉트 유도
         */
        if (referer.contains("http://localhost:8080/user/")) {
            log.debug("사용자 인증 관련 referer를 base url으로 변경합니다...");
            referer = "http://localhost:8080/";
        }

        /**
         * 세션에 referer 등록
         */
        session.setAttribute("referer", referer);
        log.debug("Referer: " + referer);
        log.debug("Referer 등록 완료!");

        return "/sign/signin";
    }

    @PostMapping("/signin")
    public String signin(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session) {
        log.debug("로그인 페이지[POST]");

        /**
         * 로그인 성공 시 사용자 정보를 세션에 등록
         * TODO: 로그인 예외 방어 코드 작성(orElseThrow() 메서드?)
         */
        User user = userJpaRepository.findByEmailAndPassword(email, password).get();
        session.setAttribute("user", user);

        /**
         * 로그인 직전 페이지로 이동하기 위해 세션에 등록된 referer로 리다이렉트
         */
        String referer = (String) session.getAttribute("referer");
        log.debug("로그인 하기 전 페이지로 리다이렉트됩니다..." + referer);
        return "redirect:" + referer;
    }

    @GetMapping("/signout")
    public String signout(HttpSession session) {
        log.debug("로그아웃 페이지[GET]");

        session.invalidate();
        return "/sign/signout";
    }
}
