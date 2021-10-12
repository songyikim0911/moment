package com.days.moment.miniboard.domain;

import com.days.moment.common.dto.UploadResponseDTO;
import com.days.moment.miniboard.dto.MiniDTO;
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
public class Mini {

    private long mbNo;
    private String mbContent, mbWriter, mbTitle;
    private LocalDateTime mbRegDate, mbModDate;
    private int mbReCount;

    @Builder.Default
    private List<MiniAttach> attachList = new ArrayList<>();

    public MiniDTO getDTO() {
        MiniDTO miniDTO = MiniDTO.builder()
                .mbNo(mbNo)
                .mbTitle(mbTitle)
                .mbContent(mbContent)
                .mbWriter(mbWriter)
                .mbRegDate(mbRegDate)
                .mbModDate(mbModDate)
                .mbReCount(mbReCount)
                .build();

        List<UploadResponseDTO> uploadResponseDTOList =  attachList.stream().map(miniAttach -> {
            UploadResponseDTO uploadResponseDTO = UploadResponseDTO.builder()
                    .uuid(miniAttach.getUuid())
                    .fileName(miniAttach.getFileName())
                    .uploadPath(miniAttach.getPath())
                    .image(miniAttach.isImage())
                    .build();
            return uploadResponseDTO;
        }).collect(Collectors.toList());

        miniDTO.setFiles(uploadResponseDTOList);

        return miniDTO;
    }

    public void setMbNo(Long mbNo) {
        this.mbNo = mbNo;
    }

    public void addAttach(MiniAttach miniAttach) {

        attachList.add(miniAttach);

    }
}
