package com.days.moment.notice.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebMvc
@ComponentScan(basePackages = "com.days.moment.notice.controller")
public class NoticeServletConfig implements WebMvcConfigurer {

}
