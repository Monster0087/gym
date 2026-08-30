package com.gym.filter;

import com.gym.util.MultiTabRequestWrapper;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String path = httpRequest.getServletPath();

        // 1. Skip filter for static resources
        if (path.contains("/css/") || path.contains("/js/") || path.contains("/images/")) {
            chain.doFilter(request, response);
            return;
        }

        // 2. Get Tab ID from header or parameter
        String tabId = httpRequest.getHeader("X-Tab-ID");
        if (tabId == null) tabId = httpRequest.getParameter("tabId");

        // 3. Wrap request for tab isolation
        HttpServletRequest wrappedRequest = new MultiTabRequestWrapper(httpRequest, tabId);
        HttpSession session = wrappedRequest.getSession(false);
        
        // 4. Public pages (login, register, index, about, etc.)
        boolean isPublicPage = path.endsWith("login.jsp") || path.endsWith("login") || 
                              path.endsWith("register.jsp") || path.endsWith("register") ||
                              path.endsWith("index.jsp") || path.equals("/") || 
                              path.endsWith("about.jsp") || path.endsWith("contact.jsp") ||
                              path.endsWith("gallery.jsp") || path.endsWith("services.jsp") ||
                              path.endsWith("diet-plans.jsp") || path.endsWith("trainers.jsp") ||
                              path.endsWith("workouts.jsp") || path.endsWith("payment-result.jsp");

        if (isPublicPage) {
            chain.doFilter(wrappedRequest, response);
            return;
        }

        // 5. Check if user is logged in for protected pages
        if (session == null || session.getAttribute("user") == null) {
            if (path.startsWith("/api/")) {
                httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                httpResponse.getWriter().write("{\"error\": \"Unauthorized\"}");
            } else {
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?tabId=" + (tabId != null ? tabId : ""));
            }
            return;
        }
        
        chain.doFilter(wrappedRequest, response);
    }
    
    @Override
    public void destroy() {}
}
