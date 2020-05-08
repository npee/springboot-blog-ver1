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
@Table(name = "posts")
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long postNo;

    @ManyToOne
    @JoinColumn(name = "BLOG_NO")
    Blog blogTable;

    @ManyToOne
    @JoinColumn(name = "CATEGORY_NO")
    Category categoryTable;

    @Column(nullable = false)
    private String title;

    @Column
    private String body;

    @Column(nullable = false)
    private Long count;

    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime registerDate;

    @LastModifiedDate
    @Column(nullable = false, updatable = true)
    private LocalDateTime modifyDate;
}
