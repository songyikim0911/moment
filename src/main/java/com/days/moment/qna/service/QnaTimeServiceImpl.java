package com.days.moment.qna.service;

import com.days.moment.qna.mapper.QnaTimeMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Log4j2
@Service
@RequiredArgsConstructor
public class QnaTimeServiceImpl implements QnaTimeService{

    private final QnaTimeMapper qnaTimeMapper;

    @Override
    public String getNow() {

        log.info("service...............getNow()");
        return qnaTimeMapper.getTime3();
    }
}
