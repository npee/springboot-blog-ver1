package com.npee.npeeblog.model.entity;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

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

    @OneToMany(mappedBy = "postTable")
    private List<Reply> replies;

    @ManyToOne
    @JoinColumn(name = "CATEGORY_NO")
    private Category categoryTable;
}
