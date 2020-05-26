package com.npee.npeeblog.model.repository;

import com.npee.npeeblog.model.entity.Reply;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface ReplyJpaRepository extends JpaRepository<Reply, Long> {
    Optional<Reply> findByReplyNo(Long replyNo);
    Optional<List<Reply>> findAllByReplyFromPost_PostNo(Long postNo);
}
