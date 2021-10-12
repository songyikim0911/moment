package com.days.moment.miniboard.domain;


import lombok.*;

@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class MiniAttach {

    private String uuid;
    private Long mbNo;
    private String fileName;
    private String path;
    private boolean image;


    public void setMbNo(Long mbNo) {
        this.mbNo = mbNo;
    }
}
