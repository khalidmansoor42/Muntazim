<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Muntazm.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <title>Basic Layout - jQuery EasyUI Demo</title>
    <link rel="stylesheet" type="text/css" href="css/Global.css" />
    <link href="EasyUI/themes/default/easyui.css" rel="stylesheet" />
    <link href="EasyUI/themes/icon.css" rel="stylesheet" />
    <link href="EasyUI/themes/demo.css" rel="stylesheet" />
    <link href="JQuery UI/jquery-ui.css" rel="stylesheet" />
    <link href="JQuery UI/jquery-ui.structure.css" rel="stylesheet" />
    <link href="JQuery UI/jquery-ui.theme.css" rel="stylesheet" />

    <link href="alertify.js/themes/alertify.core.css" rel="stylesheet" />
    <link href="alertify.js/themes/alertify.default.css" rel="stylesheet" />

    <script type="text/javascript" src="alertify.js/lib/alertify.min.js"></script>
    <script src="JQuery UI/jquery-ui.js"></script>
    <script src="EasyUI/jquery.min.js"></script>
    <script src="EasyUI/jquery.easyui.min.js"></script>
    <style type="text/css">
        .panel{
            margin: 8% auto;
        }

    </style>
</head>
<body>
    
     <form runat="server">
         <div style="">
             <div class="easyui-panel" title="Login" style="text-align:center; margin:0px auto; height:350px; width:440px;">
            <div style="margin-top:8%;">
                <div style="margin-top:10px; width:60%; height:50px; text-align:left; margin:10px auto;">
                    <label class="lblCaption">Select Company:</label>
                    <select id="DropDownCompanies" class="easyui-combobox" style="float:left; width:251px; height: 21px;">
                        <asp:Repeater ID="rptCompanies" runat="server">
                            <ItemTemplate>
                                <option value="<%# Eval("CompCode") %>"><%# Eval("CompName") %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>
                    </div>
                <div style="margin-top:5px; width:60%; height:55px; text-align:left; margin:10px auto;">
                    <label class="lblCaption">User Name:</label>
                    <input type="text" id="txtUserName" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:250px; height:30px;" placeholder="Enter User Name" data-options="prompt:'Username',iconCls:'icon-man',iconWidth:38" />
                </div>
                <div style="width:60%; height:55px; margin-top:5px; text-align:left; margin:10px auto;">
                    <label class="lblCaption">Password:</label>
                    <input type="password" id="txtPassword" class="easyui-textbox" style="float:left; margin-top:4px; width:250px; height:30px;" placeholder="Enter Password" data-options="prompt:'Password',iconCls:'icon-lock',iconWidth:38" />
                </div>
                <div style="width:30%; height:22px; text-align:left; margin:20px 20%;">
                    <label class="lblCaption"><input type="checkbox" id="chkRememberMe" class="lblCaption" /> Remember Me</label>
                </div>
                <div style="width:30%; height:22px; text-align:left; margin:20px 20%;">
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick = "Login()"  data-options="iconCls:'icon-ok'" style="float:left; width:100px; height:25px;">Login</a>
                </div>
            </div>
        </div>
         </div>
   </form>

<script type="text/javascript">

        $(document).ready(function () {

            checkCookie();
            $("#txtUserName").textbox("setText", "azam");
            $("#txtPassword").textbox("setText", "1");
        });

        function Login() {
            var UserName = $("#txtUserName").val();
            var Password = $("#txtPassword").val();
            var CompanyId = $("#DropDownCompanies").combobox('getValue');
            var CompanyName = $("#DropDownCompanies").combobox('getText');

            if (!UserName) {
                alertify.error("Error: Please enter user name.");
                return;
            }
            else if (!Password) {
                alertify.error("Error: Please enter password.");
                return;
            }
            else if (!CompanyName) {
                alertify.error("Error: Please select company.");
                return;
            }

            var data = {
                UserName: UserName,
                Password: Password,
                CompanyId: CompanyId,
                CompanyName: CompanyName
            }

            data = JSON.stringify(data);

            $.ajax({
                type: "POST",
                url: "Login.aspx/DoLogin",
                data: data,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                        alertify.error(response.d);
                    }
                    else {
                        alertify.success(response.d);
                        if ($('#chkRememberMe').is(":checked")) {
                            setCookie("username", UserName, 365);
                        }
                        
                        window.setTimeout(function () { window.location = "Index.aspx"; },1000)
                    }
                },
                failure: function (response) {

                }
            });
        }

        function setCookie(c_name, value, exdays) {
            var exdate = new Date();
            exdate.setDate(exdate.getDate() + exdays);
            var c_value = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());
            document.cookie = c_name + "=" + c_value;
        }

        function getCookie(c_name) {
            var c_value = document.cookie;
            var c_start = c_value.indexOf(" " + c_name + "=");
            if (c_start == -1) {
                c_start = c_value.indexOf(c_name + "=");
            }
            if (c_start == -1) {
                c_value = null;
            }
            else {
                c_start = c_value.indexOf("=", c_start) + 1;
                var c_end = c_value.indexOf(";", c_start);
                if (c_end == -1) {
                    c_end = c_value.length;
                }
                c_value = unescape(c_value.substring(c_start, c_end));
            }
            return c_value;
        }

        function checkCookie() {
            var username = getCookie("username");
            if (username != null && username != "") {
                $("#txtUserName").val(username);
            }
        }

</script>

</body>
</html>
