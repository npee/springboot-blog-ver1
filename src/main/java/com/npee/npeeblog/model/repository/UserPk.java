package com.npee.npeeblog.model.repository;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Embeddable
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserPk implements Serializable {

    /**
     * 미사용 클래스. @Embeddable이 적용된 PK는 자동생성 되지 않는다,.
     */
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false, unique = true)
    private Long userNo;

    @Column(nullable = false, unique = true)
    private String nickname;

}
