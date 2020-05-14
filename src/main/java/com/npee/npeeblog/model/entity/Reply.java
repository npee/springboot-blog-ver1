package com.npee.npeeblog.model.entity;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;

@Builder
@Entity
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "replies")
public class Reply {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long replyNo;

    @Column(nullable = false)
    private String reply;

    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime registerDate;

    @ManyToOne
    @JoinColumn(name = "POST_NO")
    private Post replyFromPost;
}
