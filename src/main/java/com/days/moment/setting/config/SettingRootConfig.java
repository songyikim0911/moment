package com.days.moment.setting.config;


import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@MapperScan(basePackages = "com.days.moment.setting.mapper")
@ComponentScan(basePackages = "com.days.moment.setting.service")
@Import(SettingAOPConfig.class)
public class SettingRootConfig {
}
