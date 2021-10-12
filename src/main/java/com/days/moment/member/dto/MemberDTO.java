package com.days.moment.member.dto;

import com.days.moment.member.domain.Member;
import com.days.moment.member.domain.MemberRole;
import lombok.*;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.time.LocalDateTime;
import java.util.stream.Collectors;



@Getter
@Setter
public class MemberDTO extends User{
    //extends User
    private String memId;
    private String memPwd;
    private String memNick;
    private LocalDateTime memBirthday;
    private boolean enabled;
    private boolean memEmailCert;
    private String memSex;//null=0,남=1,여=2
    private LocalDateTime lastLogin;
    private LocalDateTime memRegister;
    private boolean accountNonLocked;



    public MemberDTO(Member member){
        super(member.getMemId(),
                member.getMemPwd(),
                member.getRoleList().stream()
                        .map(memberRole ->
                                new SimpleGrantedAuthority(memberRole.getRole())).collect(Collectors.toList()));

        this.memId = member.getMemId();
        this.memPwd = member.getMemPwd();
        this.enabled = member.isEnabled();
        this.memNick = member.getMemNick();
        this.memBirthday = member.getMemBirthday();
        this.memEmailCert = member.isMemEmailCert();
        this.memSex = member.getMemSex();
        this.lastLogin = member.getLastLogin();
        this.memRegister = member.getMemRegister();
        this.accountNonLocked = member.isMemUnblocked();



    }



}
