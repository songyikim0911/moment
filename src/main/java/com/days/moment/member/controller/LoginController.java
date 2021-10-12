package com.days.moment.member.controller;

import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@Log4j2
public class LoginController {

    @GetMapping("/customLogin")
    public void loginCustom(){
        log.warn("custom login...get");
    }

    @PostMapping("/customLoginError")
    public String loginCustomPost(String loginFailMsg, RedirectAttributes redirectAttributes){
        log.warn("custom login...post");
        redirectAttributes.addAttribute("loginFailMsg", loginFailMsg);
        log.warn("custom login...post");
     return "redirect:/customLogin?loginFailMsg=" + loginFailMsg;
    }

    @GetMapping("/customLoginError")
    public void loginCustomGet(String loginFailMsg, Model model, RedirectAttributes redirectAttributes){
        log.info("---logincustomget---");
        model.addAttribute("loginFailMsg", loginFailMsg);

        log.info(loginFailMsg);
    }

}
