package com.days.moment.member.domain;

import com.days.moment.member.dto.JoinDTO;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Member {
    private String memId;
    private String memPwd;
    private String memNick;
    private LocalDateTime memBirthday;
    private boolean enabled;
    private boolean memEmailCert;
    private String memSex;//null=0,남=1,여=2
    private LocalDateTime lastLogin;
    private LocalDateTime memRegister;
    private boolean memUnblocked;

    private List<MemberRole> roleList;

    public JoinDTO getDTO(){

        JoinDTO joinDTO = JoinDTO.builder()
                .memId(memId)
                .memPwd(memPwd)
                .enabled(enabled)
                .memNick(memNick)
                .memBirthday(memBirthday)
                .memEmailCert(memEmailCert)
                .memSex(memSex)
                .lastLogin(lastLogin)
                .memRegister(memRegister)
                .memUnblocked(memUnblocked)
                .build();

        return joinDTO;
    }


}
