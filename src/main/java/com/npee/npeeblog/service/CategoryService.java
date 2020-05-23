package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.entity.Category;

public interface CategoryService {
    Category builder(Blog blog);
    Category builder(Blog blog, String category);
    Category builder(Blog blog, String category, String description);
    Category builder(Blog blog, Long categoryNo, String category, String description);
}
