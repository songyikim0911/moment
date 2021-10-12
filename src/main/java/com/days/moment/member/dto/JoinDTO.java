package com.days.moment.member.dto;

import com.days.moment.member.domain.Member;
import com.days.moment.member.domain.MemberRole;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class JoinDTO {

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



    public Member getDomain(){

        Member member = Member.builder()
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

        return member;


    }


    public MemberRole getRole(String memID){

        MemberRole memberRole = MemberRole.builder()
                .memId(memId)
                .role("ROLE_MEMBER")
                .build();

        return memberRole;

    }


}
