package com.days.moment.notice.mapper;


import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.notice.domain.Notice;
import com.days.moment.notice.domain.NoticeAttach;
import com.days.moment.notice.dto.NoticeDTO;

import java.util.List;

public interface NoticeMapper {

    void insert(Notice notice);

    List<Notice> getList(PageRequestDTO pageRequestDTO);

    int getCount(PageRequestDTO pageRequestDTO);

    Notice select(Long noticeNo);

    int insertAttach(NoticeAttach attach);

    int update(Notice notice);

    int deleteAttach(Long noticeNo);

    int delete(Long noticeNo);


}
