package com.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class AuthenticationFilter implements Filter {

    public void init(FilterConfig filterConfig) { }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();

        HttpSession session = req.getSession(false);

        boolean allowed =
                path.contains("AdminLogin.jsp") ||
                path.contains("createaccount.jsp") ||
                path.contains("LoginServlet") ||
                path.contains("/css") ||
                path.contains("/js") ||
                path.contains("/images") ||
                path.contains("/uploads");

        // 💥 CHECK SESSION BEFORE RENDERING THE PAGE
        if (!allowed) {
            if (session == null || session.getAttribute("adminName") == null) {
                res.sendRedirect(req.getContextPath() + "/AdminLogin.jsp");
                return;
            }
        }

        // 💥 SET NO-CACHE HEADERS HERE (BEFORE JSP LOADS)
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);

        chain.doFilter(request, response);
    }

    public void destroy() { }
}
