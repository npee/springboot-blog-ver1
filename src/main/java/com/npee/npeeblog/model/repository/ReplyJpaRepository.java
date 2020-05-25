package com.npee.npeeblog.model.repository;

import com.npee.npeeblog.model.entity.Reply;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReplyJpaRepository extends JpaRepository<Reply, Long> {
}
