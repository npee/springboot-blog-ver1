package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.entity.User;

import javax.servlet.http.HttpSession;

public interface BlogService {
    void initSession(String nickname, HttpSession session);
    Blog builder(User user, String nickname);
    Blog builder(Long blogNo, User user, Long count, String title, String image);
}
