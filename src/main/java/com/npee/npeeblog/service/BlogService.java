package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.entity.User;

public interface BlogService {
    Blog builder(User user, String nickname);
}
