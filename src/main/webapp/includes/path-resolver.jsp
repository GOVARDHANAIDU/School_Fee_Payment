<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
    // Calculate relative path to root
    String currentPath = request.getRequestURI();
    String contextPath = request.getContextPath();
    
    // Remove context path
    String relativePath = currentPath.substring(contextPath.length());
    
    // Count directory depth
    int depth = 0;
    if (!relativePath.equals("/")) {
        String[] parts = relativePath.split("/");
        depth = parts.length - 2; // -2 because of leading slash and filename
    }
    
    // Build relative path to root
    StringBuilder rootPath = new StringBuilder();
    for (int i = 0; i < depth; i++) {
        rootPath.append("../");
    }
    
    request.setAttribute("rootPath", rootPath.toString());
    request.setAttribute("contextPath", contextPath);
%>