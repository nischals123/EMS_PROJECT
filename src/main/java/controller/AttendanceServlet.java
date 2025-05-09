package controller;

import dao.AttendanceDAO;
import model.Attendance;
import model.Employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private AttendanceDAO attendanceDAO;

    @Override
    public void init() throws ServletException {
        attendanceDAO = new AttendanceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Employee user = (session != null) ? (Employee) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/view/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("history".equals(action)) {
            getAttendanceHistory(request, response, user.getId());
        } else {
            showAttendancePage(request, response, user.getId());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Employee user = (session != null) ? (Employee) session.getAttribute("user") : null;

        if (user == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Not logged in");
            return;
        }

        String action = request.getParameter("action");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            boolean success = false;
            if ("markTimeIn".equals(action)) {
                success = attendanceDAO.markTimeIn(user.getId());
            } else if ("markTimeOut".equals(action)) {
                success = attendanceDAO.markTimeOut(user.getId());
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                return;
            }

            out.print("{\"success\":" + success + "}");
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\":false, \"error\":\"" + e.getMessage().replace("\"", "'") + "\"}");
        } finally {
            out.flush();
        }
    }

    private void showAttendancePage(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        Attendance todayAttendance = attendanceDAO.getTodayAttendance(userId);
        request.setAttribute("todayAttendance", todayAttendance);
        request.getRequestDispatcher("/view/attendance.jsp").forward(request, response);
    }

    private void getAttendanceHistory(HttpServletRequest request, HttpServletResponse response, int userId)
            throws IOException {
        String yearMonth = request.getParameter("yearMonth");
        List<Attendance> history = attendanceDAO.getAttendanceHistory(userId, yearMonth);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");

        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < history.size(); i++) {
            Attendance att = history.get(i);
  
            json.append("{")
                .append("\"date\":\"").append(att.getDate()).append("\",")
                .append("\"status\":\"").append(att.getStatus()).append("\",")
                .append("}");
            if (i < history.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        out.print(json.toString());
        out.flush();
    }
}
