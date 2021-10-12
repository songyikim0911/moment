package com.days.moment.notice.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@MapperScan(basePackages = "com.days.moment.notice.mapper")
@ComponentScan(basePackages = "com.days.moment.notice.service")
@Import(NoticeAOPConfig.class)
public class NoticeRootConfig {



}
