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
    <%String prefix = "vip";%>
    <tr>
        <td colspan="3">
            <div>
                <span style="vertical-align: middle">1, 今日重点工作</span>
                <img id="<%=prefix%>-addTaskBtn" src="/img/add.jpg" alt="点击添加一项" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
            </div>
        </td>
    </tr>

    <%
        int k = 1;
        Task task = null;
        String content = "";
        float rateValue = 0;
        Long taskId = 0L;
        do {
            if (!CollectionUtils.isEmpty(vipTasks)) {
                task = vipTasks.get(k - 1);
                content = task.getTask();
                rateValue = task.getRate();
                taskId = task.getId();
            }

            String trId = prefix + "-tr" + k;
            String rateId = prefix + "-jRate" + k;
            String starId = prefix + "-star" + k;
            String resetButtonId = prefix + "-btn-reset" + k;
            String hiddenTid = "id" + k;
            String deleteButtonId = prefix + "-deleteId" + k;
            String textId = prefix + "-text" + k;
            String hiddenTidValue = "";
            if (taskId != null && taskId != 0L) {
                hiddenTidValue = Long.toString(taskId);
            }
            %>
            <tr id="<%=trId%>">
                <td>&nbsp;&nbsp;&nbsp;&nbsp;
                    <input id="<%=textId%>" type="text" size="60" value="<%=content%>"/>
                </td>
                <td>
                    <div id="<%=rateId%>" style="height:30px;width: 100px;float:left"></div>
                    <button id="<%=resetButtonId%>" style="margin-left: 20px">重置</button>
                    <input id="<%=starId%>" type="hidden" value="<%=rateValue%>"/>
                    <input id="<%=hiddenTid%>" type="hidden" value="<%=hiddenTidValue%>"/>
                </td>
                <td>
                    <button id="<%=deleteButtonId%>" style="margin-left: 20px">删除</button>
                </td>
            </tr>
            <script type="text/javascript">
                vipFunc(<%=vipNum%>, '<%=rateId%>', '<%=starId%>',  <%=rateValue%>, '<%=resetButtonId%>',
                        '<%=deleteButtonId%>', '<%=trId%>', '<%=hiddenTidValue%>');
            </script>

            <%
        } while (++k <= vipTasks.size());%>



    <% prefix = "other"; %>
    <tr>
        <td colspan="3">2, 今日其它工作<img id="vip-taskBtn2" src="/img/add.jpg" alt="点击添加一项" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/></td>
    </tr>
    <%
        k = 1;
        task = null;
        content = "";
        rateValue = 0;
        taskId = 0L;
        do {
            if (!CollectionUtils.isEmpty(otherTasks)) {
                task = otherTasks.get(k - 1);
                content = task.getTask();
                rateValue = task.getRate();
                taskId = task.getId();
            }

            String trId = prefix + "-tr" + k;
            String rateId = prefix + "-jRate" + k;
            String starId = prefix + "-star" + k;
            String resetButtonId = prefix + "-btn-reset" + k;
            String hiddenTid = "id" + k;
            String deleteButtonId = prefix + "-deleteId" + k;
            String textId = prefix + "-text" + k;
            String hiddenTidValue = "";
            if (taskId != null && taskId != 0L) {
                hiddenTidValue = Long.toString(taskId);
            }
    %>
    <tr id="<%=trId%>">
        <td>&nbsp;&nbsp;&nbsp;&nbsp;
            <input id="<%=textId%>" type="text" size="60" value="<%=content%>"/>
        </td>
        <td>
            <div id="<%=rateId%>" style="height:30px;width: 100px;float:left"></div>
            <button id="<%=resetButtonId%>" style="margin-left: 20px">重置</button>
            <input id="<%=starId%>" type="hidden" value="<%=rateValue%>"/>
            <input id="<%=hiddenTid%>" type="hidden" value="<%=hiddenTidValue%>"/>
        </td>
        <td>
            <button id="<%=deleteButtonId%>" style="margin-left: 20px">删除</button>
        </td>
    </tr>
    <script type="text/javascript">
        vipFunc(<%=vipNum%>, '<%=rateId%>', '<%=starId%>',  <%=rateValue%>, '<%=resetButtonId%>',
                '<%=deleteButtonId%>', '<%=trId%>', '<%=hiddenTidValue%>');
    </script>

    <%
        } while (++k <= otherTasks.size());%>



    <% prefix = "nextWeek"; %>
    <tr>
        <td colspan="3">3, 下周工作计划<img id="nextWeek-taskBtn2" src="/img/add.jpg" alt="点击添加一项" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/></td>
    </tr>
    <%
        k = 1;
        task = null;
        content = "";
        rateValue = 0;
        taskId = 0L;
        do {
            if (!CollectionUtils.isEmpty(nextWeekTasks)) {
                task = nextWeekTasks.get(k - 1);
                content = task.getTask();
                rateValue = task.getRate();
                taskId = task.getId();
            }

            String trId = prefix + "-tr" + k;
            String rateId = prefix + "-jRate" + k;
            String starId = prefix + "-star" + k;
            String resetButtonId = prefix + "-btn-reset" + k;
            String hiddenTid = "id" + k;
            String deleteButtonId = prefix + "-deleteId" + k;
            String textId = prefix + "-text" + k;
            String hiddenTidValue = "";
            if (taskId != null && taskId != 0L) {
                hiddenTidValue = Long.toString(taskId);
            }
    %>
    <tr id="<%=trId%>">
        <td>&nbsp;&nbsp;&nbsp;&nbsp;
            <input id="<%=textId%>" type="text" size="60" value="<%=content%>"/>
        </td>
        <td>
            <div id="<%=rateId%>" style="height:30px;width: 100px;float:left"></div>
            <button id="<%=resetButtonId%>" style="margin-left: 20px">重置</button>
            <input id="<%=starId%>" type="hidden" value="<%=rateValue%>"/>
            <input id="<%=hiddenTid%>" type="hidden" value="<%=hiddenTidValue%>"/>
        </td>
        <td>
            <button id="<%=deleteButtonId%>" style="margin-left: 20px">删除</button>
        </td>
    </tr>
    <script type="text/javascript">
        vipFunc(<%=vipNum%>, '<%=rateId%>', '<%=starId%>',  <%=rateValue%>, '<%=resetButtonId%>',
                '<%=deleteButtonId%>', '<%=trId%>', '<%=hiddenTidValue%>');
    </script>

    <%
        } while (++k <= nextWeekTasks.size());%>



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
            Task task2 = myThinkTasks.get(i - 1);
            String content2 = task2.getTask();
            float rateValue2 = task2.getRate();
            Long taskId2 = task2.getId();

            prefix = "myThink";
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
            <textarea id="myThink-text<%=i%>" rows="4" cols="92"><%=content2%></textarea>
        </td>
        <td>
            <button id="<%=deleteId%>" style="margin-left: 20px">删除</button>
        </td>
    </tr>
    <script type="text/javascript">
        vipFunc(<%=vipNum%>, '<%=vipRateId%>', 0, '<%=vipStarId%>',
                '<%=vipButtonId%>', '<%=deleteId%>', '<%=trId%>', '<%=taskId2%>');
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
