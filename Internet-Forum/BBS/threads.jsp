<%@ page language="java" import="forum.dao.DaoFactory" pageEncoding="UTF-8" %>
<%@ page import="forum.dao.vo.Topic" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>


<!DOCTYPE HTML>
<html>


<% int rid = Integer.parseInt(request.getParameter("rootid"));%>


<%

    List replies = new ArrayList();

    try {
        replies = DaoFactory.getTopicDaoInstance().showContents(rid);
    } catch (Exception e) {
        e.printStackTrace();
    }
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
    <style type="text/css">
        table {
            margin-top: 60px;
        }

        #reply {
            margin-top: 10px;
        }

        #tl {
            padding: 10px;
        }

    </style>
</head>

<body>
<!--navbar-->
<%@include file="navbar.jsp" %>


<!--  MAIN CONTENT -->

<div class="col-md-10 col-md-offset-1">
    <div class="table-responsive col-md-8 col-md-offset-2">
        <table class="table table-hover" width="760px">


            <% Topic thread = (Topic) replies.get(0);%>


            <ul id="tl">

                <li>
                    <b><%= thread.getTitle()%>
                    </b>
                    <br/>

                    <div style="margin-top: 10px">
                        <%=thread.getCont()%>
                        <br/>

                        &nbsp;
                    <span style="float:right">
                                <b>


                                    posted by:
                                    <i>
                                        <%= thread.getAuthor()%>
                                    </i>
                                </b>
                            :
                            <%=thread.getPdate()%>
                    </div>
                    </span>
                </li>


                <%
                    for (int i = 1; i < replies.size(); i++) {
                        Topic reply = (Topic) replies.get(i);
                %>
                <li>
                    <%=reply.getCont()%>
                    <%
                        if (reply.getPid() != rid && reply.getPid() != 0) {
                            Topic topic = new Topic();
                            try {
                                int id = reply.getPid();
                                topic = DaoFactory.getTopicDaoInstance().getTopicByID(id);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                    %>
                    <ul style="margin-top: 10px">
                        <li>
                            <b>
                                <i>
                                    Originally Posted by:</i><%=topic.getAuthor()%>
                            </b>

                            <div class="test">
                                <%=topic.getCont()%>
                            </div>
                        </li>
                    </ul>

                    <%
                        }

                    %>
                    <br/>

                    <div style="margin-top: 5px">
                        <button type='button' class='btn btn-primary btn-xs' data-toggle='modal'
                                data-target='#myModal'
                                data-whatever='<%= reply.getId() %>'>Reply
                        </button>
                            <span style="float:right">
                                <b>


                                    posted by:
                                    <i>
                                        <%= reply.getAuthor()%>
                                    </i>
                                </b>
                            :
                            <%=reply.getPdate()%>
                            </span>
                    </div>
                </li>
                <% }

                    replies = null;//release RAM
                %>
            </ul>
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

    <form action="doReply" method="post" onsubmit="return test()">
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
            <button type="submit" class="btn btn-success btn-lg pull-right" value="Reply" id="reply"
                    style="margin-bottom:40px ">Reply
            </button>
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
            <form action="doReply" method="post">
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
