package com.npee.npeeblog.model.entity;

import lombok.*;

import javax.persistence.*;
import java.util.List;

@Builder
@Entity
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "categories")
public class Category {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long categoryNo;

    @Column(nullable = false, length = 50)
    private String category;

    @Column
    private String description;

    @OneToMany(mappedBy = "postFromCategory")
    private List<Post> posts;

    @ManyToOne
    @JoinColumn(name = "BLOG_NO")
    private Blog categoryFromBlog;
}
