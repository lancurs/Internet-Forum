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

/**
 * Created by yangpeng on 1/9/15.
 */
@WebServlet(name = "doReply")
public class doReply extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) return;

        request.setCharacterEncoding("UTF-8");
        int id = Integer.parseInt(request.getParameter("id"));
        int rootid = Integer.parseInt(request.getParameter("rootid"));
        String cont = request.getParameter("cont").trim();

        cont = cont.replaceAll("\n", "<br/>");
        Topic topic = new Topic();
        topic.setAuthor(user.getUsername());
        topic.setPid(id);
        topic.setRootid(rootid);
        topic.setCont(cont);

        try {
            DaoFactory.getTopicDaoInstance().doReply(topic);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("threads.jsp?rootid="+rootid);
    }
}
