package com.days.moment.qna.mapper;

import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.miniboard.domain.Mini;
import com.days.moment.qna.domain.Qna;

import java.util.List;

public interface QnaMapper {

    void insert(Qna qna);

    int originUpdate(Qna qna);

    int answerUpdate(Qna qna);

    List<Qna> getList(PageRequestDTO pageRequestDTO);

    int getCount(PageRequestDTO pageRequestDTO);

    Qna select(Long qnaId);

    int delete(Long qnaId);
}
