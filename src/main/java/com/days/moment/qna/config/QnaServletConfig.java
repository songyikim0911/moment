package com.days.moment.qna.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebMvc
@ComponentScan(basePackages = "com.days.moment.qna.controller")
public class QnaServletConfig implements WebMvcConfigurer {



}
