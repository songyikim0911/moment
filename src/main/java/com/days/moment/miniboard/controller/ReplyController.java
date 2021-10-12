package com.days.moment.miniboard.controller;

import com.days.moment.common.dto.PageMaker;
import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.miniboard.dto.ReplyDTO;
import com.days.moment.miniboard.service.ReplyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Log4j2
@RestController
@RequestMapping("/replies")
@RequiredArgsConstructor
public class ReplyController {

    private final ReplyService replyService;

    @PostMapping("")
    public int add(@RequestBody ReplyDTO replyDTO) {

        log.info("===========addReply=============");
        log.info(replyDTO);

        return replyService.addReply(replyDTO);
    }

    @PostMapping("/{originReNo}")
    public int ReComment(@RequestBody ReplyDTO replyDTO) {

        log.info("===========addReComment=============");
        log.info(replyDTO);

        return replyService.addReComment(replyDTO);
    }

    @DeleteMapping("/{mbReNo}")
    public String remove(@PathVariable(name="mbReNo") Long mbReNo) {//@PathVariable >> name의 파라미터를 받아온다.
        //Json으로 받을건지, 파라미터로만 반환 받을것인지 결정
        log.info("----------------------reply remove-----------------------");

        log.info("rno : " + mbReNo);

        replyService.remove(mbReNo);

        return "success";
    }//일관성이 중요함. ajax는 json으로 모두 쓴다, 파라미터 1개 는 그냥 파라미터로 사용한다 등....

    @PutMapping("/{mbReNo}")
    public String modify(@PathVariable(name="mbReNo") Long mbReNo,
                         @RequestBody ReplyDTO replyDTO){ // @RequestBody Json타입 데이터로 변환

        log.info("-------------------reply modify----------------------" + mbReNo);
        log.info(replyDTO);

        replyService.modify(replyDTO);

        return "success";
    }

    @GetMapping(value = "/list/{mbNo}/{page}", produces = "application/json")
    public ResponseEntity<PageResponseDTO> getBoardReplies(@PathVariable(name = "mbNo") Long mbNo,
                                                    @PathVariable(name = "page") int page) {

        PageRequestDTO pageRequestDTO = PageRequestDTO.builder()
                .page(page)
                .size(10)
                .build();

        log.info("=============================");
        log.info(mbNo);
        log.info(pageRequestDTO);
        log.info("=============================");


        return new ResponseEntity<>(replyService.getRepliesWithMbNoPage(mbNo, pageRequestDTO), HttpStatus.OK);
    }
}
