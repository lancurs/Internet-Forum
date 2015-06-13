<%@ page language="java" import="forum.dao.DaoFactory" pageEncoding="UTF-8" %>
<%@ page import="forum.dao.vo.Topic" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>


<% int rid = Integer.parseInt(request.getParameter("rootid"));%>
<%
    Topic topic = new Topic();

    try {
        topic = DaoFactory.getTopicDaoInstance().getTopicByID(rid);
    }catch (Exception e)
    {
        e.printStackTrace();
    }

    out.print("<b>title:"+topic.getTitle()+"</b>");
    out.print("</br>");
    out.print("content:"+topic.getCont()+"</br>");



%>


