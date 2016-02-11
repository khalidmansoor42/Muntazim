<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CostSetupItem.aspx.cs" Inherits="Muntazm.CostSetupItem" %>
<form runat="server">
        <div class="easyui-panel" title="Item Cost Setup" style="width:630px;">

           <div class="easyui-panel" style="width:96%; padding:5px; margin-top:5px; margin-left:10px;" data-options="border:false">              

                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="Catagories_AddNew()">New</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="Catagories_Save()">Save</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick = "Catagories_DeleteSelectedRow()">Delete</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-close',plain:true" onclick = "removePanel()">Close</a>
            
            </div>


            <div style="float:left; height:150px; width:610px; margin-bottom:0px; margin-left: 5px; margin-right: 5px; margin-top: 10px;">
                
                <div style="width:235px; height:42px; text-align:left; margin:10px 10px; float:left;">
                    <label class="lblCaption">Cost:</label>
                    <select id="CostSetupItem_DropDownMainHeads" class="easyui-combobox" style="float:left; margin-top:4px; width:235px;">
                    </select>
                </div>
                <div style="width:39px; height:25px; text-align:left; margin-top:20px; margin-left:2px;margin-right:5px; float:left;">
                 <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">New</a>
                    </div>

                <div style=" width:242px; height:42px; text-align:left; margin:10px 10px;float:left;">
                    <label class="lblCaption">Sub Head:</label>
                    <select id="CostSetupItem_DropDownSubHeads" style="float:left; margin-top:4px; width:234px;" >
                        
                    </select>
                </div>
                   <div style="width:39px; height:25px; text-align:left; margin-top:20px; margin-left:1px; float:left;">
                 <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">New</a>
                    </div>

                    <div style=" width:76px; height:42px; text-align:left; margin-left:10px; float:left;">
                        <label class="lblCaption">Code:</label>
                        <input type="text" id="CostSetupItem_txtCatagoryCode" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:75px;" data-options="disabled:true" />
                    </div>

                <div style="width:201px; height:42px; text-align:left; margin:0px 10px; float:left;">
                        <label class="lblCaption">Description:</label>
                        <input type="text" id="CostSetupItem_txtDescription" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:185px;"  />
                    </div>

                    <div style="margin-top:10px; width:150px; height:43px; text-align:left; margin-left:20px; float:left;">
                        <label class="lblCaption"><input type="checkbox" id="CostSetupItem_chkMarketing" /> Marketing Overhead</label>
                        <label class="lblCaption"><input type="checkbox" id="CostSetupItem_chkVarExpense" /> Variable Expense</label><br/>
                    </div>

                    <div style="margin-top:10px; width:200px; height:24px; text-align:left; margin:10px; float:left;">
                        <label class="lblCaption" style="line-height:42px;"><input type="checkbox" id="Catagories_chkInUse" /> In-Use</label>
                    </div>

                </div>

            <div style="float:left; margin:0px 5px; width:611px;">
                <div style="width:45%; height:50px; text-align:left; margin:10px; float:left;">
                    <label class="lblCaption">Search:</label>
                    <input type="text" id="CostSetupItem_txtSearch" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:270px;" placeholder="Enter Search Text" data-options="iconCls:'icon-search',iconWidth:38" />
                </div>
                <div style="margin:5px; width:98%; height:auto; text-align:left; float:left;">
                <table id="CostSetupItem_tblCatagories" title="Category" style="margin-bottom:10px;" class="easyui-datagrid" data-options="pagination:true">
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
    var Catagories_Action;
    var Catagories_rId;
    $(document).ready(function () {

        Catagories_Action = "add";
     
        $('#CostSetupItem_txtSearch').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keyup: function (e) {

                    Catagories_fnLoadGrid(1, 10, Catagories_BuildCriteria());
                }
            })
        });


        $('#CostSetupItem_DropDownMainHeads').combobox({

            onSelect: function () {

                $('#CostSetupItem_txtCatagoryCode').textbox('setText', '');
                $('#CostSetupItem_txtDescription').textbox('setText', '');

                Catagories_LoadSubHeadCombo($(this).combobox('getValue'));

                $('#CostSetupItem_tblCatagories').datagrid({
                    data: { "total": 0, "rows": [] },
                   // toolbar: CostSetupItem_tblCatagories_ToolBar,
                    pagination: true,
                    rownumbers: true,
                    pageList: [5, 10, 20, 30, 40, 50]
                });

                $('#CostSetupItem_tblCatagories').datagrid('getPager').pagination({
                    showRefresh: false
                });
            }



        });

        

        $('#CostSetupItem_DropDownSubHeads').combobox({

            onSelect: function () {

                $('#CostSetupItem_txtCatagoryCode').textbox('setText', '');
                $('#CostSetupItem_txtDescription').textbox('setText', '');

                Catagories_fnLoadGrid(1, 10, Catagories_BuildCriteria());
            }

        });

        $('#CostSetupItem_tblCatagories').datagrid({
            data: {"total":0,"rows":[]},
           // toolbar: CostSetupItem_tblCatagories_ToolBar,
            pagination: true,
            rownumbers: true,
            pageList: [5, 10, 20, 30, 40, 50]
        });

        $('#CostSetupItem_tblCatagories').datagrid('getPager').pagination({
            showRefresh: false
        });

        Catagories_LoadMainHeadCombo();

    });

    function Catagories_BuildCriteria()
    {
        return "WHERE (id LIKE '%" + $("#CostSetupItem_txtSearch").textbox('getText') + "%' OR description LIKE '%" + $("#CostSetupItem_txtSearch").textbox('getText') + "%') AND subheadid='" + $("#CostSetupItem_DropDownSubHeads").combobox('getValue') + "'";
    }


    function Catagories_LoadMainHeadCombo() {

        $.ajax({
            type: "POST",
            url: "CostSetupItem.aspx/LoadMainHeadCombo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                    $("#CostSetupItem_DropDownMainHeads").combobox({
                        valueField: 'id',
                        textField: 'description',
                        data: JSON.parse(response.d)
                    });
                }
            }
        });
    }


    function Catagories_LoadSubHeadCombo(MainHeadCode)
    {
        var data = {MainHeadCode: MainHeadCode}

        data = JSON.stringify(data);

        $.ajax({
            type: "POST",
            url: "CostSetupItem.aspx/LoadSubHeadCombo",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {

                    $("#CostSetupItem_DropDownSubHeads").combobox({
                        valueField: 'id',
                        textField: 'description',
                        data: JSON.parse(response.d)
                    });
                }
            },
            failure: function (response) {

            }
        });
    }

    function Catagories_Save() {

        if (Catagories_Action == "add") {
            Catagories_GetMaxId();
        }
        else if (Catagories_Action == "update") {
            Catagories_Update(Catagories_rId);
        }
    }

    function Catagories_Update(RowId) {
        var MainHeadCode = $("#CostSetupItem_DropDownMainHeads").combobox('getValue');
        var SubHeadCode = $("#CostSetupItem_DropDownSubHeads").combobox('getValue');
        var CatagoryCode = $("#CostSetupItem_txtCatagoryCode").textbox('getText');
        var Description = $("#CostSetupItem_txtDescription").textbox('getText');
        var InUse = 0;
        var MarketingOverhead = 0;
        var VariableExpense = 0;

        if (!MainHeadCode) {
            alertify.error("Error: Main Head is missing.");
            $("#CostSetupItem_DropDownMainHeads").combobox('textbox').focus();
            return;
        }
        else if (!SubHeadCode) {
            alertify.error("Error: Sub Head is missing.");
            $("#CostSetupItem_DropDownSubHeads").combobox('textbox').focus();
            return;
        }
        else if (!CatagoryCode) {
            alertify.error("Error: Catagory code is missing.");
            $("#CostSetupItem_txtCatagoryCode").textbox('textbox').focus();
            return;
        }
        else if (!Description) {
            alertify.error("Error: Description is missing.");
            $("#CostSetupItem_txtDescription").textbox('textbox').focus();
            return;
        }

        //if ($('#Catagories_chkInUse').is(':checked')) {
        //    InUse = 1;
        //}
        if ($('#CostSetupItem_chkMarketing').is(':checked')) {
            MarketingOverhead = 1;
        }
        if ($('#CostSetupItem_chkVarExpense').is(':checked')) {
            VariableExpense = 1;
        }

        $.messager.confirm('Save Record', 'Do you want to save this record.?', function (r) {
            if (r) {
                
                var data = {
                    id: CatagoryCode,
                    Description: Description,
                    MarketingOverhead: MarketingOverhead,
                    VariableExpense: VariableExpense
                }

                data = JSON.stringify(data);
                $.ajax({
                    type: "POST",
                    url: "CostSetupItem.aspx/Update",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                            alertify.error(response.d);
                        }
                        else {
                            alertify.success(response.d);
                            Catagories_fnLoadGrid(1, 10, Catagories_BuildCriteria());
                        }
                    },
                    failure: function (response) {

                    }
                });
            }
        });
    }

    function Catagories_AddNew() {
        Catagories_Action = "add";
        $("#CostSetupItem_txtCatagoryCode").textbox("setText", "(Auto)");
        $("#CostSetupItem_txtDescription").textbox("setText", "");
        //$('#Catagories_chkInUse').prop('checked', false);
        $('#CostSetupItem_chkMarketing').prop('checked', false);
        $("#CostSetupItem_chkVarExpense").prop('checked', false);
    }
    function Catagories_Add() {
        var MainHeadCode = $("#CostSetupItem_DropDownMainHeads").combobox('getValue');
        var SubHeadCode = $("#CostSetupItem_DropDownSubHeads").combobox('getValue');
        var CatagoryCode = $("#CostSetupItem_txtCatagoryCode").textbox('getText');
        var Description = $("#CostSetupItem_txtDescription").textbox('getText');
        var InUse = 0;
        var MarketingOverhead = 0;
        var VariableExpense = 0;

        if (!MainHeadCode) {
            alertify.error("Error: Main Head is missing.");
            $("#CostSetupItem_DropDownMainHeads").combobox('textbox').focus();
            return;
        }
        else if (!SubHeadCode) {
            alertify.error("Error: Sub Head is missing.");
            $("#CostSetupItem_DropDownSubHeads").combobox('textbox').focus();
            return;
        }
        else if (!CatagoryCode) {
            alertify.error("Error: Catagory code is missing.");
            $("#CostSetupItem_txtCatagoryCode").textbox('textbox').focus();
            return;
        }
        else if (!Description) {
            alertify.error("Error: Description is missing.");
            $("#CostSetupItem_txtDescription").textbox('textbox').focus();
            return;
        }
        
        //if ($('#Catagories_chkInUse').is(':checked')) {
        //    InUse = 1;
        //}
        if ($('#CostSetupItem_chkMarketing').is(':checked')) {
            MarketingOverhead = 1;
        }
        if ($('#CostSetupItem_chkVarExpense').is(':checked')) {
            VariableExpense = 1;
        }

        $.messager.confirm('Save Record', 'Do you want to save this record.?', function (r) {
            if (r) {

                var data = {
                    CatagoryCode: CatagoryCode,
                    Description: Description,
                    //InUse: InUse,
                    SubHeadCode: SubHeadCode,
                    MarketingOverhead : MarketingOverhead,
                    VariableExpense : VariableExpense
                }

                data = JSON.stringify(data);

                $.ajax({
                    type: "POST",
                    url: "CostSetupItem.aspx/Add",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                            alertify.error(response.d);
                        }
                        else {
                            alertify.success(response.d);
                            Catagories_Action = "update";
                            Catagories_fnLoadGrid(1, 10, Catagories_BuildCriteria());
                        }
                    },
                    failure: function (response) {

                    }
                });

            }
        });
    }

    function Catagories_EditSelectedRow() {
        var selectedRow = $('#CostSetupItem_tblCatagories').datagrid('getSelected');
        Catagories_GetRow(selectedRow.CatagoryCode);
    }

    function Catagories_DeleteSelectedRow() {

        if ($("#CostSetupItem_txtCatagoryCode").textbox('getText') == "(Auto)" || $("#CostSetupItem_txtCatagoryCode").textbox('getText') == "") {

        }
        else {
            $.messager.confirm('Delete Record',
            "<ul style='list-style-type:none;margin:0px;padding:0px;'><li>You have selected.</li><li>Code : "
            + $("#CostSetupItem_txtCatagoryCode").textbox('getText')
            + " </li><li> Description : "
            + $("#CostSetupItem_txtDescription").textbox('getText')
            + " </li><li Style = 'margin-left:42px';>Do you want to delete this record.?</li> </ul>"
            , function (r) {
                if (r) {
                   // Branches_DeleteRow($("#Branches_txtBranchCode").textbox('getText'));
                    Catagories_DeleteRow($("#CostSetupItem_txtCatagoryCode").textbox('getText'));
                }

            })
        }

        var selectedRow = $('#CostSetupItem_tblCatagories').datagrid('getSelected');
        //Catagories_DeleteRow(selectedRow.id);
    }

    function Catagories_fnLoadGrid(PageNumber, PageSize, strFilter) {
        var data = { PageNumber: PageNumber, PageSize: PageSize, filter: strFilter }
        data = JSON.stringify(data);
        $.ajax({
            type: "POST",
            url: "CostSetupItem.aspx/FillGrid",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                    $('#CostSetupItem_tblCatagories').datagrid({
                        data: JSON.parse(response.d),
                        pagination: true,
                        pageSize: PageSize,
                        rownumbers: true,
                        pageNumber: PageNumber,
                        singleSelect: true,
                        resizable: true,
                        pageList: [5, 10, 20, 30, 40, 50],
                        //toolbar: CostSetupItem_tblCatagories_ToolBar,
                        onClickRow: function (i, r) {

                        },
                        onDblClickRow: function (i, r) {
                            Catagories_GetRow(r.id, r.MarketingOverhead, r.VariableExpense);
                        },
                        onLoadSuccess: function (data) {
                            $('#CostSetupItem_tblCatagories').datagrid('getPager').pagination({
                                showRefresh: false,
                                onSelectPage: function (pageNumber, pageSize) {

                                    Catagories_fnLoadGrid(pageNumber, pageSize, Catagories_BuildCriteria());
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

    function Catagories_GetRow(RowId, MarkOverhead, VarExpense) {

        var data = {
            RowId: RowId,
        }
        data = JSON.stringify(data);
        
        $.ajax({
            type: "POST",
            url: "CostSetupItem.aspx/GetRow",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                    response = JSON.parse(response.d);
                    Catagories_Action = "update";
                    Catagories_rId = response.id;
                    $("#CostSetupItem_txtCatagoryCode").textbox('setValue', response.id);
                    $("#CostSetupItem_txtDescription").textbox('setText', response.Description);
                    
                    //if (response.InUse == "True") {
                    //    $('#Catagories_chkInUse').prop('checked', true);
                    //}
                    //else {
                    //    $('#Catagories_chkInUse').prop('checked', false);
                    //}
                    
                    if (MarkOverhead== true) {
                        $('#CostSetupItem_chkMarketing').prop('checked', true);
                    }
                    else {
                        $('#CostSetupItem_chkMarketing').prop('checked', false);
                    }
                    if (VarExpense == true) {
                        $('#CostSetupItem_chkVarExpense').prop('checked', true);
                    }
                    else {
                        $('#CostSetupItem_chkVarExpense').prop('checked', false);
                    }
                }
            },
            failure: function (response) {

            }
        });
    }

    function Catagories_GetMaxId() {

        if (!$("#CostSetupItem_DropDownMainHeads").combobox('getValue')) {
            alertify.error("Error: Main head not selected.");
            $("#CostSetupItem_DropDownMainHeads").combobox('textbox').focus();
            return;
        }
        else if (!$("#CostSetupItem_DropDownSubHeads").combobox('getValue')) {
            alertify.error("Error: Sub head not selected.");
            $("#CostSetupItem_DropDownSubHeads").combobox('textbox').focus();
            return;
        }

        var data = { Prefix: $("#CostSetupItem_DropDownSubHeads").combobox('getValue') + "-" }
        data = JSON.stringify(data);

        $.ajax({
            type: "POST",
            url: "CostSetupItem.aspx/GetMaxId",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {

                    $("#CostSetupItem_txtCatagoryCode").textbox("setText", response.d);
                    Catagories_Add();
                }
            },
            failure: function (response) {

            }
        });
    }


    function Catagories_DeleteRow(RowId) {


        //$.messager.confirm('Delete Record', 'Do you want to delete this record.?', function (r) {
        //    if (r) {
                var data = { RowId: RowId }
                data = JSON.stringify(data);
                $.ajax({
                    type: "POST",
                    url: "CostSetupItem.aspx/DeleteRow",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                            alertify.error(response.d);
                        }
                        else {
                            alertify.success(response.d);
                            $("#CostSetupItem_txtCatagoryCode").textbox("setText", "");
                            $("#CostSetupItem_txtDescription").textbox("setText", "");
                            //$('#Catagories_chkInUse').prop('checked', false);
                            $('#CostSetupItem_chkMarketing').prop('checked', false);
                            $('#CostSetupItem_chkVarExpense').prop('checked', false);
                            Catagories_fnLoadGrid(1, 10, Catagories_BuildCriteria());
                        }
                    },
                    failure: function (response) {

                    }
                });
        //    }
        //});
    }

</script>
