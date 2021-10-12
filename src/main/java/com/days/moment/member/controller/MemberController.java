package com.days.moment.member.controller;

import com.days.moment.common.dto.PageMaker;
import com.days.moment.common.dto.PageRequestDTO;
import com.days.moment.common.dto.PageResponseDTO;
import com.days.moment.member.domain.Member;
import com.days.moment.member.dto.JoinDTO;
import com.days.moment.member.dto.MemberDTO;
import com.days.moment.member.service.CustomUserDetailsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/member/*")
@Log4j2
@RequiredArgsConstructor
public class MemberController {

    private final CustomUserDetailsService customUserDetailsService;

    @PreAuthorize("permitAll()")
    @GetMapping("/join")
    public void joinGet(){

    }



    @PreAuthorize("permitAll()")
    @PostMapping("/doblock")
    public String blockingPost(String memId){


        log.info("---blockingPost controller---");
                log.info(memId);
        customUserDetailsService.blockUser(memId);

        log.info("-----blockingPost c after blockUser ");
        log.info(memId);

        return "redirect:/member/list";

    }


    @PreAuthorize("permitAll()")
    @PostMapping("/dounblock")
    public String unBlockingPost(String memId){


        log.info("---unblockingPost controller---");
        log.info(memId);
        customUserDetailsService.unBlockUser(memId);

        log.info("-----unblockingPost c after blockUser ");
        log.info(memId);

        return "redirect:/member/list";

    }

    @PreAuthorize("permitAll()")
    @GetMapping("/list")
    public void getList(PageRequestDTO pageRequestDTO, Model model){

        log.info("c getList...." + pageRequestDTO);

        log.info("==============");
        log.info(customUserDetailsService);
        log.info(customUserDetailsService.getClass().getName());

        PageResponseDTO<JoinDTO> responseDTO = customUserDetailsService.getDTOList(pageRequestDTO);

        model.addAttribute("dtoList", responseDTO.getDtoList());

        int total = responseDTO.getCount();
        int page = pageRequestDTO.getPage();
        int size = pageRequestDTO.getSize();

        model.addAttribute("pageMaker", new PageMaker(page,size,total));


    }


    @PreAuthorize("permitAll()")
    @PostMapping("/join")
    public String joinPost(JoinDTO joinDTO, RedirectAttributes redirectAttributes){

        log.info("---joinPost---");
        log.info("---joinPost---");
        log.info("---joinPost---");
        log.info(joinDTO);
        //String memId, String memPwd, String memNick, String memName, String memSex,
//        log.info(memId);
//                log.info(memPwd);
//                log.info(memNick);
//                log.info(memName);
//                log.info(memSex);
//

//                MemberDTO memberDTO = MemberDTO.builder()
//                        .memId(memId)
//                        .memPwd(memPwd)
//                        .memName(memName)
//                        .enabled(enabled)
//                        .memNick(memNick)
//                        .memBirthday(memBirthday)
//                        .memAnniversary(memAnniversary)
//                        .memEmailCert(memEmailCert)
//                        .memSex(memSex)
//                        .lastLogin(lastLogin)
//                        .memRegister(memRegister)
//                        .memDormant(memDormant)
//                        .memDenied(memDenied)
//                        .build();
//
////
//


        customUserDetailsService.register(joinDTO);

        redirectAttributes.addFlashAttribute("result", joinDTO.getMemId());

        return "redirect:/member/joinsuccess";


    }


    @PreAuthorize("permitAll()")
    @GetMapping("/joinsuccess")
    public void joinSuccessGet(){

    }

}
