package forum.servlet;

import forum.dao.DaoFactory;
import forum.dao.vo.Topic;
import forum.dao.vo.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by yangpeng on 1/8/15.
 */
@WebServlet(name = "doInsert")
public class doInsert extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        if (action != null) {

            User user = (User) request.getSession().getAttribute("user");

            if (user == null) {
                response.sendRedirect("index.jsp");
            } else {
                String title = request.getParameter("title");
                String cont = request.getParameter("cont");
                String author = user.getUsername();


                cont = cont.replaceAll("\n", "<br>");
                Topic topic = new Topic();
                topic.setTitle(title);
                topic.setCont(cont);
                topic.setAuthor(author);
                try {
                    DaoFactory.getTopicDaoInstance().doInsert(topic);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                response.sendRedirect("index.jsp");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
