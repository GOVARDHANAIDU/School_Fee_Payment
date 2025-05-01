<!DOCTYPE html>
<%@page import="com.DTO.FeePayment"%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Fee Receipt</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <style>
    
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f9f9f9;
      padding: 30px;
    }
     @media print {
    body {
      margin: 0;
      padding: 0;
      background: white;
    }

    .print-btn {
      display: none !important; /* Hide print button */
    }

    @page {
      margin: 0; /* Remove default page margins */
    }
  }
    .receipt {
      max-width: 700px;
      margin: auto;
      background: #fff;
      padding: 30px 40px;
      border: 1px solid #ccc;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .header {
      text-align: center;
      margin-bottom: 30px;
    }

    .header h1 {
      margin: 0;
      font-size: 26px;
      color: #2a4365;
    }

    .header p {
      margin: 0;
      font-size: 14px;
      color: #444;
    }

    .info-section {
      margin-bottom: 20px;
    }

    .info-section table {
      width: 100%;
      border-collapse: collapse;
    }

    .info-section td {
      padding: 8px;
      font-size: 16px;
    }

    .label {
      font-weight: bold;
      color: #333;
      width: 40%;
    }

    .amount-section {
      background: #f1f5f9;
      padding: 15px 20px;
      border-radius: 8px;
      margin-top: 20px;
    }

    .amount-section table {
      width: 100%;
    }

    .amount-section td {
      padding: 10px;
      font-size: 16px;
    }

    .total {
      font-weight: bold;
      font-size: 18px;
      color: #2a4365;
    }

    .footer {
      text-align: center;
      margin-top: 30px;
      font-size: 14px;
      color: #666;
    }

    .print-btn {
      display: block;
      margin: 20px auto;
      padding: 10px 30px;
      background: #2a4365;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      cursor: pointer;
    }

    .print-btn:hover {
      background-color: #4c6795;
    }
  </style>
</head>
<body>

  <div class="receipt">
    <div class="header">
      <h1>&#9925; Bright Future High School</h1>
      <p>123 School Lane, Knowledge City, India | Ph: 86456-56789</p>
      <hr style="margin-top: 15px;">
      <h3>Student Fee Receipt</h3>
    </div>
  <%
  FeePayment feePayment = new FeePayment();
  
  %>
    <div class="info-section">
      <table>
        <tr>
          <td class="label">Student Name:</td>
          <td><%=request.getParameter("studentName")%></td>
        </tr>
        <tr>
          <td class="label">Admission Number:</td>
          <td><%= request.getParameter("admin.no") %></td>
        </tr>
        <tr>
          <td class="label">Email ID:</td>
          <td><%= request.getParameter("emailid") %></td>
        </tr>
        <tr>
          <td class="label">Phone Number:</td>
          <td><%= request.getParameter("phoneNumber") %></td>
        </tr>
      </table>
    </div>

    <div class="amount-section">
      <table>
        <tr>
          <td class="label">Total Fee:</td>
          <td>&#8377; <%=request.getParameter("amount")%></td>
        </tr>
        <tr>
          <td class="label">Fee Already Paid:</td>
          <td>&#8377; <%= request.getParameter("paidfee") %></td>
        </tr>
        <tr>
          <td class="label">Fee Paid Now:</td>
          <td>&#8377; <%= request.getParameter("payingfee") %></td>
        </tr>
        <tr>
          <td class="label total">Remaining Balance:</td>
          <td class="total">
            &#8377;
            <%
              try {
                double total = Double.parseDouble(request.getParameter("amount"));
                double paid = Double.parseDouble(request.getParameter("paidfee"));
                double now = Double.parseDouble(request.getParameter("payingfee"));
                double balance = paid + now;
                double remainingBalance = total - balance;
                out.print(remainingBalance);
              } catch (Exception e) {
                out.print("N/A");
              }
            %>
            
          </td>
        </tr>
      </table>
    </div>

    <div class="footer">
      <p>Generated on: <%= new java.util.Date() %></p>
      <p>Thank you for your payment!</p>
    </div>

    <button class="print-btn" onclick="window.print()">&#xf0c7; Print Receipt</button>
  </div>

</body>
</html>
