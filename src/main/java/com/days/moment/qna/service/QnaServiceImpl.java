package com.days.moment.qna.service;

import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.miniboard.domain.Mini;
import com.days.moment.qna.domain.Qna;
import com.days.moment.qna.dto.QnaDTO;
import com.days.moment.qna.mapper.QnaMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class QnaServiceImpl implements QnaService{

    private final QnaMapper qnaMapper;

    @Override
    public Long register(QnaDTO qnaDTO) {

        Qna qna = qnaDTO.getDomain();

        qnaMapper.insert(qna);

        return qna.getQnaId();
    }

    @Override
    public boolean originModify(QnaDTO qnaDTO) {
        Qna qna = qnaDTO.getDomain();

        Long qnaId = qna.getQnaId();


        return qnaMapper.originUpdate(qna) > 0;
    }

    @Override
    public boolean answerModify(QnaDTO qnaDTO) {
        Qna qna = qnaDTO.getDomain();

        Long qnaId = qna.getQnaId();

        return qnaMapper.answerUpdate(qna) > 0;
    }

    @Override
    public PageResponseDTO<QnaDTO> getDTOList(PageRequestDTO pageRequestDTO) {

        List<QnaDTO> dtoList = qnaMapper.getList(pageRequestDTO).stream().map(qna -> qna.getDTO()).collect(Collectors.toList());
        int count = qnaMapper.getCount(pageRequestDTO);

        PageResponseDTO<QnaDTO> pageResponseDTO = PageResponseDTO.<QnaDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();

        return pageResponseDTO;

    }


    @Override
    public QnaDTO read(Long qnaId) {

        Qna qna = qnaMapper.select(qnaId);

        if(qna != null) {
            return qna.getDTO();
        }
        return null;
    }

    @Override
    public boolean remove(Long qnaId) {
        return qnaMapper.delete(qnaId) > 0;
    }
}
