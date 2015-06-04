package forum.servlet;

import forum.dao.vo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import forum.dao.DaoFactory;

/**
 * Created by yangpeng on 4/7/15.
 */
@WebServlet(name = "doSignUp")
public class doSignUp extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("username");

        String password = request.getParameter("pwd1");

        User user = new User();
        user.setUsername(name);
        user.setPassword(password);
        try{
            DaoFactory.getUserDaoInstance().doInsert(user);}
        catch (Exception e){
            e.printStackTrace();
        }
        response.sendRedirect("index.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
