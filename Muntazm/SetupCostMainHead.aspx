<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetupCostMainHead.aspx.cs" Inherits="Muntazm.SetupCostMainHead" %>
    
    <form id="SetupLocation" runat="server">
        <div class="row">   
            <div class="column column-9">  
                <div class="easyui-panel" title="Cost Mainhead">
                    <!--Start Row-->
                    <div class="row">
                       <div class="column column-6" data-options="border:false">
                            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="SetupLocation_AddNew()">New</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="CostMainheadSetup_Save()">Save</a>
                            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-close',plain:true" onclick = "removePanel()">Close</a>
                        </div>
                        <div class="column column-6">
                            <div class="column column-2 column-offset-1">
                                <label class="lblCaption">Search:</label>
                            </div>
                            <div class="column column-7">
                                <input type="text" id="CostMainheadSetup_txtSearch" autocomplete="off" class="easyui-textbox responsive-control" placeholder="Enter Search Text" data-options="iconCls:'icon-search',iconWidth:38" />
                            </div>
                        </div>
                    </div>
                    <!--End Row-->
                    <!--Start Row-->
                    <div class="row">
                        <div class="column column-8 column-offset-2">
                            <table id="CostMainheadSetup_tblSetupBanks" class="responsive-control" title="Main Itemheads">
                                <thead>
                                    <tr>
                                        <th data-options="field:'id',width: 80,align:'center'">Code</th>
                                        <th data-options="field:'description',width: 443,align:'center'">Description</th>
                                    </tr>
                                </thead>
                            </table>
                       </div>
                    </div>
                    <!--End Row-->
                    <!--Start Row-->
                    <div class="row">
                        <div class="column column-6">
                            <div class="column column-4">
                                <div class="column column-3">
                                    <label class="lblCaption">Code:</label>
                                </div>
                                <div class="column column-5">
                                    <input type="text" id="CostMainheadSetup_txtBankCode" autocomplete="off" class="easyui-textbox responsive-control" data-options="disabled:true" />
                                </div>
                            </div>
                            <div class="column column-8">
                                <div class="column column-3">
                                    <label class="lblCaption">Description:</label>
                                </div>
                                <div class="column column-9">
                                    <input type="text" id="CostMainheadSetup_txtBankDescription" autocomplete="off" class="easyui-textbox responsive-control" />
                                </div>
                            </div>
                        </div>
                        <div class="column column-5" style="margin-top:5px">
                            <div class="column column-5">
                                <label class="lblCaption">Branch wise GL Code:</label>
                            </div>
                            <div class="column column-7">
                                <select id="CostMainheadSetup_DropDownMainHeads" class="easyui-combobox responsive-control" name="D1">
                                </select>
                            </div>
                        </div>
                    </div>
                    <!--End Row-->
                    <!--Start Row-->
                    <div class="row">
                        <div class="column column-12">
                            <table id="CostMainheadSetup_mainHeadGlCode" title="GL Codes">
                                <thead>
                                    <tr>
                                        <th data-options="field:'AGglCode',width:135,align:'left'">Administrative &<br/> General Expenses</th>
                                        <th data-options="field:'AGglCode1',width:150,align:'left',editor:{type:'combogrid',options:{
                                            panelWidth: 500,
                                            idField: 'AccountCode',
                                            textField: 'AccountCode',
                                            columns: [[
                                                {field:'AccountCode',title:'Account Code',width:150},
                                                {field:'AccountDescription',title:'Account Description',width:350}
                                            ]],
                                            fitColumns: true,
                                            onShowPanel: function() {
                                                FillGrid($(this).combogrid('grid'),'Accounts','SELECT AccountCode,AccountDescription FROM vwcataccounts');
                                            }
                                            }}"></th>
                                        <th data-options="field:'FOglCode',width:135,align:'left'">Financial & Other <br/>Charges</th>
                                        <th data-options="field:'FOglCode1',width:150,align:'left',editor:{type:'combogrid',options:{
                                            panelWidth: 500,
                                            idField: 'AccountCode',
                                            textField: 'AccountCode',
                                            columns: [[
                                                {field:'AccountCode',title:'Account Code',width:150},
                                                {field:'AccountDescription',title:'Account Description',width:350}
                                            ]],
                                            fitColumns: true,
                                            onShowPanel: function() {
                                                    FillGrid($(this).combogrid('grid'),'Accounts','SELECT AccountCode,AccountDescription FROM vwcataccounts');
                                            }
                                            }}"></th>
                                        <th data-options="field:'SDglCode',width:140,align:'left'">Selling &<br/> Distribution</th>
                                        <th data-options="field:'SDglCode1',width:150,align:'left',editor:{type:'combogrid',options:{
                                            panelWidth: 500,
                                            idField: 'AccountCode',
                                            textField: 'AccountCode',
                                            columns: [[
                                                {field:'AccountCode',title:'Account Code',width:150},
                                                {field:'AccountDescription',title:'Account Description',width:350}
                                            ]],
                                            fitColumns: true,
                                            onShowPanel: function() {
                                                    FillGrid($(this).combogrid('grid'),'Accounts','SELECT AccountCode,AccountDescription FROM vwcataccounts');
                                            }
                                            }}"></th>
                                        <th data-options="field:'COGSglCode',width:135,align:'left'">Cost of Goods<br/> Sold</th>
                                        <th data-options="field:'COGSglCode1',width:150,align:'left',editor:{type:'combogrid',options:{
                                            panelWidth: 500,
                                            idField: 'AccountCode',
                                            textField: 'AccountCode',
                                            columns: [[
                                                {field:'AccountCode',title:'Account Code',width:150},
                                                {field:'AccountDescription',title:'Account Description',width:350}
                                            ]],
                                            fitColumns: true,
                                            onShowPanel: function() {
                                                    FillGrid($(this).combogrid('grid'),'Accounts','SELECT AccountCode,AccountDescription FROM vwcataccounts');
                                            }
                                            }}"></th>
                                    </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                    <!--End Row-->
            </div>
                </div>
            <!--Panel End-->
            </div>
        <!--Row End-->
</form>

<script type="text/javascript">
    var SetupLocation_Action;
    var SetupLocation_rId;

    $(document).ready(function () {

        SetupLocation_Action = "add";
        SetupLocation_fnLoadGrid(1, 5, "");
        SetupLocation_fnLoadExpGrid(1, 5, "");

        $('#CostMainheadSetup_txtSearch').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keyup: function (e) {

                    SetupLocation_fnLoadGrid(1, 5, $(this).val());
                }
            })
        });

        CostMainheadSetup_LoadMainHeadCombo();
    });

    function SetupLocation_AddNew() {
        SetupLocation_Action = "add";
        $("#CostMainheadSetup_txtBankCode").textbox("setText", "(Auto)");
        $("#CostMainheadSetup_txtBankDescription").textbox("setText", "").textbox("textbox").focus();
    }



    function CostMainheadSetup_Save() {
        //alert(SetupLocation_Action);
        if (SetupLocation_Action == "add") {
            SetupLocation_GetMaxId();
        }
        else if (SetupLocation_Action == "update") {
            SetupLocation_Update(SetupLocation_rId);
        }
    }

    $('#CostMainheadSetup_DropDownMainHeads').combobox({

        onSelect: function () {
            SetupLocation_fnLoadExpGrid(1, 10, $(this).combobox('getValue'));
        }

    });

    function CostMainheadSetup_LoadMainHeadCombo() {

        $.ajax({
            type: "POST",
            url: "CostMainheadSetup.aspx/LoadMainHeadCombo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                    $("#CostMainheadSetup_DropDownMainHeads").combobox({
                        valueField: 'CompCode',
                        textField: 'Description',
                        data: JSON.parse(response.d)
                    });
                }
            }
        });
    }

    function SetupLocation_Update(RowId) {
        var bankcode = $("#CostMainheadSetup_txtBankCode").textbox('getText');
        var bankdescription = $("#CostMainheadSetup_txtBankDescription").textbox('getText');

        if (!bankcode) {
            alertify.error("Error: Bank code is missing.");
            return;
        }
        else if (!bankdescription) {
            alertify.error("Error: Bank Description is missing.");
            $("#CostMainheadSetup_txtBankDescription").textbox('textbox').focus();
            return;
        }


        $.messager.confirm('Save Record', 'Do you want to save this record.?', function (r) {
            if (r) {

                var data = {
                    id: bankcode,
                    description: bankdescription,
                    branchID: branchID,
                    AGglCode: AGglCode,
                    FOglCode: FOglCode,
                    SDglCode: SDglCode,
                    COGSglCode: COGSglCode
                }

                data = JSON.stringify(data);

                $.ajax({
                    type: "POST",
                    url: "CostMainheadSetup.aspx/Update",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                            alertify.error(response.d);
                        }
                        else {
                            alertify.success(response.d);
                            $("#CostMainheadSetup_txtSearch").textbox("setText", "");
                            SetupLocation_fnLoadGrid(1, 5, "");
                        }
                    },
                    failure: function (response) {

                    }
                });
            }
        });
    }

    //function onSelectComboGrid(index, record) {
    //    alert(index);
    //    var dg = $('#tt');
    //    var gridOpts = dg.edatagrid('options');
    //    var ed = dg.edatagrid('getEditor', { index: gridOpts.editIndex, field: 'pickWarehouseCode' });
    //    var comboOpts = $(ed.target).combogrid('options');
    //    console.log(comboOpts.textField);
    //}

    function SetupLocation_Add() {
        var bankcode = $("#CostMainheadSetup_txtBankCode").textbox('getText');
        var bankdescription = $("#CostMainheadSetup_txtBankDescription").textbox('getText');
        var branchID = $("#CostMainheadSetup_DropDownMainHeads").combobox('getValue');
        //var g = $('#CostMainheadSetup_mainHeadGlCode').combogrid('grid');	// get datagrid object
        //var r = g.datagrid('getSelected');
        //var AGglCode = $("#CostMainheadSetup_mainHeadGlCode").combogrid('COGSglCode1');
        alert(r);
        if (!bankcode) {
            alertify.error("Error: Bank code is missing.");
            return;
        }
        else if (!bankdescription) {
            alertify.error("Error: Bank Description is missing.");
            $("#CostMainheadSetup_txtBankDescription").textbox('textbox').focus();
            return;
        }



        $.messager.confirm('Save Record', 'Do you want to save this record.?', function (r) {
            if (r) {

                var data = {
                    id: bankcode,
                    description: bankdescription,
                    branchID: branchID,
                    AGglCode: AGglCode,
                    FOglCode: FOglCode,
                    SDglCode: SDglCode,
                    COGSglCode: COGSglCode
                }

                data = JSON.stringify(data);
                //alert(data);
                $.ajax({
                    type: "POST",
                    url: "CostMainheadSetup.aspx/Add",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        //alert(response);
                        if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                            alertify.error(response.d);
                        }
                        else {
                            alertify.success(response.d);
                            $("#CostMainheadSetup_txtSearch").textbox("setText", "");
                            SetupLocation_fnLoadGrid(1, 5, "");
                            SetupLocation_fnLoadExpGrid(1, 5, "");
                        }
                    },
                    failure: function (response) {
                        alertify.failure(response.d);
                    }
                });

            }
        });
    }

    function SetupLocation_EditSelectedRow() {
        var selectedRow = $('#CostMainheadSetup_tblSetupBanks').datagrid('getSelected');
        SetupLocation_GetRow(selectedRow.id);
    }

    function SetupLocation_fnLoadExpGrid(PageNumber, PageSize, strFilter) {

        var data = { PageNumber: PageNumber, PageSize: PageSize, filter: strFilter }
        data = JSON.stringify(data);
        $.ajax({
            type: "POST",
            url: "CostMainheadSetup.aspx/FillExpGrid",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {

                    $('#CostMainheadSetup_mainHeadGlCode').datagrid({
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
                            SetupLocation_GetRow(r.id);
                        },
                        onLoadSuccess: function (data) {
                            $(this).datagrid('enableCellEditing');
                            $('#CostMainheadSetup_mainHeadGlCode').datagrid('getPager').pagination({
                                showRefresh: false,
                                onSelectPage: function (pageNumber, pageSize) {
                                    SetupLocation_fnLoadExpGrid(pageNumber, pageSize, strFilter);
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

    function SetupLocation_fnLoadGrid(PageNumber, PageSize, strFilter) {

        var data = { PageNumber: PageNumber, PageSize: PageSize, filter: strFilter }
        data = JSON.stringify(data);
        $.ajax({
            type: "POST",
            url: "CostMainheadSetup.aspx/FillGrid",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {

                    $('#CostMainheadSetup_tblSetupBanks').datagrid({
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
                            SetupLocation_GetRow(r.id);
                        },
                        onLoadSuccess: function (data) {
                            $('#CostMainheadSetup_tblSetupBanks').datagrid('getPager').pagination({
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

    function SetupLocation_GetRow(RowId) {
        var data = { RowId: RowId }
        data = JSON.stringify(data);
        $.ajax({
            type: "POST",
            url: "CostMainheadSetup.aspx/GetRow",
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
                    $("#CostMainheadSetup_txtBankCode").textbox('setText', response.BankCode);
                    $("#CostMainheadSetup_txtBankDescription").textbox('setText', response.BankDescription);
                }
            },
            failure: function (response) {

            }
        });
    }

    function SetupLocation_GetMaxId() {
        $.ajax({
            type: "POST",
            url: "CostMainheadSetup.aspx/GetMaxId",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {

                    $("#CostMainheadSetup_txtBankCode").textbox("setText", response.d);
                    SetupLocation_Add();
                }
            },
            failure: function (response) {

            }
        });
    }


    function SetupLocation_DeleteRow(RowId) {
        var data = { RowId: RowId }
        data = JSON.stringify(data);
        $.ajax({
            type: "POST",
            url: "SetupLocation.aspx/DeleteRow",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                    alertify.success(response.d);
                    SetupLocation_fnLoadGrid(1, 5, "");
                    $("#CostMainheadSetup_txtBankCode").textbox("setText", "");
                    $("#CostMainheadSetup_txtBankDescription").textbox("setText", "");
                }
            },
            failure: function (response) {

            }
        });
    }


</script>
