package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.entity.Category;
import com.npee.npeeblog.model.entity.Post;

public interface PostService {
    Post builder(Long postNo, Category category, Blog blog, String postTitle, String postBody);
}
