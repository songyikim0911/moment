package com.days.moment.notice.dto;

import com.days.moment.common.dto.UploadResponseDTO;
import com.days.moment.notice.domain.Notice;
import com.days.moment.notice.domain.NoticeAttach;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class NoticeDTO {


    private Long noticeNo;
    private String noticeTitle;
    private String noticeContent;
    private LocalDateTime noticeRegDate;


    @Builder.Default
    private List<UploadResponseDTO> files = new ArrayList<>();

    public Notice getDomain(){

        Notice notice = Notice.builder()
                .noticeNo(noticeNo)
                .noticeTitle(noticeTitle)
                .noticeContent(noticeContent)
                .noticeRegDate(noticeRegDate)
                .build();

        files.forEach(uploadResponseDTO -> {
            NoticeAttach attach = NoticeAttach.builder()
                    .fileName(uploadResponseDTO.getFileName())
                    .uuid(uploadResponseDTO.getUuid())
                    .image(uploadResponseDTO.isImage())
                    .path(uploadResponseDTO.getUploadPath())
                    .build();

            notice.addAttach(attach);
        });


        return notice;

    }
}
