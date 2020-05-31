package com.npee.npeeblog.controller;

import com.npee.npeeblog.model.entity.*;
import com.npee.npeeblog.model.repository.*;
import com.npee.npeeblog.service.BlogServiceImpl;
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
     * @param nickname nickname
     * @param session session
     * @return MVC View "settings/blog-settings"
     */
    @GetMapping("/settings")
    public String blog_settings(@PathVariable String nickname,
                                HttpSession session) {
        // TODO: 블로그 프로필 수정 - view 작업 직전

        blogService.initSession(nickname, session);

        return "settings/blog-settings";
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

    @PostMapping("/{postNo}/create-reply")
    public String create_category(@PathVariable String nickname,
                                  @RequestParam Long userNo,
                                  @PathVariable Long postNo,
                                  @RequestParam String newReply) {
        // TODO: 댓글 생성...ReplyService interface로 옮기기
        replyJpaRepository.save(
            Reply.builder()
                    .reply(newReply)
                    .isBlind("false")
                    .registerDate(LocalDateTime.now().plusHours(9L))
                    .modifyDate(LocalDateTime.now().plusHours(9L))
                    .replyFromPost(postJpaRepository.findByPostNo(postNo).get())
                    .replyFromUser(userJpaRepository.findByUserNo(userNo).get())
                    .build()
        );
        return setRedirectUrl(nickname, postNo);
    }

    @PostMapping("/{postNo}/update-reply")
    public String update_reply(@PathVariable String nickname,
                               @RequestParam Long userNo,
                               @PathVariable Long postNo,
                               @RequestParam Long replyNo,
                               @RequestParam(required = false) String isBlind,
                               @RequestParam String updatedReply) {

        log.debug("isBlind: " + isBlind);
        log.debug("userNo: " + userNo);
        log.debug("postNo: " + postNo);
        log.debug("updatedReply: " + updatedReply);
        Reply reply = replyJpaRepository.findByReplyNo(replyNo).get();
        Post post = postJpaRepository.findByPostNo(postNo).get();

        User replier = userJpaRepository.findByUserNo(reply.getReplyFromUser().getUserNo()).get();
        User user = userJpaRepository.findByUserNo(userNo).get();
        User bloger = userJpaRepository.findByNickname(nickname).get();

        LocalDateTime modifyDate = reply.getModifyDate();

        // TODO: Guest가 자기 댓글 수정 시 수정 안되는 문제 해결

        //  권한 확인(현재 사용자 : 댓글 작성자)
        //      일반 수정이면(isBlind가 null 일때)
        //           일반 수정
        //      일반 수정이 아니면(isBlind가 null이 아닐 때)
        //          댓글 작성자가 블로그 주인이면(replier == bloger)
        //              isBlind가 true
        //              isBlind가 false

        // 댓글 수정 - 권한: 댓글 작성자
        if (user == replier && isBlind == null) {
            replyJpaRepository.save(
                    Reply.builder()
                            .replyNo(replyNo)
                            .reply(updatedReply)
                            .isBlind("false")
                            .modifyDate(LocalDateTime.now().plusHours(9L))
                            .replyFromPost(post)
                            .replyFromUser(replier)
                            .build()
            );
        } else if (user == bloger && isBlind != null){
            // 댓글 가리기 - 권한: 블로그 관리자
            if (isBlind.equals("true")) {
                replyJpaRepository.save(
                        Reply.builder()
                                .replyNo(replyNo)
                                .reply(updatedReply)
                                .isBlind("true")
                                .modifyDate(modifyDate)
                                .replyFromPost(post)
                                .replyFromUser(replier)
                                .build()
                );
            } else {
                replyJpaRepository.save(
                        Reply.builder()
                                .replyNo(replyNo)
                                .reply(updatedReply)
                                .isBlind("false)")
                                .modifyDate(modifyDate)
                                .replyFromPost(post)
                                .replyFromUser(replier)
                                .build()
                );
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
