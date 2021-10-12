package com.days.moment.miniboard.service;


import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.miniboard.dto.MiniDTO;
import org.springframework.transaction.annotation.Transactional;


@Transactional
public interface MiniService {

    Long register (MiniDTO miniDTO);

    PageResponseDTO<MiniDTO> getDTOList(PageRequestDTO pageRequestDTO);

    MiniDTO read(Long mbNo);

    boolean remove(Long mbNo);

    boolean modify(MiniDTO miniDTO);
}
