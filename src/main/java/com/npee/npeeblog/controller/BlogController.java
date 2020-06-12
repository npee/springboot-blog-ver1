package com.npee.npeeblog.controller;

import com.npee.npeeblog.model.entity.*;
import com.npee.npeeblog.model.repository.*;
import com.npee.npeeblog.service.BlogServiceImpl;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
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
    private final BlogServiceImpl blogService;

    /**
     * 추가되는 세션 정보 : bloger, blog, categories, posts
     * @param nickname nickname
     * @param session session
     * @return MVC View "blog/blog"
     */
    @GetMapping
    public String blogMain(@PathVariable String nickname, HttpSession session) {
        // PathVariable에 해당하는 nickname을 가진 User의 블로그 정보로
        // 세션의 내용을 모두 교체한 후 페이지를 불러온다
        blogService.initSession(nickname, session);


        log.debug("블로그 페이지");
        return "blog/blog";
    }

    @GetMapping("/write")
    public String write_page(@PathVariable String nickname, HttpSession session) {
        session.removeAttribute("post");

        blogService.initSession(nickname, session);

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

        Optional<Blog> optBlog = blogJpaRepository.findByBlogFromUser_Nickname(nickname);
        Optional<Category> optCategory = categoryJpaRepository.findById(categoryNo);
        Blog blog = new Blog();
        Category category = new Category();
        // Blog blog = (Blog) session.getAttribute("blog"); // 세션에서 정보 얻어서 DB에 삽입한 경우 blog_no에 null이 들어갔다
        if (optBlog.isPresent()) {
            blog = optBlog.get();
        }
        if (optCategory.isPresent()) {
            category = optCategory.get();
        }

        // 새 포스트 작성으로 접근 시 postNo는 null이므로 Create 쿼리로 매핑된다
        Post newPost = postJpaRepository.save(blogService.builder(postNo, category, blog, postTitle, postBody));
        session.setAttribute("newPost", newPost);

        return setRedirectUrl(nickname, newPost.getPostNo());
    }

    @GetMapping("/update-post")
    public String update_post(@PathVariable String nickname, HttpSession session) {
        blogService.initSession(nickname, session);
        return "blog/write";
    }

    @GetMapping("/{postNo}")
    public String read(@PathVariable String nickname,
                       @PathVariable Long postNo,
                       HttpSession session) {

        session.removeAttribute("post");
        session.removeAttribute("replies");

        blogService.initSession(nickname, session);

        Optional<Post> optPost = postJpaRepository.findByPostNo(postNo);
        Optional<List<Reply>> optReplyList = replyJpaRepository.findAllByReplyFromPost_PostNo(postNo);

        List<Reply> replies;
        if (optPost.isPresent()) {
            Post post = optPost.get();

            if (optReplyList.isPresent()) {
                replies = optReplyList.get();
                session.setAttribute("replies", replies);
            } else {
                session.setAttribute("emptyReplyMessage", "작성된 댓글이 없습니다.");
            }

            // TODO: 조회수 조건 재설정하기
            Long count = post.getCount();
            post.setCount(++count);
            postJpaRepository.save(post);

            session.setAttribute("post", post);
        }

        return "blog/post";
    }

    @GetMapping("/delete-post")
    public String delete_post_page(@PathVariable String nickname,
                                   @RequestParam Long postNo,
                                   HttpSession session) {

        User AuthUser = (User) session.getAttribute("user");

        Optional<User> optUser = userJpaRepository.findByNickname(nickname);
        Optional<Post> optPost = postJpaRepository.findByPostNo(postNo);

        User user;
        Post post;
        List<Post> postList;

        if (optUser.isPresent() && optPost.isPresent()) {
            user = optUser.get();
            post = optPost.get();
            Optional<List<Post>> optPostList = postJpaRepository.findAllByPostFromBlog_BlogFromUser_UserNo(user.getUserNo());
            if (optPostList.isPresent()) {
                // 현 사용자가 소유한 포스트에 지울 포스트가 포함되어있는지 검사한다
                // 잘못된 접근(Url 요청) 방어코드
                postList = optPostList.get();
                if (AuthUser.getUserNo().equals(user.getUserNo()) && postList.contains(post)) {
                    log.debug("삭제를 진행합니다. 댓글도 함께 삭제됩니다.");
                    replyJpaRepository.deleteAllByReplyFromPost_PostNo(post.getPostNo());
                    postJpaRepository.delete(post); // 단독으로 삭제 불가(연관 테이블의 데이터 존재)
                } else {
                    log.debug("해당 포스트에 대한 권한이 없습니다");
                }
            }
        }

        return setRedirectUrl(nickname);
    }

    @GetMapping("/categories")
    public String getCategories(@PathVariable String nickname,
                                HttpSession session) {

        blogService.initSession(nickname, session);

        return "settings/list-category";
    }

    @PostMapping("/category")
    public String createCategory(@PathVariable String nickname,
                                 @RequestParam String categoryName,
                                 @RequestParam String categoryDescription) {

        Blog blog;
        Optional<Blog> optBlog = blogJpaRepository.findByBlogFromUser_Nickname(nickname);
        if (optBlog.isPresent()) {
            blog = optBlog.get();
            if (categoryDescription == null || categoryDescription.equals("")) {
                categoryJpaRepository.save(blogService.builder(blog, categoryName));
            } else {
                categoryJpaRepository.save(blogService.builder(blog, categoryName, categoryDescription));
            }
        }

        return setRedirectUrl(nickname, "settings");
    }

    /**
     * 추가되는 세션 정보 : bloger, blog, categories, posts
     * @param nickname nickname
     * @param session session
     * @return MVC View "settings/blog-settings"
     */
    @GetMapping("/settings")
    public String blog_settings_page(@PathVariable String nickname,
                                     HttpSession session) {

        blogService.initSession(nickname, session);

        User user = (User) session.getAttribute("user");

        if (user == null || !nickname.equals(user.getNickname())) {
            log.debug("잘못된 접근입니다.");
            return "redirect:/";
        }
        // log.debug("user: " + user.getNickname());

        List<String> colorList = new ArrayList<>();
        colorList.add("white");
        colorList.add("yellow");
        colorList.add("green");
        colorList.add("red");
        session.setAttribute("colorList", colorList);

        return "settings/settings";
    }

    @GetMapping("/blog-settings")
    public String getSettings(@PathVariable String nickname,
                              HttpSession session) {
        blogService.initSession(nickname, session);

        return "settings/blog-settings";

    }

    @PostMapping("/blog-settings")
    public String blog_settings(@PathVariable String nickname,
                                @RequestParam String title,
                                @RequestParam String image,
                                HttpSession session) {

        // TODO: 블로그 프로필 수정 - view 작업 직전
        blogService.initSession(nickname, session);

        log.debug("title: " + title);
        log.debug("image: " + image);

        User user = (User) session.getAttribute("user");
        Blog blog;
        log.debug("user: " + nickname);
        Optional<Blog> optBlog = blogJpaRepository.findByBlogFromUser_Nickname(nickname);

        if (optBlog.isPresent()) {
            blog = optBlog.get();
            if (blog.getBlogFromUser().getUserNo().equals(user.getUserNo())) {
                blogJpaRepository.save(blogService.builder(blog.getBlogNo(), user, blog.getCount(), title, image));
            } else {
                log.debug("블로그 수정 권한이 없습니다.");
            }
        }

        return setRedirectUrl(nickname, "settings");
    }

    @PostMapping("/update-category")
    public String update_category(@PathVariable String nickname,
                                  @RequestParam Long updateCategoryNo,
                                  @RequestParam String categoryName,
                                  @RequestParam String categoryDescription) {

        Blog blog;
        Optional<Blog> optBlog = blogJpaRepository.findByBlogFromUser_Nickname(nickname);

        if (optBlog.isPresent()) {
            blog = optBlog.get();
            categoryJpaRepository.save(blogService.builder(blog, updateCategoryNo, categoryName, categoryDescription));
        }

        return setRedirectUrl(nickname, "settings");
    }

    @PostMapping("/delete-category")
    public String delete_category(@PathVariable String nickname,
                                  @RequestParam Long deleteCategoryNo) {

        Optional<List<Post>> optPostList = postJpaRepository.findAllByPostFromCategory_CategoryNo(deleteCategoryNo);
        log.debug("postList is Empty?: " + !optPostList.isPresent());
        if (optPostList.isPresent()) {
            // TODO: View에서 경고 메시지 출력하도록 변경하기
            log.error("카테고리에 포스트가 존재하면 카테고리를 삭제할 수 없습니다...");
        } else {
            categoryJpaRepository.deleteByCategoryNo(deleteCategoryNo);
        }

        return setRedirectUrl(nickname, "settings");
    }

    @GetMapping("/{postNo}/reply")
    public String reply(@PathVariable String nickname,
                        @PathVariable Long postNo,
                        HttpSession session) {

        session.removeAttribute("replies");
        List<Reply> replies;
        blogService.initSession(nickname, session);

        Optional<User> optBloger = userJpaRepository.findByNickname(nickname);
        Optional<List<Reply>> optReplyList = replyJpaRepository.findAllByReplyFromPost_PostNo(postNo);
        if (optBloger.isPresent()) {
            session.setAttribute("bloger", optBloger.get());
            if (optReplyList.isPresent()) {
                replies = optReplyList.get();
                session.setAttribute("replies", replies);
            } else {
                session.setAttribute("emptyReplyMessage", "작성된 댓글이 없습니다.");
            }
        }

        return "blog/list-reply";
    }

    @PostMapping("/{postNo}/create-reply")
    public String create_reply(@PathVariable String nickname,
                                  @RequestParam Long userNo,
                                  @PathVariable Long postNo,
                                  @RequestParam String newReply) {

        Optional<Post> optPost = postJpaRepository.findByPostNo(postNo);
        Optional<User> optUser = userJpaRepository.findByUserNo(userNo);

        Post post = new Post();
        User user = new User();

        if (optPost.isPresent()) {
            post = optPost.get();
        }
        if (optUser.isPresent()) {
            user = optUser.get();
        }

        replyJpaRepository.save(blogService.builder(null, newReply, "false", post, user));

        return setRedirectUrl(nickname, postNo);
    }

    @PostMapping("/{postNo}/update-reply")
    public String update_reply(@PathVariable String nickname,
                               @RequestParam Long userNo,
                               @PathVariable Long postNo,
                               @RequestParam Long replyNo,
                               @RequestParam(required = false) String isBlind,
                               @RequestParam(required = false) String updatedReply) {

        Reply reply = new Reply();
        Post post = new Post();

        User user = new User();
        User replier = new User();
        User bloger = new User();

        Optional<Reply> optReply = replyJpaRepository.findByReplyNo(replyNo);
        Optional<Post> optPost = postJpaRepository.findByPostNo(postNo);

        if (optReply.isPresent() && optPost.isPresent()) {
            reply = optReply.get();
            post = optPost.get();

            Optional<User> optUser = userJpaRepository.findByUserNo(userNo);
            Optional<User> optReplier = userJpaRepository.findByUserNo(reply.getReplyFromUser().getUserNo());
            Optional<User> optBloger = userJpaRepository.findByNickname(nickname);

            if (optUser.isPresent() && optReplier.isPresent() && optBloger.isPresent()) {
                user = optUser.get();
                replier = optReplier.get();
                bloger = optBloger.get();
            }
        }

        String blind = reply.getIsBlind();

        if (user == replier) {
            if (blind.equals("true")) {
                // TODO: View에서 경고 메시지 출력하도록 변경하기
                log.error("Blind 처리된 댓글은 수정이 불가능합니다.");
            } else if (isBlind == null || blind.equals("false")) {
                replyJpaRepository.save(blogService.builder(replyNo, updatedReply, "false", post, user));
            }
        } else {
            if (user == bloger) {

                if ("true".equals(isBlind)) {
                    replyJpaRepository.save(blogService.builder(replyNo, reply.getReply(), "true", post, replier));
                } else {
                    replyJpaRepository.save(blogService.builder(replyNo, reply.getReply(), "false", post, replier));
                }
            }
        }

        return setRedirectUrl(nickname, postNo);
    }

    @PostMapping("/{postNo}/delete-reply")
    public String delete_reply(@PathVariable String nickname,
                               @RequestParam Long userNo,
                               @PathVariable Long postNo,
                               @RequestParam Long replyNo) {

        // 댓글 삭제 - 권한: 댓글 작성자
        Optional<Reply> reply = replyJpaRepository.findByReplyNo(replyNo);
        if (reply.isPresent() && reply.get().getReplyFromUser().getUserNo().equals(userNo)) {
            replyJpaRepository.delete(reply.get());
        } else {
            log.error("댓글 삭제 실패!");
        }

        return setRedirectUrl(nickname, postNo);
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
