package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.User;

public interface UserService {
    User builder(String email, String password, String nickname);
}
