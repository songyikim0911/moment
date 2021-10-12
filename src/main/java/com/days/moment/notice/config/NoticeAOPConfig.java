package com.days.moment.notice.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

@Configuration
@EnableAspectJAutoProxy
@ComponentScan(basePackages = "com.days.moment.notice.aop")//aop클래스 빈으로 스캔
public class NoticeAOPConfig {
    //본래 BoardRootConfig 에 넣어도 되는내용이지만 이번엔 AOP  별도 zmffotm todtjd
}
