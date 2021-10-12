package com.days.moment.miniboard.mapper;

import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.miniboard.domain.Reply;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReplyMapper {

    int insert(Reply reply);

    int originUpdate(Reply reply);

    int answerUpdate(Reply reply);

    int delete(Long mbReNo);

    int update(Reply reply);

    List<Reply> getListWithMini(@Param("mbNo") Long mbNo, @Param("pageRequestDTO") PageRequestDTO pageRequestDTO);

    int getCountByMbNo(@Param("mbNo") Long mbNo, PageRequestDTO pageRequestDTO);
}
