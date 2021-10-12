package com.days.moment.notice.mapper;

import com.days.moment.common.config.RootConfig;
import com.days.moment.notice.config.NoticeRootConfig;
import com.days.moment.notice.domain.Notice;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.stream.IntStream;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration(classes = {NoticeRootConfig.class, RootConfig.class})
public class NoticeMapperTests {

    @Autowired
    NoticeMapper noticeMapper;

    @Test
    public void testDummies(){
        IntStream.rangeClosed(1,100).forEach(i->{
            Notice notice =Notice.builder()
                    .noticeTitle("title"+i)
                    .noticeContent("content"+i)
                    .build();
            noticeMapper.insert(notice);
        });
    }



}
