package com.days.moment.miniboard.controller;

import com.days.moment.common.dto.PageMaker;
import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.miniboard.dto.MiniDTO;
import com.days.moment.miniboard.service.MiniService;
import com.days.moment.miniboard.service.MiniTimeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j2
@RequiredArgsConstructor
@RequestMapping("/miniboard")
public class MiniController {

    private final MiniTimeService miniTimeService;

    private final MiniService miniService;

    @GetMapping("/time")
    public void getTime(Model model) {
        log.info("===================================");
        log.info("===================================");
        log.info("===================================");

        model.addAttribute("time", miniTimeService.getNow());
    }

    @GetMapping("/write")
    public void registerGet() {

    }

    @PostMapping("/write")
    public String registerPost(MiniDTO miniDTO, RedirectAttributes redirectAttributes) {
        Long mbNo = miniService.register(miniDTO);

        redirectAttributes.addFlashAttribute("result", mbNo);

        return "redirect:/miniboard/list";
    }

    @GetMapping("/list")
    public void getList(PageRequestDTO pageRequestDTO, Model model) {

        PageResponseDTO<MiniDTO> responseDTO = miniService.getDTOList(pageRequestDTO);
        log.info("c         getList.........................." + pageRequestDTO);

        model.addAttribute("dtoList", responseDTO.getDtoList());

        int total = responseDTO.getCount();
        int page = pageRequestDTO.getPage();
        int size = pageRequestDTO.getSize();

        model.addAttribute("pageMaker", new PageMaker(page, size, total));
    }

    @PostMapping("/remove")
    public String remove(Long mbNo, RedirectAttributes redirectAttributes){
        log.info("c               remove : " + mbNo);

        if(miniService.remove(mbNo)){
            log.info("remove success");
            log.info("remove success");
            redirectAttributes.addFlashAttribute("result", "success");
        }
        return "redirect:/miniboard/list";
    }

    @GetMapping(value = {"/read", "/modify"})
    public void read(Long mbNo, PageRequestDTO pageRequestDTO, Model model) {
        log.info("c       read " + mbNo);
        log.info("c       read " + pageRequestDTO);
        model.addAttribute("miniDTO", miniService.read(mbNo));
    }

    @PostMapping("/modify")
    public String modify(MiniDTO miniDTO,PageRequestDTO pageRequestDTO , RedirectAttributes redirectAttributes){
        log.info("c               modify : " + miniDTO);
        if(miniDTO.getFiles().size() > 0) {
            miniDTO.getFiles().forEach(dto -> log.info(dto));
        }

        if(miniService.modify(miniDTO)){
            log.info("modify success");
            redirectAttributes.addFlashAttribute("result", "modified");
        }

        redirectAttributes.addAttribute("mbNo", miniDTO.getMbNo());
        redirectAttributes.addAttribute("page", pageRequestDTO.getPage());
        redirectAttributes.addAttribute("size", pageRequestDTO.getSize());

        if(pageRequestDTO.getType() != null) {
            redirectAttributes.addAttribute("type", pageRequestDTO.getType());
            redirectAttributes.addAttribute("keyword", pageRequestDTO.getKeyword());
        }

        return "redirect:/miniboard/list";
    }

}
