<%@ page language="java" contentType="text/html; charset=gbk"
         pageEncoding="gbk" %>
<%@ page import="java.sql.*" %>

<%

    request.setCharacterEncoding("utf-8");
    String action = request.getParameter("action");
    if (action != null && action.equals("post")) {
        String title = request.getParameter("title");
        String cont = request.getParameter("cont");

        cont = cont.replaceAll("\n", "<br>");

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost/bbs?user=root&password=1234";
        Connection conn = DriverManager.getConnection(url);

        conn.setAutoCommit(false);

        String sql = "INSERT INTO article values (null, 0, ?,0,0,null, ?, ?, now(), 0)";
        PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        Statement stmt = conn.createStatement();

        pstmt.setInt(1, -1);
        pstmt.setString(2, title);
        pstmt.setString(3, cont);
        pstmt.executeUpdate();

        ResultSet rsKey = pstmt.getGeneratedKeys();
        rsKey.next();
        int key = rsKey.getInt(1);
        rsKey.close();
        stmt.executeUpdate("update article set rootid = " + key + " where id = " + key);

        conn.commit();
        conn.setAutoCommit(true);

        stmt.close();
        pstmt.close();
        conn.close();

        response.sendRedirect("index.jsp");
    }
%>
