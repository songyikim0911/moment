package com.days.moment.setting.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@EnableWebMvc
@ComponentScan(basePackages = "com.days.moment.setting.controller")
public class SettingServletConfig implements WebMvcConfigurer {



}
