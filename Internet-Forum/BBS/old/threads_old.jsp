<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<%!
    int rid = 0;
    String str = "";

    private void tree(Connection conn, int id) {
        Statement stmt = null;
        ResultSet rs = null;

        try {
            stmt = conn.createStatement();
            String sql = "SELECT * FROM article WHERE id=" + id;
            rs = stmt.executeQuery(sql);
            String strLogin = "";
            while (rs.next()) {
                str += "<ul><li>" + rs.getString("cont") + "</li></ul>";
            }
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

<% int rid = Integer.parseInt(request.getParameter("rootid"));%>
<%
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost/bbs?user=root&password=1234";
    Connection conn = DriverManager.getConnection(url);


    Statement stmt = conn.createStatement();
    stmt.executeUpdate("UPDATE article SET views=views+1 WHERE id=" + rid);
    ResultSet rs = stmt.executeQuery("select * from article where rootid=" + rid);
    while (rs.next()) {
        str += "<li>" + rs.getString("cont");

        if (rs.getInt("pid") != rs.getInt("rootid")) {
            tree(conn, rs.getInt("pid"));
        }
        if (rs.getInt("pid") != 0)
            str += "<br/><button type='button' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#myModal' data-whatever='" + rs.getInt("id") + "'>Reply</button>";
        str += "<div id=\"author\"><nobr><b>"+rs.getString("author")+"</b></nobr></div></li>";
    }

    //<button type='button' class='btn btn-primary btn-xs' data-toggle="modal" data-target="#myModal" data-whatever="@mddo">Reply</button>


    rs.close();
    stmt.close();
    conn.close();


%>

<head>
    <title>My JSP 'ShowArticleTree.jsp' starting page</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-COMPATIBLE" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <script src="js/jquery-2.1.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function test() {
            var ss = document.getElementById("tst").value;
            if (ss.length < 10) {
                alert("The message you have entered is too short.");
                return false;
            } else {
                return true;
            }
        }

        $("#myModal").on("show.bs.modal", function (e) {
            var button = $(e.relatedTarget);
            var recipient = button.data("whatever");
            var modal = $(this);
            modal.find('.modal-title').text('New message to ' + recipient);
            modal.find('.modal-body textarea').val(recipient)
        })

    </script>
    <style>
        table {
            margin-top: 60px;
        }

        #reply {
            margin-top: 10px;
        }

        #tl {
            padding: 10px;
        }
        #author{
            test-align:right;
        }
    </style>
</head>

<body>
<!--navbar-->
<%@include file="navbar.jsp" %>


<!--  MAIN CONTENT -->

<div class="col-md-10 col-md-offset-1">
    <div class=table-responsive>
        <table class="table table-hover" width="760px">


            <div class="col-md-8 col-md-offset-2">
                <ul id="tl">
                    <%=str%>
                    <% str = ""; %>
                </ul>
            </div>
            </tbody>
        </table>
    </div>

    <!--  MAIN CONTENT -->

    <br/>
    <!--
    <form name="form2" action="index.jsp" class="col-sm-1" >
    <input type=text size=4 name="pageNo" value=/>
    <input type="submit" value="go"/>-->

    <!-- new content -->

    <!-- new content -->
    <!-- Reply.start-->
    <br/>
    <br/>
    <br/>
    <br/>

    <form action="ReplyOK.jsp" method="post" onsubmit="return test()">
        <input type="hidden" name="action" value="post">
        <input type="hidden" name="rootid" value=<%=rid %>>
        <input type="hidden" name="id" value=<%=rid%>>

        <div class="form-group">
            <label></label>
            <textarea id="tst" class="form-control col-sm-8" name="cont" rows="5" placeholder="New content"
                      required></textarea>
            <br/>
        </div>

        <div class="form-group">
            <button type="submit" class="btn btn-success btn-lg pull-right" value="Reply" id="reply">Reply</button>
        </div>
    </form>
</div>

<!--Reply.end-->


<!--Model.start-->

<div class="modal fade" id="myModal" role="dialog" aria-label="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">Reply</h4>
            </div>
            <form action="ReplyOK.jsp" method="get">
                <div class="modal-body">

                    <input type="hidden" class="pid" name="id" value="">
                    <input type="hidden" name="action" value="post">
                    <input type="hidden" name="rootid" value=<%=rid %>>

                    <div class="form-group">
                        <label for="message-text" class="control-label">Message:</label>
                        <textarea class="form-control" id="message-text" name="cont" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button id="button" class="btn btn-primary">Reply</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!--Model.end-->

<!--Model.jquery.start-->
<script>$('#myModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget); // Button that triggered the modal
    var recipient = button.data('whatever'); // Extract info from data-* attributes
    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
    var modal = $(this);
    modal.find('.modal-title').text('New message to ' + recipient);
    modal.find('.modal-body input:first').val(recipient)
})</script>
<!--Model.jquery.end-->
</body>
</html>
