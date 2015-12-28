<%@ page import="com.tnt.weeklyreview.model.Task" %>
<%@ page import="org.springframework.util.CollectionUtils" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<h1>工作日报</h1>

<%
List<Task> vipTasks = (List<Task>) request.getAttribute("vipTasks");
Integer vipNum = 1;
if (!CollectionUtils.isEmpty(vipTasks)) {
    vipNum = vipTasks.size();
}

List<Task> otherTasks = (List<Task>) request.getAttribute("otherTasks");
Integer otherNum = 1;
if (!CollectionUtils.isEmpty(otherTasks)) {
    otherNum = otherTasks.size();
}

List<Task> nextWeekTasks = (List<Task>) request.getAttribute("nextWeekTasks");
Integer nextWeekNum = 1;
if (!CollectionUtils.isEmpty(nextWeekTasks)) {
    nextWeekNum = nextWeekTasks.size();
}

List<Task> myThinkTasks = (List<Task>) request.getAttribute("myThinkTasks");
Integer myThinkNum = 1;
if (!CollectionUtils.isEmpty(myThinkTasks)) {
    myThinkNum = myThinkTasks.size();
}

System.out.println(vipTasks);
%>


<head>
<script src="js/jquery.min.js"></script>
<script src="js/jRate.js"></script>
<script src="js/user_index.js"></script>

<script type="text/javascript">
    $(function () {
        var toolitup2 = $("#jRate2").jRate(options);
        var toolitup3 = $("#jRate3").jRate(options);

        $('#btn-click2').on('click', function() {
            toolitup2.setRating(0);
        });
        $('#btn-click3').on('click', function () {
            toolitup3.setRating(0);
        });

        // 今日重点工作btn click

        var vipNum = <%=vipNum%>;
        var lastTrId = "vip-tr" + vipNum;
        $('#vip-taskBtn').on('click', function () {
            console.log("vip task is clicked.");
            vipNum++;
            var textId = "vip-text" + vipNum;
            var jRateId = "vip-jRate" + vipNum;
            var buttonId = "vip-btn-click" + vipNum;
            var trid = "vip-tr" + vipNum;
            var starId = "vip-star" + vipNum;
            var content = "<tr id='" + trid + "'> <td>&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' size='60' id='" + textId +"'/> </td> <td><div id='" + jRateId + "' style='height:30px;width: 100px;float:left'></div><button id='" + buttonId + "' style='margin-left: 20px'>重置</button><input type='hidden' id='" + starId + "' value='0'/></td><td><button id='vip-btn-delete1' style='margin-left: 20px'>删除</button> </td></tr>";
            $("#"+lastTrId).after(content);
            lastTrId = trid;

            options.onSet = function(rating) {
                $("#" + starId).val(rating);
            };
            var toolitup = $("#" + jRateId).jRate(options);
            $("#" + buttonId).on('click', function () {
                toolitup.setRating(0);
            });
        });

        $('#finish').on('click', function () {
            finishOnClicked(vipNum);
        });
    });
</script>

</head>

<table border="1">
    <caption><h3>12.23日报</h3></caption>
    <tr>
        <td colspan="3">
            <div>
                <span style="vertical-align: middle">1, 今日重点工作</span>
                <img id="vip-taskBtn" src="/img/add.jpg" alt="点击添加一项" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
            </div>
        </td>
    </tr>
    <% if (CollectionUtils.isEmpty(vipTasks)) {%>
        <tr id="vip-tr1">
            <td>&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="text" size="60" id="vip-text1"/>
            </td>
            <td>
                <div id="vip-jRate1" style="height:30px;width: 100px;float:left"></div>
                <button id="vip-btn-click1" style="margin-left: 20px">重置</button>
                <input id="vip-star1" type="hidden" value="0"/>
            </td>
            <td>
                <button id="vip-btn-delete1" style="margin-left: 20px" disabled>删除</button>
            </td>
        </tr>
        <script type="text/javascript">
            vipFunc(1, 'vip-jRate1', 'vip-star1',0,
                    'vip-btn-click1', 'vip-btn-delete1', 'vip-tr1', '');
        </script>

    <% } else {
        for (int i = 1; i<= vipTasks.size(); i++) {
            Task task = vipTasks.get(i-1);
            String content = task.getTask();
            float rateValue = task.getRate();
            Long taskId = task.getId();

            String trId = "vip-tr" + i;
            String vipRateId = "vip-jRate" + i;
            String vipStarId = "vip-star" + i;
            String vipButtonId = "vip-btn-click" + i;
            Long hiddenTid = taskId;
            String hiddenInputTid = "id" + i;
            String deleteId = "vip-deleteId" + i;
            %>
            <tr id="<%=trId%>">
                <td>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="text" size="60" id="vip-text<%=i%>" value="<%=content%>"/>
                </td>
                <td>
                    <div id="<%=vipRateId%>" style="height:30px;width: 100px;float:left"></div>
                    <button id="<%=vipButtonId%>" style="margin-left: 20px">重置</button>
                    <input id="<%=vipStarId%>" type="hidden" value="<%=rateValue%>"/>
                    <input id="<%=hiddenInputTid%>" type="hidden" value="<%=hiddenTid%>"/>
                </td>
                <td>
                    <button id="<%=deleteId%>" style="margin-left: 20px">删除</button>
                </td>
            </tr>
            <script type="text/javascript">
                vipFunc(<%=vipNum%>, '<%=vipRateId%>', '<%=vipStarId%>',  <%=rateValue%>, '<%=vipStarId%>',
                        '<%=vipButtonId%>', '<%=deleteId%>', '<%=trId%>', '<%=taskId%>');
            </script>
        <%
        }
    }%>



    <tr>
        <td colspan="3">2, 今日其它工作<img id="vip-taskBtn2" src="/img/add.jpg" alt="点击添加一项" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/></td>
    </tr>
    <% if (CollectionUtils.isEmpty(otherTasks)) {%>
        <tr>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;
                <input id="other-text1" type="text" size="60"/>
            </td>
            <td>
                <div id="other-jRate1" style="height:30px;width: 100px;float:left"></div>
                <button id="other-btn-reset1" style="margin-left: 20px">重置</button>
                <input id="other-star1" type="hidden" value="0"/>
            </td>
            <td>
                <button id="other-btn-delete1" style="margin-left: 20px" disabled>删除</button>
            </td>
        </tr>
        <script type="text/javascript">
            vipFunc(1, 'other-jRate1', 'other-star1',0,
                    'other-btn-click1', 'other-btn-delete1', 'other-tr1', '');
        </script>
    <% } else {
        for (int i = 1; i<= otherTasks.size(); i++) {
            Task task = otherTasks.get(i-1);
            String content = task.getTask();
            float rateValue = task.getRate();
            Long taskId = task.getId();

            String prefix = "other";
            String trId = prefix + "-tr" + i;
            String vipRateId = prefix+ "-jRate" + i;
            String vipStarId = prefix + "-star" + i;
            String vipButtonId = prefix + "-btn-click" + i;
            Long hiddenTid = taskId;
            String hiddenInputTid = "id" + taskId;
            String deleteId = prefix + "-deleteId" + i;
            %>
            <tr id="<%=trId%>">
                <td>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="text" size="60" id="<%=prefix%>-text<%=i%>" value="<%=content%>"/>
                </td>
                <td>
                    <div id="<%=vipRateId%>" style="height:30px;width: 100px;float:left"></div>
                    <button id="<%=vipButtonId%>" style="margin-left: 20px">重置</button>
                    <input id="<%=vipStarId%>" type="hidden" value="<%=rateValue%>"/>
                    <input id="<%=hiddenInputTid%>" type="hidden" value="<%=hiddenTid%>"/>
                </td>
                <td>
                    <button id="<%=deleteId%>" style="margin-left: 20px">删除</button>
                </td>
            </tr>
            <script type="text/javascript">
                vipFunc(<%=otherTasks.size()%>, '<%=vipRateId%>', '<%=vipStarId%>', '<%=rateValue%>',
                        '<%=vipButtonId%>', '<%=deleteId%>', '<%=trId%>', '<%=taskId%>');
            </script>
            <%
        }
    }%>




    <tr>
        <td colspan="3">3, 下周工作计划<img id="nextWeek-taskBtn2" src="/img/add.jpg" alt="点击添加一项" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/></td>
    </tr>
    <% if (CollectionUtils.isEmpty(nextWeekTasks)) {%>
    <tr>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;
            <input id="nextWeek-text1" type="text" size="60"/>
        </td>
        <td>
            <div id="nextWeek-jRate1" style="height:30px;width: 100px;float:left"></div>
            <button id="nextWeek-btn-reset1" style="margin-left: 20px">重置</button>
            <input id="nextWeek-star1" type="hidden" value="0"/>
        </td>
        <td>
            <button id="nextWeek-btn-delete1" style="margin-left: 20px" disabled>删除</button>
        </td>
    </tr>
    <script type="text/javascript">
        vipFunc(1, 'nextWeek-jRate1', 'nextWeek-star1',0,
                'nextWeek-btn-click1', 'nextWeek-btn-delete1', 'nextWeek-tr1', '');
    </script>
    <% } else {
        for (int i = 1; i<= nextWeekTasks.size(); i++) {
            Task task = nextWeekTasks.get(i-1);
            String content = task.getTask();
            float rateValue = task.getRate();
            Long taskId = task.getId();

            String prefix = "nextWeek";
            String trId = prefix + "-tr" + i;
            String vipRateId = prefix+ "-jRate" + i;
            String vipStarId = prefix + "-star" + i;
            String vipButtonId = prefix + "-btn-click" + i;
            Long hiddenTid = taskId;
            String hiddenInputTid = "id" + i;
            String deleteId = prefix + "-deleteId" + i;
    %>
    <tr id="<%=trId%>">
        <td>&nbsp;&nbsp;&nbsp;&nbsp;
            <input type="text" size="60" id="nextWeek-text<%=i%>" value="<%=content%>"/>
        </td>
        <td>
            <div id="<%=vipRateId%>" style="height:30px;width: 100px;float:left"></div>
            <button id="<%=vipButtonId%>" style="margin-left: 20px">重置</button>
            <input id="<%=vipStarId%>" type="hidden" value="<%=rateValue%>"/>
            <input id="<%=hiddenInputTid%>" type="hidden" value="<%=hiddenTid%>"/>
        </td>
        <td>
            <button id="<%=deleteId%>" style="margin-left: 20px">删除</button>
        </td>
    </tr>
    <script type="text/javascript">
        vipFunc(<%=vipNum%>, '<%=vipRateId%>',  '<%=vipStarId%>', '<%=rateValue%>',
                '<%=vipButtonId%>', '<%=deleteId%>', '<%=trId%>', '<%=taskId%>');
    </script>
    <%
            }
        }%>


    <tr>
        <td colspan="3">4, 我的思考<img id="myThink-taskBtn2" src="/img/add.jpg" alt="点击添加一项"
                                    style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
        </td>
    </tr>
    <% if (CollectionUtils.isEmpty(myThinkTasks)) {%>
    <tr>
        <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;
            <textarea rows="4" cols="92"></textarea>
        </td>
        <td>
            <button id="myThink-btn-delete1" style="margin-left: 20px" disabled>删除</button>
        </td>
    </tr>
    <% } else {
        for (int i = 1; i <= myThinkTasks.size(); i++) {
            Task task = myThinkTasks.get(i - 1);
            String content = task.getTask();
            float rateValue = task.getRate();
            Long taskId = task.getId();

            String prefix = "myThink";
            String trId = prefix + "-tr" + i;
            String vipRateId = prefix + "-jRate" + i;
            String vipStarId = prefix + "-star" + i;
            String vipButtonId = prefix + "-btn-click" + i;
            Long hiddenTid = taskId;
            String hiddenInputTid = "id" + i;
            String deleteId = prefix + "-deleteId" + i;
    %>
    <tr id="<%=trId%>">
        <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;
            <textarea id="myThink-text<%=i%>" rows="4" cols="92"><%=content%></textarea>
        </td>
        <td>
            <button id="<%=deleteId%>" style="margin-left: 20px">删除</button>
        </td>
    </tr>
    <script type="text/javascript">
        vipFunc(<%=vipNum%>, '<%=vipRateId%>', 0, '<%=vipStarId%>',
                '<%=vipButtonId%>', '<%=deleteId%>', '<%=trId%>', '<%=taskId%>');
    </script>
    <%
            }
        }%>


    <tr>
        <td colspan="3" align="right"><button id="finish">保存</button></td>
    </tr>
</table>

</body>
</html>
