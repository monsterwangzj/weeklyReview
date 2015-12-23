<%@ page contentType="text/html;charset=GBK" language="java" %>
<html>
<body>
<h1>工作日报</h1>

<head>
<script src="js/jquery.min.js"></script>
<script src="js/jRate.js"></script>

<script type="text/javascript">
    $(function () {
        var that = this;
        var options = {
            rating: 0,
            strokeColor: 'black',
            precision: 0.5,
            minSelected: 0,
            onChange: function(rating) {
                console.log("OnChange: Rating: "+rating);
            },
            onSet: function(rating) {
                console.log("OnSet: Rating: "+rating);
            }
        };

        var toolitup = $("#jRate").jRate(options);
        var toolitup2 = $("#jRate2").jRate(options);
        var toolitup3 = $("#jRate3").jRate(options);

        $('#btn-click').on('click', function() {
            toolitup.setRating(0);
        });
        $('#btn-click2').on('click', function() {
            toolitup2.setRating(0);
        });
        $('#btn-click3').on('click', function() {
            toolitup3.setRating(0);
        });
    });
</script>

</head>

<table border="1">
    <caption><h3>12.23日报</h3></caption>
    <tr>
        <td colspan="2">1, 今日重点工作+</td>
    </tr>
    <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="text" size="60"/>
        </td>
        <td>
            <div id="jRate" style="height:30px;width: 200px;"></div>
            <button id="btn-click" >重置</button>
        </td>
    </tr>

    <tr>
        <td colspan="2">2, 今日其它工作+</td>
    </tr>
    <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="text" size="60"/>
        </td>
        <td>
            <div id="jRate2" style="height:30px;width: 200px;"></div>
            <button id="btn-click2" >重置</button>
        </td>
    </tr>

    <tr>
        <td colspan="2">3, 下周工作计划+</td>
    </tr>
    <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="text" size="60"/>
        </td>
        <td>
            <div id="jRate3" style="height:30px;width: 200px;"></div>
            <button id="btn-click3" >重置</button>
        </td>
    </tr>

    <tr>
        <td colspan="2">4, 我的思考+</td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;
            <textarea rows="4" cols="92"></textarea>
        </td>
    </tr>

</table>

</body>
</html>
