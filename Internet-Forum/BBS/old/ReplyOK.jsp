<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="forum.dao.vo.User" %>
<%
	request.setCharacterEncoding("UTF-8");
    User user = (User) request.getSession().getAttribute("user");
    if(user==null) return;
	int id=Integer.parseInt(request.getParameter("id"));
	int rootid=Integer.parseInt(request.getParameter("rootid"));
	String cont=request.getParameter("cont");
	
	cont=cont.replaceAll("\n", "<br/>");
	
	
	
	Class.forName("com.mysql.jdbc.Driver");
    String url="jdbc:mysql://localhost/bbs?user=root&password=1234";
    Connection conn=DriverManager.getConnection(url);
    
    conn.setAutoCommit(false);
    
    
    String sql="INSERT INTO article VALUES(null,?,?,0,0,?,null,?,now(),0) ";
    PreparedStatement pstmt=conn.prepareStatement(sql);
    Statement stmt=conn.createStatement();
    pstmt.setInt(1,id);
    pstmt.setInt(2,rootid);
    pstmt.setString(3, user.getUsername());
    pstmt.setString(4,cont);
    pstmt.executeUpdate();
    stmt.executeUpdate("UPDATE article SET isleaf=1 WHERE id=" + id);
    
    conn.commit();
    conn.setAutoCommit(true);
    
    stmt.close();
    pstmt.close();
    conn.close();
    
    response.sendRedirect("threads.jsp?rootid="+rootid);
%>
