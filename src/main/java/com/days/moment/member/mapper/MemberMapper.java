package com.days.moment.member.mapper;

import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.member.domain.Member;
import com.days.moment.member.domain.MemberRole;

import java.util.List;

public interface MemberMapper {

    Member findByMemId(String memId);

    void insert(Member member);

    void insertRole(MemberRole memberRole);

    List<Member> getList(PageRequestDTO pageRequestDTO);

    int getCount(PageRequestDTO pageRequestDTO);

    void blockUser(String memId);

    void unBlockUser(String memId);

}
