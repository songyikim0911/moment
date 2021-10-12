package com.days.moment.miniboard.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebMvc
@ComponentScan(basePackages = "com.days.moment.miniboard.controller")
public class MiniServletConfig implements WebMvcConfigurer {



}
