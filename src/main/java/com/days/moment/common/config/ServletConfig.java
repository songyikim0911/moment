package com.days.moment.common.config;


import com.days.moment.board.config.BoardServletConfig;
import com.days.moment.common.converter.StringToLocalDateTimeConverter;
import com.days.moment.miniboard.config.MiniServletConfig;
import com.days.moment.notice.config.NoticeServletConfig;
import com.days.moment.qna.config.QnaServletConfig;
import com.days.moment.setting.config.SettingServletConfig;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Import;
import org.springframework.format.FormatterRegistry;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@EnableWebMvc
@Import({NoticeServletConfig.class, BoardServletConfig.class, QnaServletConfig.class, MiniServletConfig.class, SettingServletConfig.class})
@ComponentScan(basePackages = {"com.days.moment.common.exception", "com.days.moment.common.controller"})
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class ServletConfig implements WebMvcConfigurer {

    @Override
    public void addFormatters(FormatterRegistry registry) {
       registry.addConverter(new StringToLocalDateTimeConverter());
    }

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {

        InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/views/");
        bean.setSuffix(".jsp");
        registry.viewResolver(bean);
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        //이 경로 (webapp resources folder) 는 스프링 영향을 주지 않겠다는 의미.
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");

    }
}
