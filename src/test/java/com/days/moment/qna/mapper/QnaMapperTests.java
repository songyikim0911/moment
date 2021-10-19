package com.days.moment.qna.mapper;


import com.days.moment.common.config.RootConfig;
import com.days.moment.qna.config.QnaRootConfig;
import com.days.moment.qna.domain.Qna;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.stream.IntStream;

@Log4j2
@ExtendWith(SpringExtension.class)
@ContextConfiguration( classes = {QnaRootConfig.class, RootConfig.class})
public class QnaMapperTests {

    @Autowired(required = false)
    QnaMapper qnaMapper;

    @Test
    public void testDummies() {

        IntStream.rangeClosed(0, 9).forEach(i -> {
            Qna qna = Qna.builder()
                    .qnaTitle("문의드립니다." + i + i + i)
                    .qnaContent("문의내용" + i)
                    .qnaWriter("email"+i+"@naver.com")
                    .qnaAnswerEmail("email"+i+"@naver.com")
                    .build();

            qnaMapper.insert(qna);
        });
    }

//    @Test
//    public void testList() {
//
//        PageRequestDTO pageRequestDTO = PageRequestDTO.builder()
//                .type("TC")
//                .keyword("AA")
//                .build();
//
//        qnaMapper.getList(pageRequestDTO).forEach(board -> log.info(board));
//    }
//
//
//    @Test
//    public void testSelect() {
//
//        Board board = qnaMapper.select(120L);
//
//        log.info(board);
//        log.info("--------------------------");
//        board.getAttachList().forEach(boardAttach -> log.info(boardAttach));
//    }
//
//    @Test
//    public void testDelete() {
//        long bno = 110L;
//
//        log.info(qnaMapper.delete(bno));
//    }
//
//    @Test
//    public void testUpdate() {
//        Board board = Board.builder()
//                .bno(113L)
//                .title("수정제목")
//                .content("수정내용")
//                .build();
//
//        log.info(qnaMapper.update(board));
//    }

}

