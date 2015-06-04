<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<% //<jsp:useBean id="admin" class="String" scope="session"/> 
    //从sesiion里找名字是admin的对象,类型是String,如没有则创建 %>

<%!
    private void del(Connection conn, int id) {
        Statement stmt = null;
        ResultSet rs = null;
        try {
            stmt = conn.createStatement();
            String sql = "select * from article where pid=" + id;
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                del(conn, rs.getInt("id"));

            }
            stmt.executeUpdate("delete from article where id=" + id);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                    rs = null;
                }

                if (stmt != null) {
                    stmt.close();
                    stmt = null;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } %>

<% String admin = (String) session.getAttribute("admin");
    if (admin == null || !admin.equals("true")) {
        out.println("unauthorized");
        return;
    }


%>

<% int id = Integer.parseInt(request.getParameter("id"));
    int pid = Integer.parseInt(request.getParameter("pid"));


    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/bbs?user=root&password=1234";
    Connection conn = DriverManager.getConnection(url);

    conn.setAutoCommit(false);

    del(conn, id);

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("select count(*) from article where pid=" + pid);
    rs.next();
    int count = rs.getInt(1);
    rs.close();
    stmt.close();


    if (count <= 0) {
        Statement stmtUpdate = conn.createStatement();
        stmtUpdate.executeUpdate("UPDATE article SET isleaf=0 WHERE id=" + pid);
        stmtUpdate.close();
    }

    conn.commit();
    conn.setAutoCommit(true);
    conn.close();

    response.sendRedirect("ShowArticleTree.jsp");
%>



