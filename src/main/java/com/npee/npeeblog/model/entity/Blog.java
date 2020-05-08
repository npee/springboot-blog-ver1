package com.npee.npeeblog.model.entity;

import lombok.*;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
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

    @OneToOne
    @JoinColumn(name = "USER_NO")
    private User userTable;

    @Column(nullable = false, length = 50)
    private String title;

    @Column
    private String image;

    @Column(nullable = false)
    private Long count;

    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime registerDate;

}
