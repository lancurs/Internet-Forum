package forum.servlet;

import forum.dao.DaoFactory;
import forum.dao.UserDao;
import forum.dao.vo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by yangpeng on 4/7/15.
 */
@WebServlet(name = "doSignIn")
public class doSignIn extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String name = request.getParameter("username");
        String password = request.getParameter("password");
        UserDao userDao = DaoFactory.getUserDaoInstance();
        User user = null;
        try {
            user = userDao.findByName(name);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("user", user);
        }
        response.sendRedirect("index.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
