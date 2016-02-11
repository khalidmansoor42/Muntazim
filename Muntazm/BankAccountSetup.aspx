<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BankAccountSetup.aspx.cs" Inherits="Muntazm.BankAccountSetup" %>
    <form id="form1" runat="server">
            <div class="easyui-panel" title="Bank Account Setup" style="width:750px;">
            <div style="float:left; width:736px; margin-bottom:0px; margin-left: 5px; margin-right: 5px; margin-top: 10px; height: 210px; border-bottom:1px solid rgba(186, 180, 180, 0.59);">
                <div class="easyui-panel" style="width:45%; padding:5px; margin-top:5px; margin-left:10px;" data-options="border:false">
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick = "BankAccount_AddNew()" data-options="iconCls:'icon-add', plain:true">New</a>
                    <a href="javascript:void(0)" style="margin-left:4px;" class="easyui-linkbutton" onclick = "BankAccount_Save()"  data-options="iconCls:'icon-save', plain:true">Save</a>
                     <a href="javascript:void(0)" style="margin-left:4px;" class="easyui-linkbutton" data-options="iconCls:'icon-cancel', plain:true" onclick="BankAccount_DeleteSelectedRow()">Delete</a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick = "removePanel()"  data-options="iconCls:'icon-cancel', plain:true" style="margin-left:4px">Close</a>
                    </div>
                 <div style="margin-top:5px; margin-left:15px; width:44%; height:51px; text-align:left; float:left; ">
                    <label class="lblCaption">Bank :</label>
                    <select id="BankAccount_DropDownBanks" class="easyui-combobox" style="float:left; margin-top:5px; width:317px;" data-options="onSelect: function() { BankAccount_LoadBranchCombo($(this).combobox('getValue')); }, onChange: function() { $('#BankAccount_tblSetupBankAccount').datagrid({ data: [] });}">
                    </select>
                 </div>
             <div id="BankAccount_OpenBanksForm" style="width:10%; height:35px; text-align:left; float:left; margin-top:20px; margin-left:5px;">
                    <a href="javascript:void(0)" id="BankAccount_OpenBanks" onclick="addPanel('Banks','Banks.aspx')" class="easyui-linkbutton" data-options="iconCls:'icon-add'">New</a>
                </div>

                                   <div style="margin-top:5px; margin-left:8px; width:31%; height:51px; text-align:left; float:left; ">
                    <label class="lblCaption">Branch :</label>
                    <select id="BankAccount_DropDownBranches" class="easyui-combobox" style="float:left; margin-top:5px; width:222px;">
                    </select>
                 </div>

                <div style="width:9%; height:36px; text-align:left; float:left; margin-top:20px; margin-left:5px;">
                    <a href="javascript:void(0)" id="BankAccount_OpenBranches" class="easyui-linkbutton" onclick="addPanel('Bank Branches','BankBranches.aspx')" data-options="iconCls:'icon-add'">New</a>
                </div>

                <div style="width:19%; height:48px; text-align:left; margin-left:15px; margin-bottom:5px; float:left;">
                    <label class="lblCaption">Code:</label>
                    <input type="text" id="BankAccount_txtAccountCode" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:130px;" data-options="required:true, disabled:true" />
                </div>

                <div style="width:35%; height:47px; text-align:left; margin-left:5px; margin-bottom:5px; float:left;">
                    <label class="lblCaption">Description:</label>
                    <input type="text" id="BankAccount_txtAccountDescription" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:245px;" />
                </div>
            
               <div style="margin-left:5px; width:20%; height:52px; text-align:left; float:left; ">
                    <label class="lblCaption">Account Type:</label>
                    <select id="BankAccount_DropDownBankAccountType" class="easyui-combobox" style="float:left; margin-top:5px; width:134px;">
                        <option> </option>
                          <option>Current</option>
                        <option>Savings</option>
                        <option>Deposit</option>
                    </select>
                 </div>

                <div style="margin-left:6px; width:20%; height:53px; text-align:left; float:left;">
                    <label class="lblCaption">Account No:</label>
                    <input type="text" id="BankAccount_txtAccountNo" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:140px;" />
                </div>

                     <div style="margin-left:13px; width:19%; height:48px; text-align:left; float:left; ">
                    <label class="lblCaption">Currency:</label>
                    <select id="BankAccount_DropDownCurrency" class="easyui-combobox" style="float:left; margin-top:5px; width:130px;">
                    </select>
                 </div>

                <div style="margin-left:7px; width:28%; height:48px; text-align:left; float:left;">
                    <label class="lblCaption">Link GL Account:</label>
                    <input type="text" id="BankAccount_txtLinkGL" data-selectsql="SELECT AccountCode AS Code,Description FROM Account" data-filterfields="AccountCode,Description" data-fieldindex="0" data-searchtitle="Search" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:154px;" />
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="ShowSearchBox('BankAccount_txtLinkGL')"  data-options="iconCls:'icon-search',iconWidth:38"></a>
                </div>

                  <div style="width:20%; height:48px; text-align:left; margin-left:5px; margin-bottom:5px; float:left;">
                    <label class="lblCaption">Swift Code:</label>
                    <input type="text" id="BankAccount_txtSwiftCode" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:141px;" />
                </div>

                  <div style="width:28%; height:48px; text-align:left; margin-left:5px; margin-bottom:5px; float:left;">
                    <label class="lblCaption">IBAN:</label>
                    <input type="text" id="BankAccount_txtIBAN" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:194px;" />
                </div>
            </div>

            <div style="float:left; margin:0px 5px; width:736px;">
                <div style="margin-top:5px; width:45%; height:50px; text-align:left; margin:10px; float:left;">
                    <label class="lblCaption">Search:</label>
                    <input type="text" id="BankAccount_txtSearch" autocomplete="off" class="easyui-textbox" style="float:left; margin-top:4px; width:250px;" placeholder="Enter Search Text" data-options="iconCls:'icon-search',iconWidth:38" />
                </div>
                <div style="margin:5px; width:99%; height:auto; text-align:left; float:left;">
                <table id="BankAccount_tblSetupBankAccount" title="Bank Accounts" class="easyui-datagrid" data-options="toolbar: '#BankAccount_tblSetupBankAccount_ToolBar', pagination:true" style="margin-bottom:5px;">
                    <thead>
                        <tr>
                            <th data-options="field:'AccountCode',width:150,align:'center'">Code</th>
                            <th data-options="field:'Description',width:546,align:'left'">Description</th>
                        </tr>
                    </thead>
                </table>
                </div>
            </div>
        </div>
    </form>

    <div id="BankAccount_dialog" class="easyui-dialog" title="Banks" data-options="modal:true,closed:true, resizable:true, href:'Banks.aspx',top:5" style="width:632px; padding:10px;">  
    </div>
<div id="BankAccount_BranchesDialog" class="easyui-dialog" title="Bank Branches" data-options="model:true, closed:true, resizable:true, href:'BankBranches.aspx',top:5" style="width:632px; padding:10px;">
    </div>

<script type="text/javascript">
    var BankAccount_Action;
    var BankAccount_rId;
    $(document).ready(function () {

        BankAccount_Action = "add";
        BankAccount_LoadBanksCombo();
        BankAccount_LoadCurrencyCombo();

        $('#BankAccount_txtSearch').textbox({
            inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                keyup: function (e) {

                    BankAccount_fnLoadGrid(1, 10, "WHERE subheadid='" + $("#BankAccount_DropDownBranches").combobox('getValue') + "' AND Description LIKE '%" + $(this).val() + "%'");
                }
            })
        });
    });

    function BankAccount_Save() {

        if (BankAccount_Action == "add") {
            BankAccount_GetMaxId();
        }
        else if (BankAccount_Action == "update") {
            BankAccount_Update(BankAccount_rId);
        }
    }

    function BankAccount_Update(RowId) {
        var bankname = $("#BankAccount_DropDownBanks").combobox('getText');
        var branchname = $("#BankAccount_DropDownBranches").combobox('getText');
        var SubHeadId = $("#BankAccount_DropDownBranches").combobox('getValue');
        var accountcode = $("#BankAccount_txtAccountCode").textbox('getText');
        var description = $("#BankAccount_txtAccountDescription").textbox('getText');
        var accounttype = $("#BankAccount_DropDownBankAccountType").combobox('getText');
        var currency = $("#BankAccount_DropDownCurrency").combobox('getText');
        var glcode = $("#BankAccount_txtLinkGL").textbox('getText');
        var accountno = $("#BankAccount_txtAccountNo").textbox('getText');
        var swiftcode = $("#BankAccount_txtSwiftCode").textbox('getText');
        var iban = $("#BankAccount_txtIBAN").textbox('getText');
      
        if (!bankname) {
            alertify.error("Error:Please select Bank.");
            $("#BankAccount_DropDownBanks").combobox('textbox').focus();
            $("#BankAccount_txtAccountCode").textbox("setText", "(Auto)");
        }
        else if (!branchname) {
            alertify.error("Error: Please select Branch.");
            $("#BankAccount_DropDownBranches").combobox('textbox').focus();
            $("#BankAccount_txtAccountCode").textbox("setText", "(Auto)");
            return;
        }
        else if (!accountcode) {
            alertify.error("Error: Account Code is Missing.");
            $("#BankAccount_txtAccountCode").textbox('textbox').focus();
            $("#BankAccount_txtAccountCode").textbox("setText", "(Auto)");
            return;
        }
        else if (!description) {
            alertify.error("Error: Account Code description is Missing.");
            $("#BankAccount_txtAccountDescription").textbox('textbox').focus();
            $("#BankAccount_txtAccountCode").textbox("setText", "(Auto)");
            return;
        }
        else if (!currency) {
            alertify.error("Error: Please select currency.");
            $("#BankAccount_DropDownCurrency").combobox('textbox').focus();
            $("#BankAccount_txtAccountCode").textbox("setText", "(Auto)");
            return;
        }
      
        $.messager.confirm('Save Record', 'Do you want to save this record.?', function (r) {
            if (r) {

                var data = {
                    BankName: bankname,
                    BranchName: branchname,
                    SubHeadId: SubHeadId,
                    AccountCode: accountcode,
                    Description: description,
                    AccountType: accounttype,
                    Currency: currency,
                    GLCode: glcode,
                    AccountNo: accountno,
                    SwiftCode: swiftcode,
                    IBAN: iban
                }

                data = JSON.stringify(data);

                $.ajax({
                    type: "POST",
                    url: "BankAccountSetup.aspx/Update",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                            alertify.error(response.d);
                        }
                        else {
                            alertify.success(response.d);
                            BankAccount_fnLoadGrid(1, 10, "WHERE subheadid = '" +$(this).combobox('getValue') + "'");
                        }
                    },
                    failure: function (response) {

                    }
                });
            }
        });
    }

    function BankAccount_AddNew() {
        BankAccount_Action = "add";
        $('#BankAccount_tblSetupBankAccount').datagrid({ data: [] });
        $("#BankAccount_txtAccountCode").textbox("setText", "(Auto)");
        $("#BankAccount_txtAccountDescription").textbox("setText", "").textbox("textbox").focus();
        $("#BankAccount_DropDownBankAccountType").textbox("setValue", "");
        $("#BankAccount_DropDownCurrency").textbox("setValue", "");
        $("#BankAccount_txtLinkGL").textbox("setText", "");
        $("#BankAccount_txtLocation").textbox("setText", "");
        $("#BankAccount_txtAccountNo").textbox("setText", "");
        $("#BankAccount_txtSwiftCode").textbox("setText", "");
        $("#BankAccount_txtIBAN").textbox("setText", "");
    }

    function BankAccount_Add() {
        var bankname = $("#BankAccount_DropDownBanks").combobox('getText');
        var accountcode = $("#BankAccount_txtAccountCode").textbox('getText');
        var description = $("#BankAccount_txtAccountDescription").textbox('getText');
        var SubHeadId = $("#BankAccount_DropDownBranches").combobox('getValue');
        var branchname = $("#BankAccount_DropDownBranches").combobox('getText');
        var accounttype = $("#BankAccount_DropDownBankAccountType").combobox('getText');
        var currency = $("#BankAccount_DropDownCurrency").combobox('getText');
        var glcode = $("#BankAccount_txtLinkGL").textbox('getText');
        var accountno = $("#BankAccount_txtAccountNo").textbox('getText');
        var swiftcode = $("#BankAccount_txtSwiftCode").textbox('getText');
        var iban = $("#BankAccount_txtIBAN").textbox('getText');

        if (!bankname) {
            alertify.error("Error:Please select Bank.");
            $("#BankAccount_DropDownBanks").combobox('textbox').focus();
            $("#BankAccount_txtAccountCode").textbox("setText", "(Auto)");
            return;
        }
        else if (!branchname) {
            alertify.error("Error: Please select Branch.");
            $("#BankAccount_DropDownBranches").combobox('textbox').focus();
            $("#BankAccount_txtAccountCode").textbox("setText", "(Auto)");
            return;
        }
        else if (!accountcode) {
            alertify.error("Error: Account Code is Missing.");
            $("#BankAccount_txtAccountCode").textbox('textbox').focus();
            $("#BankAccount_txtAccountCode").textbox("setText", "(Auto)");
            return;
        }
        else if (!description) {
            alertify.error("Error: Account Code description is Missing.");
            $("#BankAccount_txtAccountDescription").textbox('textbox').focus();
            $("#BankAccount_txtAccountCode").textbox("setText", "(Auto)");
            return;
        }
        else if (!currency) {
            alertify.error("Error: Please select currency.");
            $("#BankAccount_DropDownCurrency").combobox('textbox').focus();
            $("#BankAccount_txtAccountCode").textbox("setText", "(Auto)");
            return;
        }

        $.messager.confirm('Save Record', 'Do you want to save this record.?', function (r) {
            if (r) {

                var data = {
                    BankName: bankname,
                    BranchName: branchname,
                    SubHeadId: SubHeadId,
                    AccountCode: accountcode,
                    Description: description,
                    AccountType: accounttype,
                    Currency: currency,
                    GLCode: glcode,
                    AccountNo: accountno,
                    SwiftCode: swiftcode,
                    IBAN: iban
                }

                data = JSON.stringify(data);

                $.ajax({
                    type: "POST",
                    url: "BankAccountSetup.aspx/Add",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                            alertify.error(response.d);
                           
                        }
                        else {
                            alertify.success(response.d);
                            BankAccount_fnLoadGrid(1, 10, $('#BankAccount_DropDownBranches').combobox('getValue'));
                        }
                    },
                    failure: function (response) {
                       
                    }
                });

            }
        });
    }

    function BankAccount_EditSelectedRow() {
        var selectedRow = $('#BankAccount_tblSetupBankAccount').datagrid('getSelected');
        BankAccount_GetRow(selectedRow.AccountCode);
    }

    function BankAccount_DeleteSelectedRow() {

        if ($("#BankAccount_txtAccountCode").textbox('getText') == "(Auto)" || $("#BankAccount_txtAccountCode").textbox('getText') == "") {

        }
        else {
            $.messager.confirm('Delete Record',
            "<ul style='list-style-type:none;margin:0px;padding:0px;'><li>You have selected.</li><li>Code : "
            + $("#BankAccount_txtAccountCode").textbox('getText')
            + " </li><li> Description : "
            + $("#BankAccount_txtAccountDescription").textbox('getText')
            + " </li><li Style = 'margin-left:42px';>Do you want to delete this record.?</li> </ul>"
            , function (r) {
                if (r) {
                    BankAccount_DeleteRow($("#BankAccount_txtAccountCode").textbox('getText'));
                }

            })
        }
    }

    function BankAccount_fnLoadGrid(PageNumber, PageSize, strFilter) {

        var data = { PageNumber: PageNumber, PageSize: PageSize, filter: strFilter }
        data = JSON.stringify(data);
        $.ajax({
            type: "POST",
            url: "BankAccountSetup.aspx/FillGrid",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {

                    $('#BankAccount_tblSetupBankAccount').datagrid({
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
                            BankAccount_GetRow(r.AccountCode);
                        },
                        onLoadSuccess: function (data) {
                            $('#BankAccount_tblSetupBankAccount').datagrid('getPager').pagination({
                                showRefresh: false,
                                onSelectPage: function (pageNumber, pageSize) {

                                    BankAccount_fnLoadGrid(pageNumber, pageSize, strFilter);
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

    function BankAccount_GetRow(RowId) {
        var data = { RowId: RowId }
        data = JSON.stringify(data);
        $.ajax({
            type: "POST",
            url: "BankAccountSetup.aspx/GetRow",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                    response = JSON.parse(response.d);
                    BankAccount_Action = "update";
                    BankAccount_rId = response.AccountCode;
                    $("#BankAccount_txtAccountCode").textbox("setText", response.AccountCode);
                    $("#BankAccount_txtAccountDescription").textbox("setText", response.Description);
                    $("#BankAccount_DropDownBanks").combobox("setValue", response.SubHeadId.split("-")[0]);
                    $("#BankAccount_DropDownBranches").combobox("setValue", response.SubHeadId);
                    $("#BankAccount_DropDownBankAccountType").textbox("setText", response.AccountType);
                    $("#BankAccount_DropDownCurrency").textbox("setText", response.Currency);
                    $("#BankAccount_txtLinkGL").textbox("setText", response.GLCode);
                    $("#BankAccount_txtAccountNo").textbox("setText", response.AccountNo);
                    $("#BankAccount_txtSwiftCode").textbox("setText", response.SwiftCode);
                    $("#BankAccount_txtIBAN").textbox("setText", response.IBAN);
                }
            },
            failure: function (response) {

            }
        });
    }

    function BankAccount_GetMaxId() {
        var data = { preFix: $("#BankAccount_DropDownBranches").combobox('getValue') + "-" }
        data = JSON.stringify(data);
        $.ajax({
            type: "POST",
            url: "BankAccountSetup.aspx/GetMaxId",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {

                    $("#BankAccount_txtAccountCode").textbox("setText", response.d);
                    BankAccount_Add();
                }
            },
            failure: function (response) {

            }
        });
    }

    function BankAccount_DeleteRow(RowId) {
                var data = { RowId: RowId }
                data = JSON.stringify(data);
                $.ajax({
                    type: "POST",
                    url: "BankAccountSetup.aspx/DeleteRow",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                            alertify.error(response.d);
                        }
                        else {
                            alertify.success(response.d);
                            BankAccount_fnLoadGrid(1, 10, $('#BankAccount_DropDownBranches').combobox('getValue'));
                            $("#BankAccount_txtAccountCode").textbox("setText", "");
                            $("#BankAccount_txtAccountDescription").textbox("setText", "");
                            $("#BankAccount_DropDownBankAccountType").combobox("setText", "");
                            $("#BankAccount_DropDownCurrency").combobox("setText", "");
                            $("#BankAccount_txtLinkGL").textbox("setText", "");
                            $("#BankAccount_txtLocation").textbox("setText", "");
                            $("#BankAccount_txtAccountNo").textbox("setText", "");
                            $("#BankAccount_txtSwiftCode").textbox("setText", "");
                            $("#BankAccount_txtIBAN").textbox("setText", "");
                        }
                    },
                    failure: function (response) {

                    }
                });
    }

    function BankAccount_LoadBanksCombo() {
        $.ajax({
            type: "POST",
            url: "BankAccountSetup.aspx/LoadBanksCombo",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                    $("#BankAccount_DropDownBanks").combobox({
                        valueField: 'id',
                        textField: 'Description',
                        data: JSON.parse(response.d),
                        onChange: function () {
                            BankAccount_AddNew($(this).combobox('getValue'));
                        }
                    });
                }
            }
        });
    }

    function BankAccount_LoadBranchCombo(Bank) {
        var data = { Bank: Bank }
        data = JSON.stringify(data);
        $.ajax({
            type: "POST",
            url: "BankAccountSetup.aspx/LoadBranchCombo",
            data: data,
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                    $("#BankAccount_DropDownBranches").combobox({
                        valueField: 'id',
                        textField: 'Description',
                        data: JSON.parse(response.d),
                        onSelect: function () {
                            BankAccount_fnLoadGrid(1, 10, "WHERE subheadid='" + $("#BankAccount_DropDownBranches").combobox('getValue') + "'");
                        },
                        onChange: function () {
                            BankAccount_AddNew($(this).combobox('getValue'));
                        }
                    });
                }
            }
        });
    }

    function BankAccount_LoadCurrencyCombo() {
        $.ajax({
            type: "POST",
            url: "BankAccountSetup.aspx/LoadCurrencyCombo",
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                    $("#BankAccount_DropDownCurrency").combobox({
                        valueField: 'CurCode',
                        textField: 'CurCode',
                        data: JSON.parse(response.d),
                        //onSelect: function () {
                        //    BankAccount_fnLoadGrid(1, 10, $(this).combobox('getValue'));
                        //}
                    });
                }
            }
        });
    }
</script>
