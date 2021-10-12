package com.days.moment.qna.service;

import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.miniboard.dto.MiniDTO;
import com.days.moment.qna.dto.QnaDTO;
import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface QnaService {

    Long register (QnaDTO qnaDTO);

    boolean originModify(QnaDTO qnaDTO);

    boolean answerModify(QnaDTO qnaDTO);

    PageResponseDTO<QnaDTO> getDTOList(PageRequestDTO pageRequestDTO);

    QnaDTO read(Long qnaId);

    boolean remove(Long qnaId);
}
