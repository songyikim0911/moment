package com.days.moment.member.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;

@Configuration
@ComponentScan(basePackages = {"com.days.moment.member.controller"})
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityServletConfig {
}
