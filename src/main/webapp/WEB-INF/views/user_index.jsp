<%@ page import="com.tnt.weeklyreview.model.Task" %>
<%@ page import="org.springframework.util.CollectionUtils" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<h1>工作日报</h1>

<%
String todayDate = (String) request.getAttribute("todayDate");

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

System.out.println(todayDate);
System.out.println(vipTasks);
%>

<head>
<script src="js/jquery.min.js"></script>
<script src="js/jRate.js"></script>

<script type="text/javascript">
    var vipNum = <%=vipNum%>;
    var otherNum = <%=otherNum%>;
    var nextWeekNum = <%=nextWeekNum%>;
    var myThinkNum = <%=myThinkNum%>;
    $(function () {
        var lastTrId = "vip-tr" + vipNum;
        $('#vip-addTaskBtn').on('click', function () {
            addTaskFunc("vip");
        });
        $('#other-addTaskBtn').on('click', function () {
            addTaskFunc("other");
        });
        $('#nextWeek-addTaskBtn').on('click', function () {
            addTaskFunc("nextWeek");
        });
        $('#myThink-addTaskBtn').on('click', function () {
            addMyThinkTaskFunc("myThink");
        });

        $('#finish').on('click', function () {
            finishOnClicked(vipNum);
        });
    });
</script>

<script src="js/user_index.js"></script>

</head>

<table border="1">
    <caption><h3><%=todayDate%>日报</h3></caption>
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
            String hiddenTid = prefix + "-id" + k;
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
        <td colspan="3">2, 今日其它工作<img id="<%=prefix%>-addTaskBtn" src="/img/add.jpg" alt="点击添加一项" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/></td>
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
            String hiddenTid = prefix + "-id" + k;
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
        <td colspan="3">3, 下周工作计划<img id="<%=prefix%>-addTaskBtn" src="/img/add.jpg" alt="点击添加一项" style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/></td>
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
            String hiddenTid = prefix + "-id" + k;
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



    <% prefix = "myThink"; %>
    <tr>
        <td colspan="3">4, 我的思考<img id="<%=prefix%>-addTaskBtn" src="/img/add.jpg" alt="点击添加一项"
                                    style="vertical-align: middle;width: 24px;padding:0px;margin:0px;cursor:pointer"/>
        </td>
    </tr>



    <%
        k = 1;
        task = null;
        content = "";
        taskId = 0L;
        do {
            if (!CollectionUtils.isEmpty(myThinkTasks)) {
                task = myThinkTasks.get(k - 1);
                content = task.getTask();
                taskId = task.getId();
            }

            String trId = prefix + "-tr" + k;
            String vipRateId = prefix + "-jRate" + k;
            String vipStarId = prefix + "-star" + k;
            String vipButtonId = prefix + "-btn-click" + k;
            String hiddenTidValue = "";
            String hiddenInputTid = prefix + "-id" + k;
            String deleteId = prefix + "-deleteId" + k;
            if (taskId != null && taskId != 0L) {
                hiddenTidValue = Long.toString(taskId);
            }
            %>
            <tr id="<%=trId%>">
                <td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;
                    <textarea id="myThink-text<%=k%>" rows="4" cols="92"><%=content%></textarea>
                </td>
                <td>
                    <button id="<%=deleteId%>" style="margin-left: 20px">删除</button>
                    <input id="<%=hiddenInputTid%>" type="hidden" value="<%=hiddenTidValue%>"/>
                </td>
            </tr>
            <script type="text/javascript">
                vipFunc(<%=vipNum%>, '<%=vipRateId%>', 0, '<%=vipStarId%>',
                        '<%=vipButtonId%>', '<%=deleteId%>', '<%=trId%>', '<%=taskId%>');
            </script>
        <%
        } while (++k <= myThinkTasks.size());
    %>

    <tr>
        <td colspan="3" align="right"><button id="finish">保存</button></td>
    </tr>
</table>

</body>
</html>
