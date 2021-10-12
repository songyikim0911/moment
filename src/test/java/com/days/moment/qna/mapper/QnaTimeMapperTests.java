package com.days.moment.qna.mapper;

import com.days.moment.common.config.RootConfig;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration( classes = {RootConfig.class})
public class QnaTimeMapperTests {

    @Autowired
    QnaTimeMapper qnaTimeMapper;

    @Test
    public void testGetTime123() {
        log.info("-------------------");
        log.info("-------------------");
        log.info(qnaTimeMapper.getTime());
        log.info(qnaTimeMapper.getTime3());
        log.info("-------------------");
        log.info("-------------------");
    }
}
