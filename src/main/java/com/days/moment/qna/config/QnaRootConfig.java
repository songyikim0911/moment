package com.days.moment.qna.config;


import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.Import;

@Configuration
@MapperScan(basePackages = "com.days.moment.qna.mapper")
@ComponentScan(basePackages = "com.days.moment.qna.service")
@Import(QnaAOPConfig.class)
public class QnaRootConfig {
}
