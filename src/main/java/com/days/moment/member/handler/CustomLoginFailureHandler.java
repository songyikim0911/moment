package com.days.moment.member.handler;

import lombok.extern.log4j.Log4j2;
import org.springframework.security.authentication.*;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Service;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

@Log4j2
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

//    private final String DEFAULT_FAILURE_URL = "/login?error=true";

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        log.info("--customLoginFailureHandler---");

        String loginFailMsg = "";

        if (exception instanceof AuthenticationServiceException) {
            loginFailMsg= "존재하지 않는 사용자입니다.";

        } else if(exception instanceof BadCredentialsException) {
            loginFailMsg= "아이디 또는 비밀번호가 틀립니다.";

        } else if(exception instanceof LockedException) {
            loginFailMsg= "차단된 계정입니다..";

        } else if(exception instanceof DisabledException) {
            loginFailMsg= "비활성화된 계정입니다..";

        } else if(exception instanceof AccountExpiredException) {
            loginFailMsg= "만료된 계정입니다..";

        } else if(exception instanceof CredentialsExpiredException) {
            loginFailMsg= "비밀번호가 만료되었습니다.";
        }
        log.info("--customLoginFailureHandler---");
        // 로그인 페이지로 다시 포워딩


       // request.getRequestDispatcher("/customLoginError").forward(request, response);
       // log.info("--customLoginFailureHandler---");

        log.info("---- customLoginFailureHandler");
        log.info(loginFailMsg);

        response.setCharacterEncoding("UTF-8");
        loginFailMsg = URLEncoder.encode(loginFailMsg,"UTF-8");
        response.sendRedirect("/customLoginError?loginFailMsg="+loginFailMsg);
    /*
    [com.days.moment.member.handler.CustomLoginFailureHandler] --customLoginFailureHandler---
2021-10-05 06:22:42  INFO [com.days.moment.member.handler.CustomLoginFailureHandler] --customLoginFailureHandler---
2021-10-05 06:22:42  INFO [com.days.moment.member.handler.CustomLoginFailureHandler] ---- customLoginFailureHandler
2021-10-05 06:22:42  INFO [com.days.moment.member.handler.CustomLoginFailureHandler] 아이디 또는 비밀번호가 틀립니다.
2021-10-05 06:22:42 TRACE [org.springframework.security.web.header.writers.HstsHeaderWriter] Not injecting HSTS header since it did not match request to [Is Secure]
2021-10-05 06:22:42 DEBUG [org.springframework.security.web.context.HttpSessionSecurityContextRepository] Did not store empty SecurityContext
2021-10-05 06:22:42 DEBUG [org.springframework.security.web.context.HttpSessionSecurityContextRepository] Did not store empty SecurityContext
2021-10-05 06:22:42 DEBUG [org.springframework.security.web.context.SecurityContextPersistenceFilter] Cleared SecurityContextHolder to complete request
2021-10-05 06:22:42 TRACE [org.springframework.security.web.FilterChainProxy] Trying to match request against DefaultSecurityFilterChain [RequestMatcher=any request, Filters=[org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter@50e11f4c, org.springframework.security.web.context.SecurityContextPersistenceFilter@2f164fdb, org.springframework.security.web.header.HeaderWriterFilter@589dda49, org.springframework.security.web.authentication.logout.LogoutFilter@7ae4a578, org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter@79f7373c, org.springframework.security.web.savedrequest.RequestCacheAwareFilter@1b9bb20c, org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter@52082881, org.springframework.security.web.authentication.rememberme.RememberMeAuthenticationFilter@76480009, org.springframework.security.web.authentication.AnonymousAuthenticationFilter@6659c8a7, org.springframework.security.web.session.SessionManagementFilter@3cee7bb9, org.springframework.security.web.access.ExceptionTranslationFilter@5f87ae17]] (1/1)
2021-10-05 06:22:42 DEBUG [org.springframework.security.web.FilterChainProxy] Securing GET /customLoginError?loginFailMsg=???%20??%20?????%20????.
2021-10-05 06:22:42 TRACE [org.springframework.security.web.FilterChainProxy] Invoking WebAsyncManagerIntegrationFilter (1/11)
2021-10-05 06:22:42 TRACE [org.springframework.security.web.FilterChainProxy] Invoking SecurityContextPersistenceFilter (2/11)
     */
    }
}
