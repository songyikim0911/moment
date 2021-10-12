package com.days.moment.notice.domain;

import lombok.*;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class NoticeAttach {

    private String uuid;
    private Long noticeNo;
    private String fileName;
    private String path;
    private boolean image;


    public void setNoticeNo(Long noticeNo){
        this.noticeNo = noticeNo;
    }

}
