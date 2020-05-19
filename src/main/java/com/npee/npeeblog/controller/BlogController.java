package com.npee.npeeblog.controller;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.entity.Category;
import com.npee.npeeblog.model.entity.Post;
import com.npee.npeeblog.model.entity.User;
import com.npee.npeeblog.model.repository.BlogJpaRepository;
import com.npee.npeeblog.model.repository.CategoryJpaRepository;
import com.npee.npeeblog.model.repository.PostJpaRepository;
import com.npee.npeeblog.model.repository.UserJpaRepository;
import com.npee.npeeblog.service.BlogServiceImpl;
import com.npee.npeeblog.service.UserService;
import com.npee.npeeblog.service.UserServiceImpl;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
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
    private final PostJpaRepository postJpaRepository;
    private final UserServiceImpl userService;
    private final BlogServiceImpl blogService;

    @GetMapping
    public String blogMain(@PathVariable String nickname, HttpSession session) {
        // PathVariable에 해당하는 nickname을 가진 User의 블로그 정보로
        // 세션의 내용을 모두 교체한 후 페이지를 불러온다

        Optional<User> bloger;
        Optional<Blog> blog;
        Optional<List<Category>> categories;
        Optional<List<Post>> posts;

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

        return "blog/blog";
    }

    @GetMapping("/write")
    public String write_page(HttpSession session) {
        session.removeAttribute("post");
        Blog blog = (Blog) session.getAttribute("blog");
        // Post post = blogService.builder(null, blog, "글쓰기", "");
        Post post = Post.builder()
                .postFromCategory(null)
                .postFromBlog(blog)
                .title("")
                .body("")
                .count(0L)
                .registerDate(LocalDateTime.now().plusHours(9L))
                .modifyDate(LocalDateTime.now().plusHours(9L))
                .build();
        session.setAttribute("post", post);
        return "blog/write";
    }

    @PostMapping("/write")
    public String write(@PathVariable String nickname,
                        @RequestParam Long postNo,
                        @RequestParam Long categoryNo,
                        @RequestParam String postTitle,
                        @RequestParam String postBody,
                        HttpSession session) {

        // TODO: 방어코드 작성
        Category category = categoryJpaRepository.findById(categoryNo).get();
        Blog blog = blogJpaRepository.findByBlogFromUser_Nickname(nickname).get();
        Post post = postJpaRepository.save(blogService.builder(postNo, category, blog, postTitle, postBody));

        session.setAttribute("newPost", post);

        String postRedirectUrl = nickname + "/" + post.getPostNo();
        return "redirect:/" + postRedirectUrl;
    }

    @GetMapping("/update")
    public String update_page() {
        return "blog/write";
    }

    @GetMapping("/{postNo}")
    public String read(@PathVariable String nickname, @PathVariable Long postNo, HttpSession session) {

//        if (session.getAttribute("user") == null) {
//            User user = userService.builder("anonymous", "admin", "anonymous");
//            session.setAttribute("user", user);
//        }
        session.removeAttribute("post");

        // TODO: 방어코드 작성
        Post post = postJpaRepository.findByPostNo(postNo).get();
        Blog blog = blogJpaRepository.findByBlogFromUser_Nickname(nickname).get();
        User bloger = userJpaRepository.findByNickname(nickname).get();

        Long currentBlogNo = post.getPostFromBlog().getBlogNo();

        List<Post> posts = postJpaRepository.findAllByPostFromBlog_BlogNo(currentBlogNo).get();
        Long blogNoOfCurrentPost = blog.getBlogFromUser().getUserNo();

        if (currentBlogNo.equals(blogNoOfCurrentPost)) {
            // Long blogNo = ((Blog) session.getAttribute("blog")).getBlogNo();

            Long count = post.getCount();
            post.setCount(++count);

            // Long categoryNo = post.getCategoryTable().getCategoryNo();
            // String categoryName = categoryJpaRepository.findByCategoryNo(categoryNo).get().getCategory();
            session.setAttribute("bloger", bloger);
            session.setAttribute("posts", posts);
            session.setAttribute("post", post);
            postJpaRepository.save(post);
        }

        return "blog/post";
    }

    @GetMapping("/categories")
    public String getCategories() {
        return "redirect:/";
    }

    @PostMapping("/category")
    public String createCategory(@PathVariable String nickname,
                                 @RequestParam String categoryName,
                                 @RequestParam String categoryDescription,
                                 HttpSession session) {

        Blog blog = (Blog) session.getAttribute("blog");
        if (categoryDescription == null || categoryDescription.equals("")) {
            blogService.builder(blog, categoryName);
        } else {
            blogService.builder(blog, categoryName, categoryDescription);
        }

        return "redirect:/" + nickname;
    }

}
