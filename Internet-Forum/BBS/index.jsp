<%@ page language="java" import="forum.dao.DaoFactory" pageEncoding="UTF-8" %>
<%@ page import="forum.dao.vo.Topic" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<% String admin = (String) session.getAttribute("admin"); %>

<%
    List topics = new ArrayList();

    try {
        topics = DaoFactory.getTopicDaoInstance().showTopics();
    } catch (Exception e) {
        e.printStackTrace();
    }

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

    int totalRecords = topics.size();
    int totalPages = totalRecords % pageSize == 0 ? totalRecords / pageSize : totalRecords / pageSize + 1;

    int startPos = (pageNo - 1) * pageSize;

    if (pageNo > totalPages) pageNo = totalPages;


%>


<!DOCTYPE HTML>
<html>
<head>
    <title>Project Demo</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <script src="js/script.js"></script>

</head>

<body>
<!--navbar-->
<%@include file="navbar.jsp" %>
<!--navbar-->

<div class="col-sm-10 col-sm-offset-1">
    <div class=table-responsive>
        <table class="table table-hover" style="font-size: 14px">
            <thead>

            <th>
                Title
            </th>

            <th align="center">Views/Replies</th>
            <th>Last posted by:</th>
            </thead>
            <tbody>
            <%
                for (int i = startPos; i < totalRecords; i++) {
                    Topic topic = (Topic) topics.get(i);
            %>
            <tr>
                <td width="60%">
                    <a href="threads.jsp?rootid=<%=topic.getId() %>"><%=topic.getTitle() %>
                    </a>
                </td>
                <td width="15%" align="center"><%=topic.getViews()%>
                    /
                    <%=topic.getReplies()%>
                </td>
                <td width="25%">
                    <i> <b><%=topic.getAuthor() + ":  "%>
                    </b><%=topic.getPdate()%>
                    </i>
                </td>
            </tr>
            <%

                }
                topics = null;
            %>
            </tbody>
        </table>
    </div>

    <div class="col-sm-2 col-sm-offset-5" style="align:center">
        Page <%=pageNo%> of <%=totalPages %><br/>


        <% if(pageNo>1) { %>
        <a class="btn btn-primary btn-xs" href="index.jsp?pageNo=<%=pageNo-1%>" role="button">previous</a>
        <%}%>
        <% if(pageNo<totalPages){  %>

        <a class="btn btn-primary btn-xs" href="index.jsp?pageNo=<%=pageNo+1%>" role="button">next</a>

        <%}%>
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
