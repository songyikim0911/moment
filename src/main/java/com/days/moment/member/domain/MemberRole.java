package com.days.moment.member.domain;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MemberRole {

    private String memId;
    private String role;


}
