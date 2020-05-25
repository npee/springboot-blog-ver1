package com.npee.npeeblog.model.repository;

import com.npee.npeeblog.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserJpaRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
    Optional<User> findByUserNo(Long userNo);
    Optional<User> findByNickname(String nickname);
    Optional<User> findByEmailAndPassword(String email, String password);
}
