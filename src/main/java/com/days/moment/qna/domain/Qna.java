package com.days.moment.qna.domain;

import com.days.moment.qna.dto.QnaDTO;
import lombok.*;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDateTime;

@Getter
@ToString
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Qna {

    private long qnaId;
    private String qnaTitle;
    private String qnaContent;
    private String qnaWriter;
    private String qnaAnswerEmail;
    private LocalDateTime qnaRegDate;
    private long originId;

    public QnaDTO getDTO() {
        QnaDTO qnaDTO = QnaDTO.builder()
                .qnaId(qnaId)
                .qnaTitle(qnaTitle)
                .qnaContent(qnaContent)
                .qnaWriter(qnaWriter)
                .qnaAnswerEmail(qnaAnswerEmail)
                .qnaRegDate(qnaRegDate)
                .originId(originId)
                .build();

        return qnaDTO;
    }

    public void setQnaId(Long qnaId) {
        this.qnaId = qnaId;
    }


}
