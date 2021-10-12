package com.days.moment.miniboard.mapper;

import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.miniboard.domain.Mini;
import com.days.moment.miniboard.domain.MiniAttach;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MiniMapper {

    void insert(Mini mini);

    List<Mini> getList(PageRequestDTO pageRequestDTO);

    int getCount(PageRequestDTO pageRequestDTO);

    Mini select(Long mbNo);

    int delete(Long mbNo);

    int update(Mini mini);

    int updateReplyCnt(@Param("mbNo") Long mbNo, @Param("num") int num);

    int insertAttach(MiniAttach miniAttach);

    int deleteAttach(Long mbNo);


}
