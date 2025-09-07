package com.controller;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.ChartUtils;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.PiePlot;
import org.jfree.data.general.DefaultPieDataset;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.text.DecimalFormat;

@WebServlet("/chartServlet")
public class ChartServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DefaultPieDataset dataset = new DefaultPieDataset();
        System.out.println("Connecting to database...");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#");

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT Pass, COUNT(*) AS count FROM Class_3 GROUP BY Pass");

            while (rs.next()) {
                boolean isPass = rs.getBoolean("Pass");
                int count = rs.getInt("count");

                if (isPass) {
                    dataset.setValue("Passed (" + count + ")", count);
                } else {
                    dataset.setValue("Failed (" + count + ")", count);
                }
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        JFreeChart chart = ChartFactory.createPieChart(
                "Student Pass vs Fail Count",
                dataset,
                true, true, false);

        // Custom label format: label (count) - percentage
        PiePlot plot = (PiePlot) chart.getPlot();
        plot.setLabelGenerator(new StandardPieSectionLabelGenerator(
                "{0}: {1} students ({2})",
                new DecimalFormat("0"),
                new DecimalFormat("0%")
        ));

        response.setContentType("image/png");
        OutputStream out = response.getOutputStream();
        ChartUtils.writeChartAsPNG(out, chart, 600, 400);
        out.close();
    }
}
