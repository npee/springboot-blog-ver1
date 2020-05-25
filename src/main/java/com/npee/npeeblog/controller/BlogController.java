package com.npee.npeeblog.controller;

import com.npee.npeeblog.model.entity.*;
import com.npee.npeeblog.model.repository.*;
import com.npee.npeeblog.service.BlogServiceImpl;
import com.npee.npeeblog.service.UserService;
import com.npee.npeeblog.service.UserServiceImpl;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
    private final ReplyJpaRepository replyJpaRepository;
    // private final UserServiceImpl userService;
    private final BlogServiceImpl blogService;

    /**
     * 추가되는 세션 정보 : bloger, blog, categories, posts
     * @param nickname
     * @param session
     * @return MVC View "blog/blog"
     */
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
        Post post = blogService.builder(0L, null, blog, "", "");

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

        return setRedirectUrl(nickname, post.getPostNo());
    }

    @GetMapping("/update-post")
    public String update_post() {
        return "blog/write";
    }

    @GetMapping("/{postNo}")
    public String read(@PathVariable String nickname, @PathVariable Long postNo, HttpSession session) {

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
        
        Optional<List<Reply>> replyList = replyJpaRepository.findAllByReplyFromPost_PostNo(postNo);
        List<Reply> replies;
        if (replyList.isPresent()) {
            replies = replyList.get();
            session.setAttribute("replies", replies);
        } else {
            session.setAttribute("emptyReplyMessage", "작성된 댓글이 없습니다.");
        }

        return "blog/post";
    }

    @PostMapping("/delete-post")
    public String delete_post(@PathVariable String nickname) {
        // TODO: 포스트 삭제 - 수정 페이지에 포함 / 관련 댓글 모두 삭제됨
        return setRedirectUrl();
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
            categoryJpaRepository.save(blogService.builder(blog, categoryName));
        } else {
            categoryJpaRepository.save(blogService.builder(blog, categoryName, categoryDescription));
        }

        return setRedirectUrl(nickname, "settings");
    }

    /**
     * 추가되는 세션 정보 : bloger, blog, categories, posts
     * @param nickname
     * @param session
     * @return MVC View "settings/blog-settings"
     */
    @GetMapping("/settings")
    public String blog_settings(@PathVariable String nickname,
                                HttpSession session,
                                HttpServletRequest request,
                                HttpServletResponse response) {
        // TODO: 블로그 프로필 수정 - view 작업 직전

        // TODO: 중복 코드 리팩토링
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

        return "settings/blog-settings";
    }

    @PostMapping("/settings")
    public String post_settings(@PathVariable String nickname, HttpSession session) {

        return setRedirectUrl(nickname, "settings");
    }

    @PostMapping("/update-category")
    public String update_category(@PathVariable String nickname,
                                  @RequestParam Long updateCategoryNo,
                                  @RequestParam String categoryName,
                                  @RequestParam String categoryDescription,
                                  HttpSession session) {

        Blog blog = (Blog) session.getAttribute("blog");
        categoryJpaRepository.save(blogService.builder(blog, updateCategoryNo, categoryName, categoryDescription));

        return setRedirectUrl(nickname, "settings");
    }

    @PostMapping("/delete-category")
    public String delete_category(@PathVariable String nickname,
                                  @RequestParam Long deleteCategoryNo) {

        Optional<List<Post>> postList = postJpaRepository.findAllByPostFromCategory_CategoryNo(deleteCategoryNo);
        log.debug("postList is Empty?: " + !postList.isPresent());
        if (postList.isPresent()) {
            // TODO: View에서 경고 메시지 출력하도록 변경하기
            log.error("카테고리에 포스트가 존재하면 카테고리를 삭제할 수 없습니다...");
        } else {
            categoryJpaRepository.deleteByCategoryNo(deleteCategoryNo);
        }

        return setRedirectUrl(nickname, "settings");
    }

    @PostMapping("/create-reply")
    public String create_category(@PathVariable String nickname,
                                  @RequestParam Long userNo,
                                  @RequestParam Long postNo,
                                  @RequestParam String newReply) {
        // TODO: 댓글 생성
        replyJpaRepository.save(
            Reply.builder()
                    .reply(newReply)
                    .registerDate(LocalDateTime.now().plusHours(9L))
                    .replyFromPost(postJpaRepository.findByPostNo(postNo).get())
                    .replyFromUser(userJpaRepository.findByUserNo(userNo).get())
                    .build()
        );
        return setRedirectUrl(nickname, postNo);
    }

    @PostMapping("/update-reply")
    public String update_reply(@PathVariable String nickname) {
        // TODO: 댓글 수정 - 권한: 댓글 작성자
        // TODO: 댓글 가리기 - 권한: 블로그 관리자
        return setRedirectUrl(nickname, "settings");
    }

    @PostMapping("/delete-reply")
    public String delete_reply(@PathVariable String nickname) {
        // TODO: 댓글 삭제 - 권한: 댓글 작성자
        return setRedirectUrl(nickname, "settings");
    }

    private static String setRedirectUrl() {
        return "redirect:/";
    }

    private static String setRedirectUrl(String nickname) {
        return setRedirectUrl() + nickname;
    }

    private static String setRedirectUrl(String nickname, String controller) {
        return setRedirectUrl(nickname) + "/" + controller;
    }

    private static String setRedirectUrl(String nickname, Long postNo) {
        return setRedirectUrl(nickname) + "/" + postNo;
    }

}
