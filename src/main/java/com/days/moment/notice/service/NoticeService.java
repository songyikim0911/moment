package com.days.moment.notice.service;


import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.notice.domain.Notice;
import com.days.moment.notice.dto.NoticeDTO;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
public interface NoticeService {


    Long register(NoticeDTO noticeDTO);

    PageResponseDTO<NoticeDTO> getDTOList(PageRequestDTO pageRequestDTO);

    NoticeDTO read(Long noticeNo);

    boolean modify(NoticeDTO noticeDTO);

    boolean remove(Long noticeNo);

}
