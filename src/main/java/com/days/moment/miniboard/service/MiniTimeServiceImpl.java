package com.days.moment.miniboard.service;

import com.days.moment.miniboard.mapper.MiniTimeMapper;
import com.days.moment.qna.mapper.QnaTimeMapper;
import com.days.moment.qna.service.QnaTimeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

@Log4j2
@Service
@RequiredArgsConstructor
public class MiniTimeServiceImpl implements MiniTimeService {

    private final MiniTimeMapper miniTimeMapper;

    @Override
    public String getNow() {

        log.info("service...............getNow()");
        return miniTimeMapper.getTime4();
    }
}
