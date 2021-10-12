package com.days.moment.qna.dto;


import com.days.moment.qna.domain.Qna;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class QnaDTO {

    private long qnaId;
    private String qnaTitle;
    private String qnaContent;
    private String qnaWriter;
    private String qnaAnswerEmail;
    private LocalDateTime qnaRegDate;
    private long originId;

    public Qna getDomain() {

        Qna qna = Qna.builder()
                .qnaId(qnaId)
                .qnaTitle(qnaTitle)
                .qnaContent(qnaContent)
                .qnaWriter(qnaWriter)
                .qnaAnswerEmail(qnaAnswerEmail)
                .qnaRegDate(qnaRegDate)
                .originId(originId)
                .build();

        return qna;

    }
}
