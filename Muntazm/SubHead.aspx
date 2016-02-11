<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubHead.aspx.cs" Inherits="Muntazm.SubHead" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    
        <div class="easyui-panel" title="Sub Head" style="width:630px;">

           <div class="easyui-panel" style="width:96%; padding:5px; margin-top:5px; margin-left:10px;" data-options="border:false">              

                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Catagories_AddNew()">New</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="Catagories_Save()">Save</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick = "Catagories_DeleteSelectedRow()">Delete</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-close',plain:true" onclick = "removePanel()">Close</a>
            
            </div>


            <div style="float:left; height:150px; width:610px; margin-bottom:0px; margin-left: 5px; margin-right: 5px; margin-top: 10px;">
                
                <div style="width:235px; height:42px; text-align:left; margin:10px 10px; float:left;">
                    <label class="lblCaption">Main Head:</label>
                    <select id="CostSetupItem_DropDownMainHeads" runat ="server"  class="easyui-combobox" style="float:left; margin-top:4px; width:235px;" data-options="onChange: function() { fillSubheadGrid( $(this).combobox('getValue') ); }">
                    </select>
                </div>
                <div style="width:39px; height:25px; text-align:left; margin-top:20px; margin-left:2px;margin-right:5px; float:left;">
                    </div>

                    <div style=" width:76px; height:42px; text-align:left; margin-left:10px; float:left;">
                        <label class="lblCaption">Code:</label>
                        <input type="text" id="SubHead_txtCatagoryCode" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:75px;" data-options="disabled:true" />
                    </div>

                <div style="width:201px; height:42px; text-align:left; margin:0px 10px; float:left;">
                        <label class="lblCaption">Description:</label>
                        <input type="text" id="SubHead_txtDescription" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:185px;"  />
                    </div>
                    <div style="margin-top:10px; width:200px; height:24px; text-align:left; margin:10px; float:left;">
                        <label class="lblCaption" style="line-height:42px;"><input type="checkbox" id="Catagories_chkInUse" /> In-Use</label>
                    </div>

                </div>

            <div style="float:left; margin:0px 5px; width:611px;">
                <div style="width:45%; height:50px; text-align:left; margin:10px; float:left;">
                    <label class="lblCaption">Search:</label>
                    <input type="text" id="SubHead_txtSearch" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:270px;" placeholder="Enter Search Text" data-options="iconCls:'icon-search',iconWidth:38" />
                </div>
                <div style="margin:5px; width:98%; height:auto; text-align:left; float:left;">
                <table id="SubHead_tblCatagories" title="Category" style="margin-bottom:10px;" class="easyui-datagrid" data-options="pagination:true">
                    <thead>
                        <tr>
                            <th data-options="field:'id',width:200,align:'center'">Code</th>
                            <th data-options="field:'Description',width:245,align:'left'">Description</th>
                            <th data-options="field:'MarketingOverhead',width:65,align:'center',
                                formatter: function (value) {                                 
                                 if (value == true) {
                                     return '<input type=\'checkbox\' checked disabled>';
                                 }
                                 else {
                                     return '<input type=\'checkbox\' disabled>';
                                 }
                                }">Marketing Overhead</th>
                            <th data-options="field:'VariableExpense',width:65,align:'center',
                                formatter: function (value) {                                 
                                 if (value == true) {
                                     return '<input type=\'checkbox\' checked disabled>';
                                 }
                                 else {
                                     return '<input type=\'checkbox\' disabled>';
                                 }
                                }">Variable Expense</th>
                        </tr>
                    </thead>
                </table>
               
                </div>
           </div>

    </div>
    </form>
    <script type="text/javascript">
        var SubHead_Action;
        var SubHead_rId;
   
        $(document).ready(function () {
        
            SubHead_Action = "add";
            SetupLocation_fnLoadGrid(1, 5, "");

            $('#SubHead_txtSearch').textbox({
                inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                    keyup: function (e) {
                   
                        SetupLocation_fnLoadGrid(1, 5, $(this).val());
                    }
                })
            });

            CostMainheadSetup_LoadMainHeadCombo();
        });

        function SetupLocation_AddNew() {
            SubHead_Action = "add";
            $("#CostMainheadSetup_txtBankCode").textbox("setText", "(Auto)");
            $("#CostMainheadSetup_txtBankDescription").textbox("setText", "").textbox("textbox").focus();
        }

        function CostMainheadSetup_Save() {
            //alert(SubHead_Action);
            if (SubHead_Action == "add") {
                SetupLocation_GetMaxId();
            }
            else if (SubHead_Action == "update") {
                SetupLocation_Update(SetupLocation_rId);
            }
        }

        $('#CostMainheadSetup_DropDownMainHeads').combobox({

            onSelect: function () {
                SubHead_fnLoadGrid(1, 10, $(this).combobox('getValue'));
            }

        });

        function SubHead_fnLoadGrid(PageNumber, PageSize, strFilter) {

            var data = { PageNumber: PageNumber, PageSize: PageSize, filter: strFilter }
            data = JSON.stringify(data);
            $.ajax({
                type: "POST",
                url: "SubHead.aspx/FillGrid",
                data: data,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                        alertify.error(response.d);
                    }
                    else {

                        $('#SubHead_tblCatagories').datagrid({
                            data: JSON.parse(response.d),
                            pagination: true,
                            pageSize: PageSize,
                            rownumbers: true,
                            pageNumber: PageNumber,
                            singleSelect: true,
                            resizable: true,
                            pageList: [5, 10, 20, 30, 40, 50],
                            onClickRow: function (i, r) {

                            },
                            onDblClickRow: function (i, r) {
                                SubHead_GetRow(r.id);
                            },
                            onLoadSuccess: function (data) {
                                $('#SubHead_tblCatagories').datagrid('getPager').pagination({
                                    showRefresh: false,
                                    onSelectPage: function (pageNumber, pageSize) {

                                        SetupLocation_fnLoadGrid(pageNumber, pageSize, strFilter);
                                    }
                                });
                            }
                        });
                    }
                },
                failure: function (response) {

                }
            });
        }

        function SubHead_GetRow(RowId) {
            var data = { RowId: RowId }
            data = JSON.stringify(data);
            $.ajax({
                type: "POST",
                url: "SubHead.aspx/GetRow",
                data: data,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                        alertify.error(response.d);
                    }
                    else {
                        response = JSON.parse(response.d);
                        SetupLocation_Action = "update";
                        SetupLocation_rId = response.BankCode;
                        $("#SubHead_txtCatagoryCode").textbox('setText', response.BankCode);
                        $("#SubHead_txtDescription").textbox('setText', response.BankDescription);
                    }
                },
                failure: function (response) {

                }
            });
        }

</script>

</body>
</html>
