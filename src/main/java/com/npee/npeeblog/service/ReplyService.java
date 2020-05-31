package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.Post;
import com.npee.npeeblog.model.entity.Reply;
import com.npee.npeeblog.model.entity.User;

public interface ReplyService {
    Reply builder(Long replyNo, String reply, String isBlind, Post post, User user);
}
