package com.days.moment.notice.controller;
import com.days.moment.common.dto.PageMaker;
import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.notice.dto.NoticeDTO;
import com.days.moment.notice.service.NoticeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/notice/*")
@Log4j2
@RequiredArgsConstructor
public class NoticeController {



    private final NoticeService noticeService;

    @GetMapping("/write")
    public void writeGet(){

    }

    @PostMapping("/write")
    public String writePost(NoticeDTO noticeDTO, RedirectAttributes redirectAttributes){

        log.info("noticeDTOM"+noticeDTO);

       Long noticeNo = noticeService.register(noticeDTO);

       log.info("===== c writepost=====");
       log.info(noticeNo);

       redirectAttributes.addFlashAttribute("result", noticeNo);

       return "redirect:/notice/list";
    }

    @GetMapping("/list")
    public void getList(PageRequestDTO pageRequestDTO, Model model){
        log.info("c getList......"+pageRequestDTO);

        PageResponseDTO<NoticeDTO> responseDTO = noticeService.getDTOList(pageRequestDTO);

        model.addAttribute("dtoList", responseDTO.getDtoList());

        int total = responseDTO.getCount();
        int page = pageRequestDTO.getPage();
        int size = pageRequestDTO.getSize();

        model.addAttribute("pageMaker", new PageMaker(page, size, total));


    }

    @GetMapping(value ={"/read", "modify"})
    public void read(Long noticeNo, PageRequestDTO pageRequestDTO, Model model){
        log.info("c read" + noticeNo);
        log.info("c read" + pageRequestDTO);
        model.addAttribute("noticeDTO", noticeService.read(noticeNo));
    }


    @PostMapping("/modify")
    public String modify(NoticeDTO noticeDTO, PageRequestDTO pageRequestDTO, RedirectAttributes redirectAttributes){



        log.info("------");
        log.info("------");
        log.info(noticeDTO);
        if(noticeDTO.getFiles().size()>0) {
            noticeDTO.getFiles().forEach(dto -> log.info(dto));
        }
        log.info("------");
        log.info("------");
        log.info("------");


        if(noticeService.modify(noticeDTO)){
            redirectAttributes.addFlashAttribute("result","modified");
        }
        redirectAttributes.addAttribute("noticeNo", noticeDTO.getNoticeNo());
        redirectAttributes.addAttribute("page", pageRequestDTO.getPage());
        redirectAttributes.addAttribute("size", pageRequestDTO.getSize());

        if(pageRequestDTO.getType() !=null){
            redirectAttributes.addAttribute("type", pageRequestDTO.getType());
            redirectAttributes.addAttribute("keyword",pageRequestDTO.getKeyword());

        }
        return "redirect:/notice/read";

    }

    @PostMapping("/remove")
    public String remove(Long noticeNo, RedirectAttributes redirectAttributes){
        log.info("c remove:" + noticeNo);

        if(noticeService.remove((noticeNo))){
            log.info("remove success");
            redirectAttributes.addFlashAttribute("result", "success");
        }
        return "redirect:/notice/list";

    }

}