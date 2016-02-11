<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TransactionEntry.aspx.cs" Inherits="Muntazm.TransactionEntry"  %>
<form runat="server">
        <div class="easyui-panel" title="Transaction Entry" style="width:910px;">
            <div class="easyui-panel" style="width:90%; padding:5px; margin-top:5px; margin-left:10px;" data-options="border:false">
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="TransactionEntry_New()">New</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="TransactionEntry_Save()">Save</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-attachment',plain:true" onclick="$('#TransactionEntry_dlgAttachments').dialog('open');TransactionEntry_GetAttachments();">Attachments</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" onclick="$('#TransactionEntry_dlgPrint').dialog('open');">Print</a>
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick = "removePanel()">Close</a>
            </div>
            <div style="height:42px; float:left; margin: 5px 10px 10px;">
                <div style="margin-top:10px; width:150px; height:42px; text-align:left; margin:0px 10px; float:left;">
                    <label class="lblCaption">Voucher#:</label>
                    <input type="text" id="TransactionEntry_txtVoucherNo" class="easyui-textbox" style="float:left; margin-top:4px; width:148px;" data-options="disabled:true">
                </div>
                <div style="margin-top:10px; width:179px; height:42px; text-align:left; margin:0px 10px; float:left;">
                    <label class="lblCaption">Voucher Type:</label><br />
                    <select id="TransactionEntry_DropDownVoucherType" class="easyui-combobox" style="float:left; margin-top:4px; width:177px;">
                        <option value="J1">(J1) No Cash or Bank JV</option>
                        <option value="J2">(J2) Intertransfer of Funds JV</option>
                        <option value="J3">(J3) Generic JV</option>
                        <option value="SV">(SV) Sales Voucher</option>
                        <option value="PV">(PV) Purchase Voucher</option>
                    </select>
                </div>

                <div style="margin-top:10px; width:150px; height:42px; text-align:left; margin:0px 10px; float:left;">
                    <label class="lblCaption">Branch:</label>
                    <select id="TransactionEntry_DropDownBranch" class="easyui-combobox" style="float:left; margin-top:4px; width:148px;">
                    </select>
                </div>

                <div style="margin-top:10px; width:150px; height:42px; text-align:left; margin:0px 10px; float:left;">
                    <label class="lblCaption">Project:</label>
                    <select id="TransactionEntry_DropDownProject" class="easyui-combobox" style="float:left; margin-top:4px; width:148px;">
                    </select>
                </div>

            </div>

            <div style="height:42px; float:left; margin:10px; margin-top:0px;">
                <div style="margin-top:10px; width:150px; height:42px; text-align:left; margin:0px 10px; float:left;">
                    <label class="lblCaption">Transaction Date:</label>
                    <input type="text" id="TransactionEntry_txtDate" class="easyui-datebox" style="float:left; margin-top:4px; width:148px;" data-options="formatter:myformatter,parser:myparser" />
                </div>
                <div style="margin-top:10px; width:190px; height:42px; text-align:left; margin:0px 10px; float:left;">
                    <label class="lblCaption">Currency:</label>
                    <div>
                        <select id="TransactionEntry_CurrencyCombo" class="easyui-combobox" style="float:left; margin-top:4px; width:110px;" data-options="required:true">
                        </select>
                        <label class="lblCaption"><input type="checkbox" id="TransactionEntry_chkCurrency" />Change</label>
                    </div>
                </div>

                <div style="margin-top:10px; width:190px; height:42px; text-align:left; margin:0px 0px; float:left;">
                    <label class="lblCaption">Exchange Rate:</label>
                    <div>
                        <input type="text" id="TransactionEntry_txtExchangeRate" class="easyui-textbox" style="float:left; margin-top:4px; width:110px;" data-options="disabled:true" />
                        <label class="lblCaption"><input type="checkbox" id="TransactionEntry_chkExchangeRate" />Change</label>
                    </div>
                </div>

                
            </div>

            <div style="width:825px; height:42px; text-align:left; float:left; margin: 0 10px;">
                
                <div style="height:42px; margin:0px 10px; width:812px;">
                    <label class="lblCaption">Voucher Narration:</label>
                    <input type="text" id="TransactionEntry_txtVoucherNarration" class="easyui-textbox" style="float:left; margin-top:4px; width:810px;" />
                </div>
            </div>

            <div style="width:875px; height:auto; text-align:left; float:left; margin:10px; padding:5px; margin-bottom:5px;">
                 <table id="TransactionEntry_tblEntry" title="Transaction Entry" style="margin-bottom:10px; height:255px;" class="easyui-datagrid" data-options="
                    data: [],
                    singleSelect: true,
                    toolbar: '#TransactionEntry_tb',
                    showFooter: true,
                    onClickCell: function (index, field, value) {
                        TransactionEntry_onClickCell(index, field, value);
                    },
                    rowStyler: function(index,row){
                        if ((row.Debit < 0 || row.Debit > 0) && (row.Credit < 0 || row.Credit > 0)){
                            
                            return 'background-color:red;color:#fff;';
                        }
                    },
                    onEndEdit: function(index,row,changes) {
                         if ((row.Debit < 0 || row.Debit > 0) && (row.Credit < 0 || row.Credit > 0)){
                            
                            $.messager.alert('Error','Debit and Credit cannot be in same row.','error');
                        }
                    },
                    onSelect: function(index,row) {
                        if(TransactionEntry_ComboGridOpened == false)
                        {
                            $(this).datagrid('endEdit',TransactionEntry_editIndex);
                            $(this).datagrid('beginEdit',index);
                            var ed = $('#TransactionEntry_tblEntry').datagrid('getEditor', { index: index, field: 'AccountCode' });
                            if (ed) {
                                $(ed.target).textbox('textbox').focus();
                            }
                            TransactionEntry_editIndex = index;
                        }
                    },
                    onAfterEdit: function(index,row,changes) {
                        if(TransactionEntry_AccountDescription != undefined){
                            $(this).datagrid('updateRow', {index:index,row:{Description:TransactionEntry_AccountDescription}});
                            TransactionEntry_AccountDescription=undefined;
                        }
                        TransactionEntry_CalcAmount();
                    },
                    onLoadSuccess: function() {
                            TransactionEntry_CalcAmount();
                    },
                     ">
                    <thead>
                        <tr>
                            <th data-options="field:'AccountCode',width:150,editor:{type:'combogrid',options:{
                                columns:[[
                                            {field:'AccountCode',title:'Code',width:150,align:'center'},
                                            {field:'Catagories',title:'Category',width:250},
                                            {field:'Description',title:'Description',width:250}
                                        ]],
                                idField: 'AccountCode',
	    						textField: 'AccountCode',
                                panelWidth: 655,
                                fitColumns:true,
                                onShowPanel: function(){
                                    TransactionEntry_ComboGridOpened=true;
                                    TransactionEntry_FillComboGrid(this,'');
                                },
                                onChange: function(newValue, oldValue){
                                    TransactionEntry_FillComboGrid(this,newValue);
                                },
                                onHidePanel: function() {
                                    TransactionEntry_ComboGridOpened=false;
                                }
                                }}
                                ">Account Code</th>
                            <th data-options="field:'Description',width:261,editor:{type:'textbox',options:{disabled:true}}">Account Description</th>
                            <th data-options="field:'LineDescription',width:261,editor:'textbox'">Line Description</th>
                            <th data-options="field:'Debit',width:100,align:'right',editor:{type:'numberbox',options:{
                                precision:2,
                                groupSeparator:','
                                }},
                                formatter: function(value) {
                                    if(!value) { value=0; }
                                    if(value.toString().search(':') != -1){
                                        return parseFloat(value.substr(value.search(':')+1)).toLocaleString();
                                    }
                                    else{
                                        return parseFloat(value).toLocaleString();
                                    }
                                }
                                ">Debit</th>
                            <th data-options="field:'Credit',width:100,align:'right',editor:{type:'numberbox',options:{
                                precision:2,
                                groupSeparator:','
                                }},
                                formatter: function(value) {
                                    if(!value) { value=0; }
                                    if(value.toString().search(':') != -1){
                                        return parseFloat(value.substr(value.search(':')+1)).toLocaleString();
                                    }
                                    else{
                                        return parseFloat(value).toLocaleString();
                                    }
                                }
                                ">Credit</th>
                        </tr>
                    </thead>
                </table>

                    <div id="TransactionEntry_tb" style="height:auto">
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-tableinsertrow',plain:true" onclick="TransactionEntry_append()">Insert</a>
                        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-tabledeleterow',plain:true" onclick="TransactionEntry_removeit()">Remove</a>
                    </div>
            </div>
        </div>
</form>

<form id="frmFiles" action="TransactionEntry.aspx" method="post" enctype="multipart/form-data" style="display:none;">
    <input type="file" onchange="TransactionEntry_UploadFiles();" id="TransactionEntry_Attachments" name="TransactionEntry_Attachments" multiple />
    <input type="hidden" id="TransactionEntry_HiddenBranchCode" name="TransactionEntry_HiddenBranchCode" />
    <input type="hidden" id="TransactionEntry_HiddenYear" name="TransactionEntry_HiddenYear" />
    <input type="hidden" id="TransactionEntry_HiddenMonth" name="TransactionEntry_HiddenMonth" />
    <input type="hidden" id="TransactionEntry_HiddenVoucherTypeCode" name="TransactionEntry_HiddenVoucherTypeCode" />
    <input type="hidden" id="TransactionEntry_HiddenVoucherCode" name="TransactionEntry_HiddenVoucherCode" />
</form>

<div id="TransactionEntry_dlgProgess" class="easyui-dialog" title="Uploading Files" data-options="modal:true,closed:true" style="width:350px;height:150px;padding:10px">
    <label class="lblCaption" style="position:relative; top:18px;">Please wait attachments are uploading to the server.</label>
    <div id="TransactionEntry_pbFiles" class="easyui-progressbar" data-options="value:80" style="width:99%; margin-top:20px;"></div>
</div>

<div id="TransactionEntry_dlgAttachments" class="easyui-dialog" title="Attachments" data-options="modal:true,closed:true" style="width:435px;height:350px;padding:10px">
    <ul id="TransactionEntry_listAttachments" class="easyui-datalist" title="Attachments List" lines="true" style="width:400px;height:250px">
        
    </ul>
    <div style="margin-top:15px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="$('#TransactionEntry_Attachments').trigger('click');">Add</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="TransactionEntry_DeleteFiles();">Delete</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="TransactionEntry_DownloadFiles();">Open File</a>
    </div>
</div>

<div id="TransactionEntry_dlgPrint" class="easyui-dialog" title="Print" data-options="modal:true,closed:true" style="width:350px;height:150px;padding:10px">
    <fieldset style="border: 1px solid rgb(217, 217, 217); color: #0e2d5f;">
        <legend>Print Options</legend>
        <label class="lblCaption"><input type="radio" id="" name="optPrint" />Print Voucher in Base Currency</label><br />
        <label class="lblCaption"><input type="radio" id="" name="optPrint" />Print Voucher in Foreign Currency</label>
    </fieldset>
    <div style="margin-top:5px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-print',plain:true" onclick="alert('Print code goes here');">Print</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="$('#TransactionEntry_dlgPrint').dialog('close');">Cancel</a>
    </div>
    
</div>

<script>

    var TransactionEntry_Action;

    $(document).ready(function () {

        $('#TransactionEntry_chkCurrency').change(function () {
            if ($(this).is(":checked")) {
                
                $("#TransactionEntry_CurrencyCombo").combobox({ disabled: false });
                
            }
            else {
                $("#TransactionEntry_CurrencyCombo").combobox({ disabled: true });
            }
        });

        $('#TransactionEntry_chkExchangeRate').change(function () {
            if ($(this).is(":checked")) {

                $("#TransactionEntry_txtExchangeRate").textbox({ disabled: false });

            }
            else {
                $("#TransactionEntry_txtExchangeRate").textbox({ disabled: true });
            }
        });

        TransactionEntry_LoadBranchCombo();
        
    });

    function TransactionEntry_LoadBranchCombo() {

        $.ajax({
            type: "POST",
            url: "AjaxFunctions.aspx/LoadBranchCombo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                    $("#TransactionEntry_DropDownBranch").combobox({
                        valueField: 'BranchCode',
                        textField: 'Description',
                        data: JSON.parse(response.d)
                    });

                    TransactionEntry_LoadCurrencyCombo();
                    //var panel = $('#TransactionEntry_tblEntry').datagrid('getPanel').attr('tabindex', 0).focus();
                    //panel.bind('keydown', function (e) {
                    //    switch (e.keyCode) {
                    //        case 38:    // up
                    //            TransactionEntry_selectRow(true);
                    //            return false;
                    //        case 40:    // down
                    //            TransactionEntry_selectRow(false);
                    //            return false;
                    //    }
                    //});

                }
            }
        });
    }

    //function TransactionEntry_selectRow(up) {
    //    if (TransactionEntry_ComboGridOpened == false)
    //    {
    //        var t = $('#TransactionEntry_tblEntry');
    //        var count = t.datagrid('getRows').length;    // row count
    //        var selected = t.datagrid('getSelected');
    //        if (selected) {
    //            var index = t.datagrid('getRowIndex', selected);
    //            index = index + (up ? -1 : 1);
    //            if (index < 0) index = 0;
    //            if (index >= count) index = count - 1;
    //            t.datagrid('clearSelections');
    //            t.datagrid('selectRow', index);
    //        } else {
    //            t.datagrid('selectRow', (up ? count - 1 : 0));
    //        }
    //    }
    //}
    

    function TransactionEntry_LoadProjectCombo() {
        
        $.ajax({
            type: "POST",
            url: "AjaxFunctions.aspx/LoadProjectCombo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                    $("#TransactionEntry_DropDownProject").combobox({
                        valueField: 'ProjectCode',
                        textField: 'Description',
                        data: JSON.parse(response.d)
                    });
                    $('#TransactionEntry_tblEntry').datagrid('enableCellEditing').datagrid('gotoCell', {
                        index: 0,
                        field: 'AccountCode'
                    });
                    if (Global_LoadVoucher == true) {
                        TransactionEntry_LoadVoucher();
                    }
                    else {
                        TransactionEntry_New();
                    }

                }
            }
        });
    }

    function TransactionEntry_LoadCurrencyCombo() {

        $.ajax({
            type: "POST",
            url: "AjaxFunctions.aspx/LoadCurrencyCombo",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                    $("#TransactionEntry_CurrencyCombo").combobox({
                        disabled: true,
                        valueField: 'CurCode',
                        textField: 'CurDesc',
                        data: JSON.parse(response.d),

                        onSelect: function () {

                            getValue("SELECT ExchangeRate FROM ExchangeRate WHERE CurCode = '" + $(this).combobox('getValue') + "'", "Accounts", "TransactionEntry_txtExchangeRate");
                        }
                    });

                    TransactionEntry_LoadProjectCombo();

                }
            }
        });
    }

    function myformatter(date) {
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        var d = date.getDate();
        return (d < 10 ? ('0' + d) : d) + '-' + (m < 10 ? ('0' + m) : m) + '-' + y;
    }
    function myparser(s) {
        if (!s) return new Date();
        var ss = (s.split('-'));
        var y = parseInt(ss[0], 10);
        var m = parseInt(ss[1], 10);
        var d = parseInt(ss[2], 10);
        if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
            return new Date(d, m - 1, y);
        } else {
            return new Date();
        }
    }


    var TransactionEntry_editIndex = undefined;
    var TransactionEntry_ComboGridOpened = false;

    function TransactionEntry_CalcAmount() {
        var DebitAmount = 0;
        var CreditAmount = 0;
        for (var i = 0; i < $('#TransactionEntry_tblEntry').datagrid('getRows').length; i++) {
            DebitAmount += parseFloat($('#TransactionEntry_tblEntry').datagrid('getRows')[i]['Debit'].toString().replace(',', ''));
            CreditAmount += parseFloat($('#TransactionEntry_tblEntry').datagrid('getRows')[i]['Credit'].toString().replace(',', ''));
        }

        $('#TransactionEntry_tblEntry').datagrid('reloadFooter', [
            { LineDescription: "Difference: " + (parseFloat(DebitAmount - CreditAmount).toLocaleString()), Debit: "Total: " + DebitAmount, Credit: "Total: " + CreditAmount }
        ]);
    }

    function TransactionEntry_endEditing() {
        //if (TransactionEntry_editIndex == undefined) { return true }
        //if ($('#TransactionEntry_tblEntry').datagrid('validateRow', TransactionEntry_editIndex)) {
        //    var ed = $('#TransactionEntry_tblEntry').datagrid('getEditor', { index: TransactionEntry_editIndex, field: 'AccountCode' });
        //    var AccountCode = $(ed.target).combobox('getText');
        //    $('#TransactionEntry_tblEntry').datagrid('getRows')[TransactionEntry_editIndex]['AccountCode'] = AccountCode;
        //    $('#TransactionEntry_tblEntry').datagrid('endEdit', TransactionEntry_editIndex);
        //    TransactionEntry_editIndex = undefined;
            
        //    return true;
        //} else {
        //    return false;
        //}
    }
    function TransactionEntry_onClickCell(index, field, value) {

        //if (TransactionEntry_editIndex != index) {
        //    if (TransactionEntry_endEditing()) {
        //        $('#TransactionEntry_tblEntry').datagrid('selectRow', index)
        //                .datagrid('beginEdit', index);
        //        var ed = $('#TransactionEntry_tblEntry').datagrid('getEditor', { index: index, field: field });
        //        if (ed) {
                    
        //            if (field != "AccountCode")
        //            {
        //                ($(ed.target).data('textbox') ? $(ed.target).textbox('textbox') : $(ed.target)).focus();
        //            }
        //        }
                
        //        TransactionEntry_editIndex = index;
        //    } else {
        //        $('#TransactionEntry_tblEntry').datagrid('selectRow', TransactionEntry_editIndex);
        //    }
        //}
    }
    function TransactionEntry_append() {
        
        $('#TransactionEntry_tblEntry').datagrid('appendRow', { Debit: '0', Credit: '0' });
        TransactionEntry_editIndex = $('#TransactionEntry_tblEntry').datagrid('getRows').length - 1;

        //if (TransactionEntry_endEditing()) {
        //    $('#TransactionEntry_tblEntry').datagrid('appendRow', { Debit: '0', Credit: '0' });
        //    TransactionEntry_editIndex = $('#TransactionEntry_tblEntry').datagrid('getRows').length - 1;
        //    $('#TransactionEntry_tblEntry').datagrid('selectRow', TransactionEntry_editIndex)
        //            .datagrid('beginEdit', TransactionEntry_editIndex);
        //    var ed = $('#TransactionEntry_tblEntry').datagrid('getEditor', { index: TransactionEntry_editIndex, field: 'AccountCode' });
        //    if (ed) {

        //        $(ed.target).textbox('textbox').focus();

        //    }
        //}
    }

    var TransactionEntry_AccountDescription = undefined;

    function TransactionEntry_FillComboGrid(ComboGrid,Filter) {
        var VoucherType = $('#TransactionEntry_DropDownVoucherType').combobox('getValue');
        var Branch = $('#TransactionEntry_DropDownBranch').combobox('getValue');
        var data;
        if (VoucherType == 'J1') {
            data = { filter: "WHERE (COA.AccountCode LIKE '%" + Filter + "%' OR COA.Description LIKE '%" + Filter + "%' OR COA.Catagories LIKE '%" + Filter + "%') AND SUBSTRING(COA.AccountCode,7,5) <> '02-06' AND COA.BranchCode='" + Branch + "'" };
        }
        else if (VoucherType == 'J2') {
            data = { filter: "WHERE (COA.AccountCode LIKE '%" + Filter + "%' OR COA.Description LIKE '%" + Filter + "%' OR COA.Catagories LIKE '%" + Filter + "%') AND SUBSTRING(COA.AccountCode,7,5) = '02-06' AND COA.BranchCode='" + Branch + "'" };
        }
        else if (VoucherType == 'J3') {
            data = { filter: "WHERE (COA.AccountCode LIKE '%" + Filter + "%' OR COA.Description LIKE '%" + Filter + "%' OR COA.Catagories LIKE '%" + Filter + "%') AND COA.BranchCode='" + Branch + "'" };
        }
        else {
            data = { filter: "WHERE (COA.AccountCode LIKE '%" + Filter + "%' OR COA.Description LIKE '%" + Filter + "%' OR COA.Catagories LIKE '%" + Filter + "%') AND COA.BranchCode='" + Branch + "'" };
        }
        data = JSON.stringify(data);
        var g = $(ComboGrid).combogrid('grid');
        $.ajax({
            type: "POST",
            url: "AjaxFunctions.aspx/GetAccounts",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                g.datagrid({
                    data: JSON.parse(response.d),
                    onSelect: function (index, row) {
                        TransactionEntry_AccountDescription = row.Description;
                    },
                    onDblClickRow: function (index, row) {
                        TransactionEntry_AccountDescription = row.Description;
                    }
                });
            },
            failure: function (response) {

            }
        });
    }

    function TransactionEntry_removeit() {
        //if (TransactionEntry_editIndex == undefined) { return }
        //$('#TransactionEntry_tblEntry').datagrid('cancelEdit', TransactionEntry_editIndex)
        //        .datagrid('deleteRow', TransactionEntry_editIndex);
        //TransactionEntry_editIndex = undefined;
        var param = $('#TransactionEntry_tblEntry').datagrid('cell');
        if (param) {
            $('#TransactionEntry_tblEntry').datagrid('cancelEdit', param.index)
                .datagrid('deleteRow', param.index);
            TransactionEntry_CalcAmount();
        }
    }
    function TransactionEntry_accept() {
        if (TransactionEntry_endEditing()) {
            $('#TransactionEntry_tblEntry').datagrid('acceptChanges');
        }
    }
    function TransactionEntry_reject() {
        $('#TransactionEntry_tblEntry').datagrid('rejectChanges');
        TransactionEntry_editIndex = undefined;
    }
    function TransactionEntry_getChanges() {
        var rows = $('#TransactionEntry_tblEntry').datagrid('getChanges');
        alert(rows.length + ' rows are changed!');
    }

    function TransactionEntry_New() {

        TransactionEntry_Action = "add";
        $("#TransactionEntry_txtVoucherNo").textbox('setText', '(Auto)');
        var today = new Date();
        var dd = today.getDate();
        var mm = today.getMonth() + 1; //January is 0!

        var yyyy = today.getFullYear();
        if (dd < 10) {
            dd = '0' + dd
        }
        if (mm < 10) {
            mm = '0' + mm
        }
        var today = dd + '-' + mm + '-' + yyyy;
        $('#TransactionEntry_txtDate').datebox('setValue', today);
        $("#TransactionEntry_DropDownBranch").combobox('select', '');
        $("#TransactionEntry_DropDownProject").combobox('select', '');
        $("#TransactionEntry_chkCurrency").prop("checked", false);
        $("#TransactionEntry_chkExchangeRate").prop("checked", false);
        $("#TransactionEntry_CurrencyCombo").combobox({ disabled: true });
        $("#TransactionEntry_txtExchangeRate").textbox({ disabled: true });
        $("#TransactionEntry_txtVoucherNarration").textbox('setText', '');
        $('#TransactionEntry_tblEntry').datagrid({ data: [] });
        $('#TransactionEntry_Attachments').val('');
        TransactionEntry_editIndex = undefined;

        $.ajax({
            type: "POST",
            url: "AjaxFunctions.aspx/GetBaseCurrency",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                $("#TransactionEntry_CurrencyCombo").combobox('select', response.d);
            }
        });
    }

    function TransactionEntry_Add() {
        
        if (!$("#TransactionEntry_txtVoucherNo").textbox('getText'))
        {
            alertify.error("Error: Voucher Code is missing.");
            return;
        }

        var DebitAmount = 0;
        var CreditAmount = 0;
        for (var i = 0; i < $('#TransactionEntry_tblEntry').datagrid('getRows').length; i++) {
            DebitAmount += parseFloat($('#TransactionEntry_tblEntry').datagrid('getRows')[i]['Debit']);
            CreditAmount += parseFloat($('#TransactionEntry_tblEntry').datagrid('getRows')[i]['Credit']);
        }

        if (DebitAmount - CreditAmount !== 0) {
            $.messager.alert('Error', 'Diffrence must be equal to 0.', 'error');
            return;
        }

        var VoucherCode = $("#TransactionEntry_txtVoucherNo").textbox('getText');
        var BranchCode = $("#TransactionEntry_DropDownBranch").combobox('getValue');
        var ProjectCode = $("#TransactionEntry_DropDownProject").combobox('getValue');
        var VoucherTypeCode = $("#TransactionEntry_DropDownVoucherType").combobox('getValue');
        var Currency = $("#TransactionEntry_CurrencyCombo").combobox('getText');
        var ExchangeRate = $("#TransactionEntry_txtExchangeRate").textbox('getText');
        var Date = $("#TransactionEntry_txtDate").datebox('getValue');
        var Month = GetMonth(Date);
        var Year = FinancialYear(Date);
        var Note = $("#TransactionEntry_txtVoucherNarration").textbox('getText');
        var Debit = 0;
        var Credit = 0;
        var Rows = $('#TransactionEntry_tblEntry').datagrid('getRows');

        for (var i = 0; i < Rows.length; i++) {

            if (Rows[i].AccountCode == "" || Rows[i].Description == "") {

                $.messager.alert('Error', 'Enter Complete Data in Datagrid.', 'error');
                return;
            }

            if ((Rows[i].Debit < 0 || Rows[i].Debit > 0) && (Rows[i].Credit < 0 || Rows[i].Credit > 0)) {

                $.messager.alert('Error', 'Debit and Credit cannot be in same row.', 'error');
                return;
            }
        }

        Rows = JSON.stringify(Rows);
        Date = GetSqlDate(Date);

        $.messager.confirm('Save Record', 'Do you want to save this record.?', function (r) {
            if (r) {

                var data = {
                    VoucherCode: VoucherCode,
                    BranchCode: BranchCode,
                    VoucherTypeCode: VoucherTypeCode,
                    Date: Date,
                    Month: Month,
                    Year: Year,
                    Note: Note,
                    Debit: Debit,
                    Credit: Credit,
                    Rows: Rows,
                    Currency: Currency,
                    ExchangeRate: ExchangeRate,
                    ProjectCode: ProjectCode
                }

                data = JSON.stringify(data);

                $.ajax({
                    type: "POST",
                    url: "TransactionEntry.aspx/Add",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                            alertify.error(response.d);
                        }
                        else {
                            alertify.success(response.d);
                            TransactionEntry_UploadFiles();
                            if (TransactionEntry_Action == "add") {

                                TransactionEntry_Action = "update";
                            }
                        }
                    },
                    failure: function (response) {

                    }
                });

            }
        });
    }

    function TransactionEntry_Save() {

        if (!$("#TransactionEntry_DropDownVoucherType").combobox('getValue')) {
            alertify.error("Error: Voucher type is missing.");
            return;
        }
        else if (!$('#TransactionEntry_txtDate').datebox('getValue')) {
            alertify.error("Error: Transaction date is missing.");
            return;
        }
        else if (!$("#TransactionEntry_DropDownBranch").combobox('getValue')) {
            alertify.error("Error: Branch is missing.");
            return;
        }
        else if (!$("#TransactionEntry_DropDownProject").combobox('getValue')) {
            alertify.error("Error: Project is missing.");
            return;
        }
        else if (!$("#TransactionEntry_CurrencyCombo").combobox('getValue')) {
            alertify.error("Error: Currency is missing.");
            return;
        }
        else if (!$("#TransactionEntry_txtExchangeRate").textbox('getText')) {
            alertify.error("Error: Exchange Rate is missing.");
            return;
        }
        else if (!$("#TransactionEntry_txtVoucherNarration").textbox('getText')) {
            alertify.error("Error: Voucher Narration is missing.");
            return;
        }

        if (TransactionEntry_Action == "add") {

            TransactionEntry_GetMaxId();
        }
        else if (TransactionEntry_Action == "update") {
            TransactionEntry_Add();
        }
    }

    function TransactionEntry_GetMaxId() {

        var VoucherTypeCode = $("#TransactionEntry_DropDownVoucherType").combobox("getValue");
        var Month = GetMonth($('#TransactionEntry_txtDate').datebox('getValue'));
        var Year = FinancialYear($('#TransactionEntry_txtDate').datebox('getValue'));
        var data = { VoucherTypeCode: VoucherTypeCode, Month: Month, Year: Year }
        data = JSON.stringify(data);

        $.ajax({
            type: "POST",
            url: "TransactionEntry.aspx/GetMaxId",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {

                    $("#TransactionEntry_txtVoucherNo").textbox("setText", response.d);
                    TransactionEntry_Add();
                }
            },
            failure: function (response) {

            }
        });
    }

    function TransactionEntry_UploadFiles()
    {

        var files = document.getElementById('TransactionEntry_Attachments').files;
        if (files.length == 0) {
            return;
        }
        ajax = new XMLHttpRequest();
        var BranchCode = $("#TransactionEntry_DropDownBranch").combobox('getValue');
        var Date = $("#TransactionEntry_txtDate").datebox('getValue');
        var Year = FinancialYear(Date);
        var Month = GetMonth(Date);
        var VoucherTypeCode = $("#TransactionEntry_DropDownVoucherType").combobox('getValue');
        var VoucherCode = $("#TransactionEntry_txtVoucherNo").textbox('getText');
        if (VoucherCode == "(Auto)") {
            return;
        }
        var data = new FormData();
        data.append('Action', 'Upload');
        data.append('BranchCode', BranchCode);
        data.append('Year', Year);
        data.append('Month', Month);
        data.append('VoucherTypeCode', VoucherTypeCode);
        data.append('VoucherCode', VoucherCode);
        var dlRows = $("#TransactionEntry_listAttachments").datalist('getRows');
        var AlreadyExists = false;
        var ExistFiles=[];
        var ExistIndex = 0;
        for (var file in files) {
            AlreadyExists = false;
            for (var i = 0; i < dlRows.length; i++) {
                if (dlRows[i].FileName == files[file].name) {
                    AlreadyExists = true;
                }
            }
            if (AlreadyExists == false)
            {
                data.append(files[file].name, files[file]);
            }
            else if (AlreadyExists == true)
            {
                ExistFiles[ExistIndex] = files[file].name;
                ExistIndex++;
            }
        }
        $('#TransactionEntry_pbFiles').progressbar('setValue', 0);
        $('#TransactionEntry_dlgProgess').dialog('open');
        ajax.onreadystatechange = function () {

            if (ajax.status) {

                if (ajax.status == 200 && (ajax.readyState == 4)) {
                    //To do tasks if any if upload is completed
                    $('#TransactionEntry_dlgProgess').dialog('close');
                }
            }
        }
        ajax.upload.addEventListener("progress", function (event) {

            var percent = (event.loaded / event.total) * 100;
            $('#TransactionEntry_pbFiles').progressbar('setValue', Math.round(percent));

            if (percent >= 100) {
                $('#TransactionEntry_dlgProgess').dialog('close');
                if (ExistFiles.length > 0) {
                    var msg = "File(s) already exists with same name and not uploaded.";
                    for (var i = 0; i < ExistFiles.length; i++) {
                        msg = msg + "<li>" + ExistFiles[i] + "</li>";
                    }
                    msg = "<ul>" + msg + "</ul>";
                    $.messager.alert('Warning', msg, 'warning');
                }

                TransactionEntry_GetAttachments();
            }
        });

        ajax.open("POST", 'TransactionEntry.aspx', true);
        ajax.send(data);
    }

    function TransactionEntry_DownloadFiles() {

        var BranchCode = $("#TransactionEntry_DropDownBranch").combobox('getValue');
        var Date = $("#TransactionEntry_txtDate").datebox('getValue');
        var Year = FinancialYear(Date);
        var Month = GetMonth(Date);
        var VoucherTypeCode = $("#TransactionEntry_DropDownVoucherType").combobox('getValue');
        var VoucherCode = $("#TransactionEntry_txtVoucherNo").textbox('getText');
        var FileName = $("#TransactionEntry_listAttachments").datalist('getSelected').FileName;

        var iframe = document.createElement("iframe");
        iframe.src = "TransactionEntry.aspx?Action=Download&BranchCode=" + BranchCode + "&Year=" + Year + "&Month=" + Month + "&VoucherTypeCode=" + VoucherTypeCode + "&VoucherCode=" + VoucherCode + "&FileName=" + FileName;
        iframe.style.display = "none";
        document.body.appendChild(iframe);

    }

    function TransactionEntry_GetAttachments()
    {
        var BranchCode = $("#TransactionEntry_DropDownBranch").combobox('getValue');
        var Date = $("#TransactionEntry_txtDate").datebox('getValue');
        var Year = FinancialYear(Date);
        var Month = GetMonth(Date);
        var VoucherTypeCode = $("#TransactionEntry_DropDownVoucherType").combobox('getValue');
        var VoucherCode = $("#TransactionEntry_txtVoucherNo").textbox('getText');

        if (VoucherCode == "(Auto)") {
            return;
        }

        var data = {
            BranchCode: BranchCode,
            Year: Year,
            Month: Month,
            VoucherTypeCode: VoucherTypeCode,
            VoucherCode: VoucherCode
        };

        data = JSON.stringify(data);

        $.ajax({
            type: "POST",
            url: "TransactionEntry.aspx/GetAttachments",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                    alertify.error(response.d);
                }
                else {
                        $("#TransactionEntry_listAttachments").datalist({
                            valueField: 'AttachID',
                            textField: 'FileName',
                            data: JSON.parse(response.d)
                        });
                }
            },
            failure: function (response) {

            }
        });

    }

    function TransactionEntry_DeleteFiles() {

        ajax = new XMLHttpRequest();
        var BranchCode = $("#TransactionEntry_DropDownBranch").combobox('getValue');
        var Date = $("#TransactionEntry_txtDate").datebox('getValue');
        var Year = FinancialYear(Date);
        var Month = GetMonth(Date);
        var VoucherTypeCode = $("#TransactionEntry_DropDownVoucherType").combobox('getValue');
        var VoucherCode = $("#TransactionEntry_txtVoucherNo").textbox('getText');
        var AttachID = $("#TransactionEntry_listAttachments").datalist('getSelected').AttachID;
        var FileName = $("#TransactionEntry_listAttachments").datalist('getSelected').FileName;
        var data = new FormData();
        data.append('Action', 'Delete');
        data.append('BranchCode', BranchCode);
        data.append('Year', Year);
        data.append('Month', Month);
        data.append('VoucherTypeCode', VoucherTypeCode);
        data.append('VoucherCode', VoucherCode);
        data.append('AttachID', AttachID);
        data.append('FileName', FileName);

        ajax.onreadystatechange = function () {

            if (ajax.status) {

                if (ajax.status == 200 && (ajax.readyState == 4)) {
                    //To do tasks if any if upload is completed
                    TransactionEntry_GetAttachments();
                }
            }
        }
        ajax.upload.addEventListener("progress", function (event) {

            var percent = (event.loaded / event.total) * 100;

        });

        ajax.open("POST", 'TransactionEntry.aspx', true);
        ajax.send(data);

    }

    function TransactionEntry_LoadVoucher()
    {
        if(Global_LoadVoucher == true)
        {
            var data = { VoucherCode: Global_VoucherCode, VoucherTypeCode: Global_VoucherTypeCode, Month: Global_VoucherMonth, Year: Global_VoucherYear, BranchCode: Global_BranchCode};
            data = JSON.stringify(data);
            $.ajax({
                type: "POST",
                url: "TransactionEntry.aspx/LoadVoucher",
                data: data,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    response = JSON.parse(response.d);
                    $("#TransactionEntry_txtVoucherNo").textbox('setText', response.VoucherCode);
                    $("#TransactionEntry_DropDownVoucherType").combobox('select', response.VoucherTypeCode);
                    $("#TransactionEntry_DropDownBranch").combobox('select', response.BranchCode);
                    $("#TransactionEntry_DropDownProject").combobox('select', response.ProjectCode);
                    $('#TransactionEntry_txtDate').datebox('setValue', response.Date);
                    $("#TransactionEntry_txtVoucherNarration").textbox('setText', response.Narration);
                    $("#TransactionEntry_CurrencyCombo").combobox('select', response.Currency);
                    $("#TransactionEntry_txtExchangeRate").textbox('setText', response.ExchangeRate);
                    $("#TransactionEntry_tblEntry").datagrid({
                        data: response.Rows
                    });
                    Global_LoadVoucher = false;
                    TransactionEntry_Action = "update";
                },
                failure: function (response) {

                }
            });
        }
    }

</script>