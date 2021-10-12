package com.days.moment.notice.service;


import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.notice.domain.Notice;
import com.days.moment.notice.dto.NoticeDTO;
import com.days.moment.notice.mapper.NoticeMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {

    private final NoticeMapper noticeMapper;


    @Override
    public Long register(NoticeDTO noticeDTO) {

        Notice notice = noticeDTO.getDomain();

        noticeMapper.insert(notice);

        Long noticeNo = notice.getNoticeNo();

        notice.getAttachList().forEach(attach->{
            attach.setNoticeNo(noticeNo);
            noticeMapper.insertAttach(attach);
        });

        return notice.getNoticeNo();

    }


    @Override
    public PageResponseDTO<NoticeDTO> getDTOList(PageRequestDTO pageRequestDTO) {

        List<NoticeDTO> dtoList = noticeMapper.getList(pageRequestDTO).stream().map(notice -> notice.getDTO()).collect(Collectors.toList());

        int count = noticeMapper.getCount(pageRequestDTO);

        PageResponseDTO<NoticeDTO> pageResponseDTO = PageResponseDTO.<NoticeDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();
        return pageResponseDTO;

    }


    @Override
    public NoticeDTO read(Long noticeNo) {

        Notice notice = noticeMapper.select(noticeNo);

        if(notice!= null){
            return notice.getDTO();
        }
        return null;
    }

    @Override
    public boolean modify(NoticeDTO noticeDTO) {

        noticeMapper.deleteAttach(noticeDTO.getNoticeNo());

        Notice notice = noticeDTO.getDomain();

        Long noticeNo = notice.getNoticeNo();

        notice.getAttachList().forEach(attach ->{
            attach.setNoticeNo(noticeNo);
            noticeMapper.insertAttach(attach);
        });

        return noticeMapper.update(notice) > 0;

    }

    @Override
    public boolean remove(Long noticeNo) {
        return noticeMapper.delete(noticeNo) > 0;
    }
}
