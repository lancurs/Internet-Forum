<%@ page import="forum.dao.vo.User" %>
<!--navbar-->
<nav class="navbar navbar-inverse navbar-static-top">

    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.jsp">Home</a>
        </div>
        <div class=col-md-offset-10 id="user">
            <!--<a class="navbar-brand" href="#">Welcome</a>-->
        </div>
        <div id="navbar" class="navbar-collapse collapse">

            <%if(session.getAttribute("user")==null){%>
            <!-- username and password -->
            <%@include file="login.html"%>
            <%}else{%>

            <div class="dropdown navbar-right">

               <!-- <button id="dLabel" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <% User user=(User)session.getAttribute("user");%>

                    <span class="caret"></span>
                </button>-->
                <ul class="nav navbar-nav">
                    <!--<li class="active"><a href="#">Home</a></li>-->

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><img src="img/avatar.jpg" width="17px" height="17px"/>&nbsp;&nbsp;&nbsp;<%=user.getUsername()%> <span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="signOut">Sign Out</a></li>
                            <!--
                            <li><a href="#">Another action</a></li>
                            <li><a href="#">Something else here</a></li>
                            <li class="divider"></li>
                            <li class="dropdown-header">Nav header</li>
                            <li><a href="#">Separated link</a></li>
                            <li><a href="#">One more separated link</a></li>-->
                        </ul>
                    </li>
                </ul>
            </div>

            <%}%>

            <!--<form class="navbar-form navbar-right" action="dosignin.jsp" method="get">
                <div class="form-group">
                    <input type="text" name="username" placeholder="Username" class="form-control">
                </div>
                <div class="form-group">
                    <input type="password" name="password" placeholder="Password" class="form-control">
                </div>
                <button type="submit" class="btn btn-success">Sign in</button>
                <button type="button" class="btn btn-primary" data-toggle='modal' data-target='#signup'>Sign up</button>
            </form>%>-->


        </div><!--/.navbar-collapse-->
    </div>
</nav>

<!--<h2 class="h2" align="center">Welcome!!!!</h2>-->

<script>
    function reg(){
        var name = document.reg.username.value;
        var pass = document.reg.pwd1.value;
        var pass2 = document.reg.pwd2.value;
        if(name=="" || name==null || name.length<4){
            alert("The user name is too short");
            return false;
        }else if(pass=="" || pass==null || pass.length<5){
            alert("The password is too short");
            return false;
        }else if(pass!=pass2){
            alert("These passwords don't match.");
            return false;
        }else{
            return true;
        }

    }
</script>
<!--Modal-->
<script src="js/jquery-2.1.3.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<div class="modal fade bs-example-modal-sm" id="signup" role="dialog" aria-label="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">Sign up</h4>
            </div>
            <form name="reg" action="doSignUp" method="post" onsubmit="return reg()">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="message-user" class="control-label">Username</label>
                        <input type="text" class="form-control" id="message-user" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="message-pwd" class="control-label">Password</label>
                        <input type="password" class="form-control" id="message-pwd" name="pwd1" required>
                    </div>
                    <div class="form-group">
                        <label for="message-cfpwd" class="control-label">Confirm Password</label>
                        <input type="password" class="form-control" id="message-cfpwd" name="pwd2" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button id="button" class="btn btn-primary">Sign Up</button>
                </div>
            </form>
        </div>
    </div>
</div>
