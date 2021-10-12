package com.days.moment.member.service;

import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.member.domain.Member;
import com.days.moment.member.domain.MemberRole;
import com.days.moment.member.dto.JoinDTO;
import com.days.moment.member.dto.MemberDTO;

import com.days.moment.member.mapper.MemberMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Log4j2
@RequiredArgsConstructor
@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final MemberMapper memberMapper;

    public void blockUser(String memId){

                memberMapper.blockUser(memId);


    }

    public void unBlockUser(String memId){


            memberMapper.unBlockUser(memId);

    }

    public PageResponseDTO<JoinDTO> getDTOList(PageRequestDTO pageRequestDTO){

        List<JoinDTO> dtoList = memberMapper.getList(pageRequestDTO).stream().map(member->member.getDTO()).collect(Collectors.toList());

        int count = memberMapper.getCount(pageRequestDTO);

        PageResponseDTO<JoinDTO> pageResponseDTO = PageResponseDTO.<JoinDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();

        return pageResponseDTO;
    }

    public String register(JoinDTO joinDTO){
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        joinDTO.setMemPwd(passwordEncoder.encode(joinDTO.getMemPwd()));

        String memNick = joinDTO.getMemNick();


        if(memNick == null || memNick.trim().length() == 0){
            String memId = joinDTO.getMemId();
            String newNick = memId.split("@")[0];
            joinDTO.setMemNick(newNick);
        }

        Member member = joinDTO.getDomain();

        log.info("---- CustomUserDetailsService register insert(member)");
        log.info("---- CustomUserDetailsService register insert(member)");
        memberMapper.insert(member);
        String memId = member.getMemId();
        log.info(member);
        MemberRole memberRole = joinDTO.getRole(memId);
        log.info("----CustomUserDetailsService register  insert(memberRole)");
        log.info("----CustomUserDetailsService register insert(memberRole)");
        memberMapper.insertRole(memberRole);
        log.info(memberRole);
        return member.getMemId();
    }


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        log.warn("CustomUserDetailsService----------------------------------");
        log.warn("CustomUserDetailsService----------------------------------");
        log.warn(username);
        log.warn(memberMapper);
        log.warn("CustomUserDetailsService----------------------------------");
        log.warn("CustomUserDetailsService----------------------------------");
        log.warn("CustomUserDetailsService----------------------------------");

        Member member = memberMapper.findByMemId(username);

        log.warn(member);

        if(member == null){
            throw new UsernameNotFoundException("NOT EXIST");
        }


        User result = new MemberDTO(member);

//        String[] authorities = member.getRoleList().stream().map(memberRole -> memberRole.getRole()).toArray(String[]::new);

//        User result = (User) User.builder()
//                .username(username)
//                .password(member.getMpw())
//                .accountExpired(false)
//                .accountLocked(false)
//                .authorities(authorities)
//                .build();

        return result;
    }





}
