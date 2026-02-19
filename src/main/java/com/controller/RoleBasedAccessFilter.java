package com.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*") // Filter ALL requests
public class RoleBasedAccessFilter implements Filter {
    
    private Map<String, List<String>> roleAccessMap;
    private List<String> publicUrls; // URLs accessible without login
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Define URL patterns that are PUBLIC (no login required)
        publicUrls = Arrays.asList(
            "/AdminLogin.jsp",
            "/loginpage", // Login servlet
            "/css/",
            "/js/",
            "/images/",
            "/fonts/",
            "/vendor/",
            "/school/home.jsp",
            "/school/cur.jsp",
            "/school/about.jsp",
            "/school/contact.jsp",
            "/AdminLogin.jsp",
            "/uploads/"
        );
        
        // Define URL patterns accessible by each role
        roleAccessMap = new HashMap<>();
        
        roleAccessMap.put("student", Arrays.asList(
        		 "/index.jsp",
        		    "/school/home.jsp",   // ✅ ADD THIS
        	    "/home.jsp",
        	    "/students.jsp",
        	    "/student-dashboard.jsp",
        	    "/student-profile.jsp",
        	    "/BillingPage.jsp",
        	    "/PreviewPage.jsp",
        	    "/printreceipt.jsp",
        	    "/payment.jsp",
        	    "/about.jsp",
        	    
        	    // ✅ REQUIRED SERVLETS
        	    "/GetStudentProfile",
        	    "/SearchServlet",
        	    "/UploadPhotoServlet",
        	    "/UpdateStudentProfile",
        	    "/addPayment",
        	    "/previewthebill",
        	    "/createOrder",
        	    
        	    // optional
        	    "/logout.jsp"
        	));

        
        // FACULTY Role - Can access student URLs + faculty-specific
        List<String> facultyUrls = Arrays.asList(
            "/faculty.jsp",
            "/faculty-dashboard.jsp",
            "/mark-attendance.jsp",
            "/view-students.jsp",
            "/upload-marks.jsp",
            "/attendance-report.jsp"
        );
        roleAccessMap.put("faculty", facultyUrls);
        
        // ADMIN Role - Can access EVERYTHING (no restrictions)
        roleAccessMap.put("admin", Arrays.asList("/*")); // Wildcard for all access
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        System.out.println("Filter checking: " + path + " | Role: " + 
                          (httpRequest.getSession(false) != null ? 
                           httpRequest.getSession().getAttribute("Roles") : "No session"));
        
        // Check if this is a public resource
        if (isPublicResource(path)) {
            chain.doFilter(request, response);
            return;
        }
        
        HttpSession session = httpRequest.getSession(false);
        
     // If no session or role is null → redirect to PUBLIC home page
        if (session == null || session.getAttribute("Roles") == null) {

            // Avoid infinite loop
            if (!path.equals("/school/home.jsp")) {
                httpResponse.sendRedirect(contextPath + "/school/home.jsp");
                return;
            }

            // Already on home.jsp → allow
            chain.doFilter(request, response);
            return;
        }

        
        String userRole = (String) session.getAttribute("Roles");
        
        // Check access permission
        if (!hasAccess(userRole, path)) {

            // AJAX request → return 403
            if ("XMLHttpRequest".equals(httpRequest.getHeader("X-Requested-With"))) {
                httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            // Normal page request → redirect
            redirectToDashboard(httpResponse, contextPath, userRole);
            return;
        }

        chain.doFilter(request, response);
    }
    
    private boolean isPublicResource(String path) {
        // Check if path matches any public URL pattern
        for (String publicUrl : publicUrls) {
            if (path.startsWith(publicUrl) || 
                path.equals(publicUrl) || 
                path.contains(publicUrl)) {
                return true;
            }
        }
        
        // Allow access to login page
        if (path.equals("/") || path.equals("") || path.equals("/index.jsp")) {
            return true;
        }
        
        // Allow specific file extensions
        if (path.endsWith(".css") || path.endsWith(".js") || 
            path.endsWith(".png") || path.endsWith(".jpg") || 
            path.endsWith(".jpeg") || path.endsWith(".gif") || 
            path.endsWith(".ico") || path.endsWith(".woff") || 
            path.endsWith(".woff2") || path.endsWith(".ttf")) {
            return true;
        }
        
        return false;
    }
    
   
    private boolean hasAccess(String userRole, String path) {

        // ✅ Admin can access everything
        if ("admin".equalsIgnoreCase(userRole)) {
            return true;
        }

        // ✅ ALLOW ALL SERVLETS (NO MANUAL ADDING)
        if (path.endsWith("Servlet")) {
            return true;
        }

        List<String> allowedUrls = roleAccessMap.get(userRole);
        if (allowedUrls == null) {
            return false;
        }

        for (String allowedUrl : allowedUrls) {
            if (path.startsWith(allowedUrl) || path.equals(allowedUrl)) {
                return true;
            }
        }

        return false;
    }

    
    private void redirectToDashboard(HttpServletResponse response, 
                                    String contextPath, String userRole) 
            throws IOException {
        switch (userRole) {
            case "student":
                response.sendRedirect(contextPath + "/students.jsp");
                break;
            case "faculty":
                response.sendRedirect(contextPath + "/faculty/faculty.jsp");
                break;
            case "admin":
                response.sendRedirect(contextPath + "/home.jsp");
                break;
            default:
                response.sendRedirect(contextPath + "/AdminLogin.jsp");
        }
    }
    
    @Override
    public void destroy() {
        // Cleanup if needed
    }
}