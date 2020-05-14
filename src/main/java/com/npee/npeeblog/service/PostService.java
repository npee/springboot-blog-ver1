package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.Category;
import com.npee.npeeblog.model.entity.Post;

public interface PostService {
    Post builder(Category category, String postTitle, String postBody);
}
