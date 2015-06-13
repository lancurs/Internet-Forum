package forum.servlet;

import forum.dao.DaoFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by yangpeng on 1/2/15.
 */
@WebServlet(name = "showContents")
public class showContents extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List topics = new ArrayList();
        int rootid = Integer.parseInt(request.getParameter("rootid"));
        try{
            topics= DaoFactory.getTopicDaoInstance().showContents(rootid);}
        catch (Exception e){
            e.printStackTrace();
        }
        finally {
            request.setAttribute("topics", topics);
            response.sendRedirect("index.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
