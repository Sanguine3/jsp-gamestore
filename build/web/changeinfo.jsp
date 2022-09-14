<%-- 
    Document   : changeinfo
    Created on : Jul 19, 2022, 6:17:56 PM
    Author     : 5555
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Notification</title>
        <style>
            body {
                background-image: url("https://wallpaperaccess.com/full/2329697.jpg");

                background-size: cover;
                background-repeat: no-repeat;
            }
            .no-background {
                background-image: url("images/blank.jpg");
            }
            .center {
                margin-left: auto;
                margin-right: auto;
            }
        </style>
    </head>
    <body>
        <h1 style="text-align:center; color: white; text-shadow: 2px 2px #ff0000">Attention, user!</h1>
        <br/>
        <p style="text-align:center; font-size:140%; color: white; text-shadow: 1px 1px black">Your information had been changed successfully, all account logged out.</p>
        <br/>
        
        <table class="center">
            <tr>
                <td><a class="btn btn-success" href="login.jsp" role="button">Click here to login again</a></td>
                <td><a class="btn btn-warning" href="home" role="button">Click here to go back to the HomePage</a></td>                
            </tr>
        </table>
       
        
        
    </body>
</html>
