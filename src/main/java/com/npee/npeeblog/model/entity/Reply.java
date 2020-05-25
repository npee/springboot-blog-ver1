package com.npee.npeeblog.model.entity;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

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

    @LastModifiedDate
    @Column(nullable = false)
    private LocalDateTime modifyDate;

    @ManyToOne
    @JoinColumn(name = "POST_NO")
    private Post replyFromPost;

    @ManyToOne
    @JoinColumn(name = "USER_NO")
    private User replyFromUser;

}
