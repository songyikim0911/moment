package com.days.moment.notice.domain;

import com.days.moment.notice.dto.NoticeDTO;
import com.days.moment.common.dto.UploadResponseDTO;
import lombok.*;


import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class Notice {

    private Long noticeNo;
    private String noticeTitle;
    private String noticeContent;
    private LocalDateTime noticeRegDate;



    @Builder.Default
    private List<NoticeAttach> attachList = new ArrayList<>();

    public NoticeDTO getDTO(){
        NoticeDTO noticeDTO = NoticeDTO.builder()
                .noticeNo(noticeNo)
                .noticeTitle(noticeTitle)
                .noticeContent(noticeContent)
                .noticeRegDate(noticeRegDate)
                .build();

        List<UploadResponseDTO> uploadResponseDTOList = attachList.stream().map(attach ->{
            UploadResponseDTO uploadResponseDTO = UploadResponseDTO.builder()
                    .uuid(attach.getUuid())
                    .fileName(attach.getFileName())
                    .uploadPath(attach.getPath())
                    .image(attach.isImage())
                    .build();
            return uploadResponseDTO;
        }).collect(Collectors.toList());

        noticeDTO.setFiles(uploadResponseDTOList);


        return noticeDTO;
    }

    public void setNoticeNo(Long noticeNo){this.noticeNo=noticeNo;}

    public void addAttach(NoticeAttach attach){attachList.add(attach);}


}
