package com.days.moment.miniboard.service;

import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.miniboard.domain.Reply;
import com.days.moment.miniboard.dto.ReplyDTO;
import com.days.moment.miniboard.dto.ReplyPageDTO;
import com.days.moment.qna.dto.QnaDTO;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


public interface ReplyService {


    PageResponseDTO<ReplyDTO> getRepliesWithMbNoPage(Long mbNo, PageRequestDTO pageRequestDTO);

    int addReply(ReplyDTO replyDTO);

    int addReComment(ReplyDTO replyDTO);

    int remove(Long mbReNo);

    int modify(ReplyDTO replyDTO);

    default Reply dtoToEntity(ReplyDTO replyDTO) {
        Reply reply = Reply.builder()
                .mbReNo(replyDTO.getMbReNo())
                .mbNo(replyDTO.getMbNo())
                .mbReContent(replyDTO.getMbReContent())
                .mbReWriter(replyDTO.getMbReWriter())
                .mbReRegDate(replyDTO.getMbReRegDate())
                .mbReModDate(replyDTO.getMbReModDate())
                .originReNo(replyDTO.getOriginReNo())
                .reDepth(replyDTO.getReDepth())
                .build();

        return reply;
    }

    default ReplyDTO entityToDTO(Reply reply) {
        ReplyDTO replyDTO = ReplyDTO.builder()
                .mbReNo(reply.getMbReNo())
                .mbNo(reply.getMbNo())
                .mbReContent(reply.getMbReContent())
                .mbReWriter(reply.getMbReWriter())
                .mbReRegDate(reply.getMbReRegDate())
                .mbReModDate(reply.getMbReModDate())
                .originReNo(reply.getOriginReNo())
                .reDepth(reply.getReDepth())
                .build();

        return replyDTO;
    }
}
