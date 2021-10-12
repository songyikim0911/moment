package com.days.moment.miniboard.service;

import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.miniboard.domain.Mini;
import com.days.moment.miniboard.dto.MiniDTO;
import com.days.moment.miniboard.mapper.MiniMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Log4j2
@RequiredArgsConstructor
public class MiniServiceImpl implements MiniService {

    private final MiniMapper miniMapper;

    @Override
    public Long register(MiniDTO miniDTO) {

        Mini mini = miniDTO.getDomain();

        miniMapper.insert(mini);

        Long mbNo = mini.getMbNo();

        mini.getAttachList().forEach(miniAttach -> {
            miniAttach.setMbNo(mbNo);
            miniMapper.insertAttach(miniAttach);
        });

        return mini.getMbNo();
    }

    @Override
    public PageResponseDTO<MiniDTO> getDTOList(PageRequestDTO pageRequestDTO) {

        List<MiniDTO> dtoList = miniMapper.getList(pageRequestDTO).stream().map(mini -> mini.getDTO()).collect(Collectors.toList());
        int count = miniMapper.getCount(pageRequestDTO);

        PageResponseDTO<MiniDTO> pageResponseDTO = PageResponseDTO.<MiniDTO>builder()
                .dtoList(dtoList)
                .count(count)
                .build();

        return pageResponseDTO;

    }

    @Override
    public MiniDTO read(Long mbNo) {

        Mini mini = miniMapper.select(mbNo);

        if(mini != null) {
            return mini.getDTO();
        }
        return null;
    }

    @Override
    public boolean remove(Long mbNo) {
        return miniMapper.delete(mbNo) > 0;
    }

    @Override
    public boolean modify(MiniDTO miniDTO) {

        miniMapper.deleteAttach(miniDTO.getMbNo());

        Mini mini = miniDTO.getDomain();

        Long mbNo = mini.getMbNo();

        mini.getAttachList().forEach(miniAttach -> {
            miniAttach.setMbNo(mbNo);
            miniMapper.insertAttach(miniAttach);
        });

        return miniMapper.update(mini) > 0;
    }
}
