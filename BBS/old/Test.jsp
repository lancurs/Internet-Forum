    <%@ page language="java" contentType="text/html; charset=gbk"
             pageEncoding="gbk"%>
        <%@ page import="java.sql.*" %>
        <!DOCTYPE html>
        <html>
        <head lang="en">
        <meta charset="UTF-8">
        <title></title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <script>$('#exampleModal').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Button that triggered the modal
        var recipient = button.data('whatever'); // Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this);
        modal.find('.modal-title').text('New message to ' + recipient);
        modal.find('.modal-body input').val(recipient)})</script>
        </head>
        <body>
        <%="hello world"%>
        <%=request.getParameter("id");>%
        </body>