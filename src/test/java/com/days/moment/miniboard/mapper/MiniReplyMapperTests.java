package com.days.moment.miniboard.mapper;


import com.days.moment.common.config.RootConfig;
import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.miniboard.config.MiniRootConfig;
import com.days.moment.miniboard.domain.Reply;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.stream.IntStream;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration( classes = {MiniRootConfig.class, RootConfig.class})
public class MiniReplyMapperTests {


    @Autowired
    ReplyMapper replyMapper;

    @Test
    public void insertDummies() {

        Long[] arr = {173L, 172L, 171L, 170L, 169L};

        IntStream.rangeClosed(1, 9).forEach(i ->{//intStream 특정 숫자 사이의 루프

            long mbNo = arr[(int)((Math.random() * 1000)) % 5];

            Reply reply = Reply.builder()
                    .mbNo(mbNo)
                    .mbReContent("댓글 ....." + i)
                    .mbReWriter("email"+i+"@naver.com")
                    .build();

            replyMapper.insert(reply);
        });
    }

    @Test
    public void testList(){

        Long mbNo = 235L;

        PageRequestDTO pageRequestDTO = PageRequestDTO.builder()
                .build();

        replyMapper.getListWithMini(mbNo, pageRequestDTO).forEach(reply -> log.info(reply));
    }

}
