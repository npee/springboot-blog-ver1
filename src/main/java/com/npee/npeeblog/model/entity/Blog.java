package com.npee.npeeblog.model.entity;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.util.Date;
import java.util.List;

@Builder
@Entity
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "blogs")
public class Blog {

    @Id
    private Long blogNo;

    @Column(nullable = false, length = 50)
    private String title;

    @Column
    private String image;

    @Column(nullable = false)
    private Long count;

    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime registerDate;

    @OneToOne
    @JoinColumn(name = "USER_NO")
    private User blogFromUser;

    @OneToMany(mappedBy = "categoryFromBlog")
    private List<Category> categories;

    @OneToMany(mappedBy = "postFromBlog")
    private List<Post> posts;

}
