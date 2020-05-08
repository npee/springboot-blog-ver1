package com.npee.npeeblog.model.entity;

import lombok.*;

import javax.persistence.*;

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

    @ManyToOne
    @JoinColumn(name = "BLOG_NO")
    Blog blogTable;

    @Column(nullable = false, length = 50)
    private String category;

    @Column
    private String description;
}
