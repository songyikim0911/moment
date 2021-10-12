package com.days.moment.miniboard.config;


import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@MapperScan(basePackages = "com.days.moment.miniboard.mapper")
@ComponentScan(basePackages = "com.days.moment.miniboard.service")
@Import(MiniAOPConfig.class)
public class MiniRootConfig {
}
