package com.days.moment.miniboard.domain;

import com.days.moment.miniboard.dto.ReplyDTO;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Reply {

    private Long mbReNo;
    private Long mbNo;
    private String mbReWriter;
    private String mbReContent;
    private LocalDateTime mbReRegDate;
    private LocalDateTime mbReModDate;
    private Long originReNo;
    private Long reDepth;

    public ReplyDTO getDTO() {
        ReplyDTO replyDTO = ReplyDTO.builder()
                .mbNo(mbNo)
                .mbReNo(mbReNo)
                .mbReWriter(mbReWriter)
                .mbReContent(mbReContent)
                .mbReRegDate(mbReRegDate)
                .mbReModDate(mbReModDate)
                .originReNo(originReNo)
                .reDepth(reDepth)
                .build();

        return replyDTO;
    }
}
