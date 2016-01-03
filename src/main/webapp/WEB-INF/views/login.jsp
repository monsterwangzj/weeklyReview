<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<body>
<h1 align="center">小码日报</h1>
<head>
    <script src="js/jquery.min.js"></script>
</head>
<form action="/user/signin.htmls" method="post">
    <table border="1" align="center">
        <tr>
            <td>用户名:</td>
            <td><input type="text" id="username" name="username"></td>
        </tr>

        <tr>
            <td>密码:</td>
            <td><input type="password" id="password" name="password"></td>
        </tr>

        <tr>
            <td colspan="2" align="right"><input type="submit" id="submit" value="登录"></td>
        </tr>
    </table>
</form>
</body>
</html>