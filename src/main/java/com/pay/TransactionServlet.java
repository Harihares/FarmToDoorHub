package com.pay;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/TransactionServlet")
public class TransactionServlet extends HttpServlet {
  
	private static final long serialVersionUID = 1L;
	private TransactionDAO transactionDAO = new TransactionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("cid"));

        List<Transaction> transactions = transactionDAO.getTransactionsByCustomerId(customerId);
        request.setAttribute("transactions", transactions);

        request.getRequestDispatcher("transactions.jsp").forward(request, response);
    }
}
