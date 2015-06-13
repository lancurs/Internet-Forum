
<%@ page import="forum.dao.vo.*" %>
<%@ page import="forum.dao.*" %>
<% request.setCharacterEncoding("UTF-8");%>
<%
    String name = request.getParameter("username");

    String password = request.getParameter("pwd1");

    User user = new User();
    user.setUsername(name);
    user.setPassword(password);
    try{
    DaoFactory.getDaoInstance().doInsert(user);}
    catch (Exception e){
        e.printStackTrace();
    }
    response.sendRedirect("index.jsp");

%>
