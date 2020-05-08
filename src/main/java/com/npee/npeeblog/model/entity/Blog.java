package com.npee.npeeblog.model.entity;

import lombok.*;

import javax.persistence.*;
import java.util.Date;

@Builder
@Entity
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "blogs")
public class Blog {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long blogNo;

    @Column(nullable = false, length = 50)
    private String title;

    @Column
    private String image;

    @Column(nullable = false)
    private Long count;

    @Column(nullable = false)
    private String registerDate;

}
