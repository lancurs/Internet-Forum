<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<% String admin = (String) session.getAttribute("admin"); %>

<%
    int pageSize = 20;

    String strPageNo = request.getParameter("pageNo");
    int pageNo;

    if (strPageNo == null || strPageNo.equals("")) {
        pageNo = 1;
    } else {
        try {
            pageNo = Integer.parseInt(strPageNo.trim());
        } catch (NumberFormatException e) {
            pageNo = 1;
        }
        if (pageNo <= 0)
            pageNo = 1;
    }

    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/bbs?user=root&password=1234";
    Connection conn = DriverManager.getConnection(url);

    Statement stmtCount = conn.createStatement();
    ResultSet rsCount = stmtCount.executeQuery("select count(*) from article where pid=0");
    rsCount.next();
    int totalRecords = rsCount.getInt(1);

    int totalPages = totalRecords % pageSize == 0 ? totalRecords / pageSize : totalRecords / pageSize + 1;

    int startPos = (pageNo - 1) * pageSize;

    if (pageNo > totalPages) pageNo = totalPages;

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM article WHERE pid = 0 order by pdate desc limit " + startPos + "," + pageSize);
%>


<!DOCTYPE HTML>
<html>
<head>
    <title>My JSP 'ShowArticleTree.jsp' starting page</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <style>
        table {
            margin-top: 60px;
            font-size: 16px;
        }

        #submit {
            margin-top: 10px;
        }

        #page {
            margin-top: 10px;
        }

        #user {
            font-color: #ffffff;
        }

        #dopost {
            margin-top: 20px
        }
    </style>

    <script type="text/javascript">
        function test() {
            var ss = document.getElementById("tst").value;
            var title = document.getElementById("title").value;
            if (ss.length < 5) {
                alert("The message you have entered is too short.");
                return false;
            } else if (title.length < 5) {
                alert("The title is too short");
                return false;
            }
            else {
                return true;
            }
        }
    </script>
</head>

<body>
<!--navbar-->
<%@include file="../navbar.jsp" %>
<!--navbar-->

<div class="col-md-10 col-md-offset-1">
    <div class=table-responsive>
        <table class="table table-hover">
            <thead>
            <div class="col-md-9">
                <th>
                    Title
                </th>
            </div>
            <div class="col-md-3">
                <th>Replies</th>
            </div>
            <th>Views</th>
            <th>Last posted by:</th>
            </thead>
            <tbody>
            <% while (rs.next()) { %>
            <tr>
                <td width="60%">
                    <a href="../threads.jsp?rootid=<%=rs.getInt("id") %>"><%=rs.getString("title") %>
                    </a>
                </td>
                <td width="10%"><%=rs.getInt("replies")%>
                </td>
                <td width="10%"><%=rs.getInt("views")%>
                </td>
                <td width="20%">
                    <%=rs.getString("pdate")%>
                </td>
            </tr>
            <%
                }
                rs.close();
                stmt.close();
                conn.close();
            %>
            </tbody>
        </table>
    </div>
    <div class="col-sm-2 col-sm-offset-5">
        Page <%=pageNo%> of <%=totalPages %>
        <a class="btn btn-danger btn-xs" href="index.jsp?pageNo=<%=pageNo-1%>" role="button">previous</a>
        <a class="btn btn-danger btn-xs" href="index.jsp?pageNo=<%=pageNo+1%>" role="button">next</a>

        <!--- Pages -->
        <form name="form1" action="index.jsp" id="page">
            <select name="pageNo" class="form-control" onchange="document.form1.submit()">
                <%
                    for (int i = 1; i <= totalPages; i++) {
                %>
                <option value=<%=i%> <%=(pageNo==i) ?"selected":""%>>page<%=i%>
                        <%} %>
            </select></form>
    </div>
    <br/>
    <br/>
    <br/>

    <!--- Pages -->
    <!--
        <form name="form2" action="index.jsp" class="col-sm-1" >
        <input type=text size=4 name="pageNo" value=<%=pageNo%>/>
        <input type="submit" value="go"/></form>-->

    <!-- new content -->
    <div id="dopost">
        <form id="post" action="doInsert" method="post" onsubmit="return test()">
            <input type="hidden" name="action" value="post">

            <div class="form-group">
                <label></label>
                <input type="text" class="form-control" name="title" placeholder="Title" id="title" required>
                <label></label>
            </div>
            <div class="form-group">
                <label></label>
                <textarea class="form-control col-sm-8" name="cont" rows="5" placeholder="New content" id="tst"
                          required></textarea>
                <br/>
            </div>
            <div class="form-group">

                <button id="submit" class="btn btn-success btn-lg">Post</button>

            </div>
        </form>
        <!-- new content -->

        <br/>
        <br/>
        <br/>
        <br/>
    </div>
</div>

</body>
</html>
