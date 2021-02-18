package com.ncist.mymusic.interceptor;

import com.ncist.mymusic.entity.Admin;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BackendLoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        if (httpServletRequest.getServletPath().equals("/backend/admin/login") || httpServletRequest.getServletPath().equals("/backend/admin/admin-login")) {
            return true;
        }else {
            Admin admin = (Admin) httpServletRequest.getSession().getAttribute("currentAdmin");
            if (admin != null && admin.getId() != 0 && admin.getStatus().equals("正常")) {
                return true;
            }else {
                httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/backend/admin/login");
                return false;
            }
        }
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
