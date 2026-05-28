package com.fashionhub.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.fashionhub.dao.OrderDAO;
import com.fashionhub.model.OrderHistoryRow;
import com.fashionhub.model.User;
import com.fashionhub.util.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OrdersController")
public class OrdersController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = AuthUtil.getCurrentUser(request);
        if (user == null) {
            AuthUtil.redirectToAuthLogin(request, response,
                    request.getContextPath() + "/OrdersController");
            return;
        }

        HttpSession session = request.getSession(false);
        if (session != null) {
            Object flash = session.getAttribute(AuthUtil.SESSION_ORDERS_FLASH);
            if (flash instanceof String) {
                request.setAttribute("ordersFlash", flash);
                session.removeAttribute(AuthUtil.SESSION_ORDERS_FLASH);
            }
        }

        OrderDAO orderDAO = new OrderDAO();
        ArrayList<OrderHistoryRow> rows = orderDAO.listOrderHistoryRows(user.getUserId());
        request.setAttribute("orderRows", rows);

        request.getRequestDispatcher("/customer/orders.jsp").forward(request, response);
    }
}
