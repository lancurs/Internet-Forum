<%@ page import="forum.dao.vo.*" %>
<%@ page import="forum.dao.DaoFactory" %>
<%@ page import="forum.dao.UserDao" %>
<% request.setCharacterEncoding("UTF-8");%>
<%
    String name = request.getParameter("username");

    String password = request.getParameter("password");

    UserDao userDao = DaoFactory.getDaoInstance();
    User user = userDao.findByName(name);
    if (user != null && user.getPassword().equals(password)) {
        session.setAttribute("user", user);
    }
    response.sendRedirect("index.jsp");


%>