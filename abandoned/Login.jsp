<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<%
    String action = request.getParameter("action");
    if (action != null && action.equals("login")) {
        String username = request.getParameter("uname");
        String password = request.getParameter("pwd");
        if (username == null || !username.equals("admin")) {
%>
<font color="red" size=5>invalid username</font>

<%
        } else if (password == null || !password.equals("admin")) {
            out.println("invalid password");
            //return;
        } else {
            session.setAttribute("admin", "true");
            response.sendRedirect("ShowArticleTree.jsp");
        }
    }
%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>My JSP 'Login.jsp' starting page</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <style type="text/css">
        div#container {
            width: 1000px
        }

        div#header {
            background-color: #99bbbb;
            text-align: center;
        }

        div#menu {
            background-color: #ffff99;
            height: 200px;
            width: 0px;
        }

        div#content {
            background-color: #EEEEEE;
            height: 200px;
            width: 1000px;
        }

        div#footer {
            background-color: #99bbbb;
            clear: both;
            text-align: center;
        }

        div#table {
            position: relative;
            left: 40%;
            top: 30%;
            text-align: "center"
        }

        .submit {
            margin: 0px auto;
            position: absolute;
            left: 10%;
        }

        h1 {
            margin-bottom: 0;
        }

        h2 {
            margin-bottom: 0;
            font-size: 18px;
        }

        ul {
            margin: 0;
        }

        li {
            list-style: none;
        }
    </style>

</head>

<body>
<div id="container">

    <div id="header">
        <h1>Login</h1>
    </div>


    <div id="content">

        <div id="table">

            <form action="Login.jsp" method="post">
                <input type="hidden" name="action" value="login"/>
                <table border="1">
                    <tr>
                        <td><em>user name</em></td>
                        <td><input type="text" name="uname"/></td>
                    </tr>
                    <tr>
                        <td><em>password</em></td>
                        <td><input type="password" name="pwd"></td>
                    </tr>
                    <tr>
                </table>
                <br/>
                <input class="submit" type="submit" value="log in" align="absmiddle"/>


            </form>
        </div>
    </div>

    <div id="footer">Welcome</div>

</div>
</body>
</html>
