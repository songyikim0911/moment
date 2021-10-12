package com.days.moment.miniboard.service;

import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.miniboard.domain.Reply;
import com.days.moment.miniboard.dto.MiniDTO;
import com.days.moment.miniboard.dto.ReplyDTO;
import com.days.moment.miniboard.dto.ReplyPageDTO;
import com.days.moment.miniboard.mapper.MiniMapper;
import com.days.moment.miniboard.mapper.ReplyMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
@Transactional
public class ReplyServiceImpl implements ReplyService{

    private final ReplyMapper replyMapper;
    private final MiniMapper miniMapper;


    @Override
    public PageResponseDTO<ReplyDTO> getRepliesWithMbNoPage(Long mbNo, PageRequestDTO pageRequestDTO) {

        List<ReplyDTO> dtoList = replyMapper.getListWithMini(mbNo, pageRequestDTO).stream().map(reply -> reply.getDTO()).collect(Collectors.toList());
        int count = replyMapper.getCountByMbNo(mbNo, pageRequestDTO);

        PageResponseDTO<ReplyDTO> pageResponseDTO = PageResponseDTO.<ReplyDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();

        return pageResponseDTO;
    }

    @Override
    public int addReply(ReplyDTO replyDTO) {
        int count = replyMapper.insert(dtoToEntity(replyDTO));
        miniMapper.updateReplyCnt(replyDTO.getMbNo(), 1);
        replyMapper.originUpdate(dtoToEntity(replyDTO));

        return count;
    }

    @Override
    public int addReComment(ReplyDTO replyDTO) {
        int count = replyMapper.insert(dtoToEntity(replyDTO));
        log.info("===============count==============");
        miniMapper.updateReplyCnt(replyDTO.getMbNo(), 1);
        log.info("===============updatecount==============");
        replyMapper.answerUpdate(dtoToEntity(replyDTO));
        log.info("===============answerUpdate==============");

        return count;
    }

//    @Override
//    public boolean originModify(ReplyDTO replyDTO) {
//
//        replyMapper.originUpdate(dtoToEntity(replyDTO));
//
//        return replyMapper.originUpdate(dtoToEntity(replyDTO)) > 0;
//    }
//
//    @Override
//    public boolean answerModify(ReplyDTO replyDTO) {
//
//        replyMapper.answerUpdate(dtoToEntity(replyDTO));
//
//        return replyMapper.answerUpdate(dtoToEntity(replyDTO)) > 0;
//    }

    @Override
    public int remove(Long mbReNo) {
        return replyMapper.delete(mbReNo);
    }

    @Override
    public int modify(ReplyDTO replyDTO) {
        return replyMapper.update(dtoToEntity(replyDTO));
    }
}
