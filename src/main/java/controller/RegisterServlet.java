package controller;

import java.io.IOException;
import java.sql.Date;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/register")
@MultipartConfig
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("========== REGISTRATION DEBUGGING ==========");
        System.out.println("RegisterServlet hit!");

        try {
            // Get form parameters
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            String departmentIdStr = request.getParameter("department");
            String roleIdStr = request.getParameter("role");

            // Log form data
            System.out.println("Form parameters received:");
            System.out.println("- Name: " + name);
            System.out.println("- Email: " + email);
            System.out.println("- Password: " + (password != null ? "[PROVIDED]" : "[NULL]"));
            System.out.println("- Phone: " + phone);
            System.out.println("- Department ID: " + departmentIdStr);
            System.out.println("- Role ID: " + roleIdStr);

            // Create and populate User object
            User user = new User();
            user.setName(name != null ? name.trim() : "");
            user.setEmail(email != null ? email.trim() : "");
            user.setPassword(password != null ? password.trim() : "");
            user.setPhone(phone != null ? phone.trim() : "");
            user.setPicturePath("user_photos/default.png");

            // Set department ID
            int departmentId = 1;
            try {
                if (departmentIdStr != null && !departmentIdStr.isEmpty()) {
                    departmentId = Integer.parseInt(departmentIdStr);
                }
            } catch (NumberFormatException e) {
                System.out.println("⚠️ Invalid department ID: " + e.getMessage());
            }
            user.setDepartmentId(departmentId);

            // Set role ID
            int roleId = 0;
            try {
                if (roleIdStr != null && !roleIdStr.isEmpty()) {
                    roleId = Integer.parseInt(roleIdStr);
                }
            } catch (NumberFormatException e) {
                System.out.println("⚠️ Invalid role ID: " + e.getMessage());
            }
            user.setRole(roleId);

            // Set other defaults
            user.setActive(true);
            user.setDeleted(false);
            user.setHireDate(new Date(System.currentTimeMillis()));

            // Attempt registration
            boolean registered = UserDAO.registerUser(user);
            System.out.println("✅ Registration result: " + (registered ? "SUCCESS" : "FAILED"));

            if (registered) {
                HttpSession session = request.getSession();
                session.setAttribute("successMessage", "Registration successful. Please login.");
                response.sendRedirect("view/login.jsp");
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("view/register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.out.println("❌ EXCEPTION OCCURRED: " + e.getClass().getName());
            System.out.println("Error message: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("error", "Something went wrong: " + e.getMessage());
            request.getRequestDispatcher("view/register.jsp").forward(request, response);
        }

        System.out.println("========== END DEBUGGING ==========");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to register.jsp when accessed via GET
        response.sendRedirect("view/register.jsp");
    }
}
