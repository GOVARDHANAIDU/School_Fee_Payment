package com.Exception;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/errorHandler")
public class CustomErrorServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        Integer statusCode = (Integer) req.getAttribute("jakarta.servlet.error.status_code");
        String requestUri = (String) req.getAttribute("jakarta.servlet.error.request_uri");
        if (requestUri == null) {
            requestUri = "Unknown";
        }

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Error</title>");
        out.println("<style>");
        out.println("body {font-family: Arial; text-align: center; background-color: #f4f4f4; padding-top: 100px;}");
        out.println(".btn {padding: 10px 20px; background: #007BFF; color: white; text-decoration: none; margin: 20px; border-radius: 5px;}");
        out.println(".btn:hover {background: #0056b3;}");
        out.println("</style></head><body>");
        out.println("<h1>404 - Page Not Found</h1>");
        out.println("<p>The requested URL <strong>" + requestUri + "</strong> was not found on this server.</p>");
        out.println("<div>");
        out.println("<a class='btn' href='javascript:history.back()'>← Back</a>");
        out.println("<a class='btn' href='index.jsp'>Home →</a>");
        out.println("</div>");
        out.println("</body></html>");
    }
}
