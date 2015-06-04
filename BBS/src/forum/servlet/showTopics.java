package forum.servlet;

import forum.dao.DaoFactory;
import forum.dao.TopicDao;
import forum.dao.vo.Topic;
import forum.dao.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by yangpeng on 4/9/15.
 */
@WebServlet(name = "showTopics")
public class showTopics extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List topics = new ArrayList();
      try{
        topics=DaoFactory.getTopicDaoInstance().showTopics();}
        catch (Exception e){
            e.printStackTrace();
        }
        finally {
          request.setAttribute("topics",topics);
          response.sendRedirect("index.jsp");
      }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doPost(request,response);
    }
}
