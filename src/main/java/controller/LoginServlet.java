package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

import dao.UserDAO;

@WebServlet("/login")  // This handles requests to /login
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ✅ Use forward to load login.jsp correctly
        request.getRequestDispatcher("/view/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        // Validate user credentials
        User user = UserDAO.validateUser(email, password);

        if (user != null && user.isActive()) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes session timeout
            
            // Redirect based on role
            if (user.getRole() == 1) {
                response.sendRedirect("view/admin/dashboard.jsp");
            } else {
                response.sendRedirect("view/user/index.jsp");
            }

        } else {
            // Failed login
            request.setAttribute("error", "Invalid credentials or user is inactive.");
            request.getRequestDispatcher("/view/login.jsp").forward(request, response); // ✅ Correct forward
        }
    }
}
