package com.days.moment.qna.controller;

import com.days.moment.common.dto.PageMaker;
import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.miniboard.dto.MiniDTO;
import com.days.moment.qna.dto.QnaDTO;
import com.days.moment.qna.service.QnaService;
import com.days.moment.qna.service.QnaTimeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/qna")
@Log4j2
@RequiredArgsConstructor
public class QnaController {

    private final QnaTimeService qnaTimeService;

    private final QnaService qnaService;

    @GetMapping("/time")
    public void getTime(Model model) {
        log.info("===================================");
        log.info("===================================");
        log.info("===================================");

        model.addAttribute("time", qnaTimeService.getNow());
    }

    @GetMapping(value = {"/write", "/writeAnswer"})
    public void registerGet() {

    }

    @PostMapping("/write")
    public String registerPost(QnaDTO qnaDTO, RedirectAttributes redirectAttributes) {
        Long qnaId = qnaService.register(qnaDTO);

        redirectAttributes.addFlashAttribute("result", qnaId);

        if(qnaService.originModify(qnaDTO)){
            log.info("modify success");
            redirectAttributes.addFlashAttribute("result", "modified");
        }
        return "redirect:/qna/list";
    }

    @PostMapping("/writeAnswer")
    public String registerPostAnswer(QnaDTO qnaDTO, RedirectAttributes redirectAttributes) {
        Long qnaId = qnaService.register(qnaDTO);
        log.info("Answer register success================");

        redirectAttributes.addFlashAttribute("result", qnaId);

        if(qnaService.answerModify(qnaDTO)){
            log.info("modify success");
            redirectAttributes.addFlashAttribute("result", "modified");
        }
        return "redirect:/qna/list";
    }

    @GetMapping("/list")
    public void getList(PageRequestDTO pageRequestDTO, Model model) {

        PageResponseDTO<QnaDTO> responseDTO = qnaService.getDTOList(pageRequestDTO);
        log.info("c         getList.........................." + pageRequestDTO);

        model.addAttribute("dtoList", responseDTO.getDtoList());

        int total = responseDTO.getCount();
        int page = pageRequestDTO.getPage();
        int size = pageRequestDTO.getSize();

        model.addAttribute("pageMaker", new PageMaker(page, size, total));
    }

    @GetMapping(value = {"/read"})
    public void read(Long qnaId, PageRequestDTO pageRequestDTO, Model model) {

        model.addAttribute("qnaDTO", qnaService.read(qnaId));
    }

    @PostMapping("/remove")
    public String remove(Long qnaId, RedirectAttributes redirectAttributes){
        log.info("c remove:" + qnaId);

        if(qnaService.remove((qnaId))){
            log.info("remove success");
            redirectAttributes.addFlashAttribute("result", "success");
        }
        return "redirect:/qna/list";

    }

}
