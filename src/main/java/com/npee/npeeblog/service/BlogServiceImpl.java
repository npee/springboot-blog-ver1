package com.npee.npeeblog.service;

import com.npee.npeeblog.model.entity.Blog;
import com.npee.npeeblog.model.entity.User;
import com.npee.npeeblog.model.repository.BlogJpaRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Date;

@Service
@RequiredArgsConstructor
@Slf4j
public class BlogServiceImpl implements BlogService {

    private final BlogJpaRepository blogJpaRepository;

//    Date date = new Date();
//    SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
//    String now = format.format(date);

    @Override
    public Blog builder(User user, String nickname) {
        return blogJpaRepository.save(Blog.builder()
                .userTable(user)
                .title(nickname + "의 블로그")
                .image("default url")
                .count(0L)
                .registerDate(LocalDateTime.now().plusHours(9L))
                .build());
    }
}
