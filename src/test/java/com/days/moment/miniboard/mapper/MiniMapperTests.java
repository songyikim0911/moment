package com.days.moment.miniboard.mapper;

import com.days.moment.common.config.RootConfig;
import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.miniboard.config.MiniRootConfig;
import com.days.moment.miniboard.domain.Mini;
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
public class MiniMapperTests {

//    @Autowired(required = false)
//    Mini mini;


    @Autowired(required = false)
    MiniMapper miniMapper;

    @Test
    public void testDummies() {

        IntStream.rangeClosed(0, 9).forEach(i -> {
            Mini mini = Mini.builder()
                    .mbTitle("제목" + i + i + i)
                    .mbContent("내용" + i + i + i)
                    .mbWriter("email"+i+"@naver.com")
                    .build();
            miniMapper.insert(mini);
        });
    }

    @Test
    public void testList() {

        PageRequestDTO pageRequestDTO = PageRequestDTO.builder()
                .type("TC")
                .keyword("AA")
                .build();

        miniMapper.getList(pageRequestDTO).forEach(mini -> log.info(mini));
    }
    }
//
//
//    @Test
//    public void testSelect() {
//
//        Board board = boardMapper.select(120L);
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
//        log.info(boardMapper.delete(bno));
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
//        log.info(boardMapper.update(board));
//    }



