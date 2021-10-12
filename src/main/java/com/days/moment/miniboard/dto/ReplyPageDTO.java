package com.days.moment.miniboard.dto;


import com.days.moment.miniboard.domain.Reply;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

import java.util.List;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {

    private List<Reply> list;
    private int replyCnt;
}
