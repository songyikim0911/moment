package com.days.moment.miniboard.dto;


import com.days.moment.common.dto.UploadResponseDTO;
import com.days.moment.miniboard.domain.Mini;
import com.days.moment.miniboard.domain.MiniAttach;
import com.fasterxml.jackson.annotation.JsonFormat;
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
public class MiniDTO {

    private long mbNo;
    private String mbContent;
    private String mbWriter;
    private String mbTitle;
    private LocalDateTime mbRegDate;
    private LocalDateTime mbModDate;
    private int mbReCount;

    @Builder.Default//초기화 필요하여 사용
    private List<UploadResponseDTO> files = new ArrayList<>();

    public Mini getDomain() {

        Mini mini = Mini.builder()
                .mbNo(mbNo)
                .mbTitle(mbTitle)
                .mbContent(mbContent)
                .mbWriter(mbWriter)
                .mbRegDate(mbRegDate)
                .mbModDate(mbModDate)
                .mbReCount(mbReCount)
                .build();

        files.forEach(uploadResponseDTO -> {
            MiniAttach miniAttach = MiniAttach.builder()
                    .fileName(uploadResponseDTO.getFileName())
                    .uuid(uploadResponseDTO.getUuid())
                    .image(uploadResponseDTO.isImage())
                    .path(uploadResponseDTO.getUploadPath())
                    .build();

            mini.addAttach(miniAttach);
        });

        return mini;

    }
}
