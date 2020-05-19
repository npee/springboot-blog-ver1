package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.User;
import com.npee.npeeblog.model.repository.UserJpaRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {

    Date date = new Date();
    SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
    String now = format.format(date);

    @Override
    public User builder(String email, String password, String nickname) {
        return User.builder()
                .email(email)
                .password(password)
                .nickname(nickname)
                .registerDate(LocalDateTime.now().plusHours(9L))
                .build();
    }
}
