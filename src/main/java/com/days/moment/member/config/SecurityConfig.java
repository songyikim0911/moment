package com.days.moment.member.config;

import com.days.moment.member.handler.CustomAccessDeniedHandler;
import com.days.moment.member.handler.CustomAuthenticationEntryPoint;
import com.days.moment.member.handler.CustomLoginFailureHandler;
import com.days.moment.member.handler.CustomLoginSuccessHandler;
import com.days.moment.member.service.CustomUserDetailsService;
import lombok.extern.log4j.Log4j2;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
@Log4j2
@MapperScan(basePackages = "com.days.moment.member.mapper")
@ComponentScan(basePackages = "com.days.moment.member.service")
public class SecurityConfig extends WebSecurityConfigurerAdapter {


    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @Autowired
    private DataSource dataSource;

    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

//        http.authorizeRequests()
//                .antMatchers("/sample/doAll").permitAll()
//                .antMatchers("/sample/doMember").access("hasRole('ROLE_MEMBER')")
//                .antMatchers("/sample/doAdmin").access("hasRole('ROLE_ADMIN')");

        http.formLogin().loginPage("/customLogin").loginProcessingUrl("/login");
        http.formLogin().successHandler(customLoginSuccessHandler());
        http.formLogin().failureHandler(customLoginFailureHandler());
//        http.formLogin().loginPage("/customLogin").failureHandler(customLoginFailureHandler());

        //http.logout().invalidateHttpSession(true);

        http.csrf().disable();

        http.rememberMe().tokenRepository(persistentTokenRepository())
                .key("days").tokenValiditySeconds(60*60*24*30);



        http.exceptionHandling()
                .authenticationEntryPoint(customAuthenticationEntryPoint());

        //        .accessDeniedHandler(accessDeniedHandler());

//        http.exceptionHandling().accessDeniedHandler(accessDeniedHandler());


    }


    @Bean
    public CustomAccessDeniedHandler accessDeniedHandler() {
        return new CustomAccessDeniedHandler();
    }

    @Bean
    public CustomAuthenticationEntryPoint customAuthenticationEntryPoint(){
        return new CustomAuthenticationEntryPoint();
    }

    @Bean
    public CustomLoginSuccessHandler customLoginSuccessHandler(){
        return new CustomLoginSuccessHandler();
    }

    @Bean
    public CustomLoginFailureHandler customLoginFailureHandler(){return new CustomLoginFailureHandler();}

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {

        auth.userDetailsService(customUserDetailsService);

//        auth.userDetailsService(customUserDetailsService());

//        auth.inMemoryAuthentication().withUser("member1").password("$2a$10$9rUFqjfYHdYDObkYyx6gM.bGtmMzCpGabThB6KpgV3wE6HgjMRmK2")
//                .roles("MEMBER");
//        auth.inMemoryAuthentication().withUser("admin1").password("$2a$10$9rUFqjfYHdYDObkYyx6gM.bGtmMzCpGabThB6KpgV3wE6HgjMRmK2")
//                .roles("MEMBER","ADMIN");
    }

//    @Bean
//    public CustomUserDetailsService customUserDetailsService() {
//        return new CustomUserDetailsService(memberMapper);
//    }

    @Bean
    public PersistentTokenRepository persistentTokenRepository(){
        JdbcTokenRepositoryImpl repository = new JdbcTokenRepositoryImpl();
        repository.setDataSource(dataSource);
        return repository;
    }
}
