<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SearchRec.aspx.cs" Inherits="Muntazm.SearchRec" %>




 <form>
        <div class="easyui-panel" title="Search Record" style="width:675px;">
            <div style="float:left; margin:10px 5px; height:234px; width:657px; ">
                <input type="text" id="txt1" data-selectsql="SELECT MainHeadCode AS Code,Description FROM MainHeads" data-filterfields="MainHeadCode,Description" data-fieldindex="1" data-searchtitle="Search" class="easyui-textbox"   style="float:left; margin-top:4px; width:250px;" />
                <input type="text" id="txt2" data-selectsql="SELECT MainHeadCode AS Code,Description FROM MainHeads" data-filterfields="MainHeadCode,Description" data-fieldindex="1" data-searchtitle="Search" class="easyui-textbox"   style="float:left; margin-top:4px; width:250px;" />
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="ShowSearchBox('txt1')"  data-options="iconCls:'icon-search',iconWidth:38"></a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick=""  data-options="iconCls:'icon-search',iconWidth:38"></a>
                <a href="javascript:void(0)" class="easyui-linkbutton" onclick=""  data-options="iconCls:'icon-search',iconWidth:38"></a>
            </div>
        </div>

     <div id="SearchBox" class="easyui-dialog"  data-options="title:'My Dialog', modal:true, closed:true"  style="width:420px;height:440px;padding:10px">
            <div style="margin-top:10px; width:45%; height:50px; text-align:left; margin:10px; float:left;">
                    <label class="lblCaption">
                    Search:</label>
                    <input type="text" id="txtSearch" class="txtInput" style="float:left; margin-top:4px; width:250px;" placeholder="Enter Search Text" data-options="iconCls:'icon-search',iconWidth:38" name="txtSearch" />
                </div>
                <div style="margin:5px; width:98%; text-align:left; float:left;">
                    <table id="tblSearch" title="Search Results" style="height:305px;">
                        <thead>
                            <tr>
                                <th data-options="field:'Code',width:120,align:'center'">Code</th>
                                <th data-options="field:'Description',width:256,align:'left'">Description</th>
                            </tr>
                        </thead>
                    </table>
                </div>

     </div>
    </form>
    
    <script type="text/javascript">

        function getValue(SQL,DBName,ControlId)
        {
            var data = {SQL: SQL, DBName: DBName}

            data = JSON.stringify(data);

            $.ajax({
                type: "POST",
                url: "AjaxFunctions.aspx/getValue",
                data: data,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (response) {
                    if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                        alertify.error(response.d);
                    }
                    else {
                        var control = document.getElementById(ControlId);
                        if(  control != null && control.type == "text")
                        { 
                            $('#' + ControlId).textbox('setText', response.d);
                        }
                        else if (control != null && control.type == "label") {
                            $('#' + ControlId).val(response.d);
                        }
                    }
                },
                failure: function (response) {

                }
            });
        }

        $(document).ready(function () {

            $("#SearchBox").dialog({
                title: "Search Record",
                width: 420,
                height: 440,
                top: ((window.outerHeight - 400) / 2) - 50,
                left: (window.outerWidth - 400) / 2,
                closed: true,
                modal: true
            });
        });

        function BuildSearchSql(sqlValue)
        {
            var element = document.getElementById(Global_ControlId);
            var fields = element.dataset.filterfields.split(",");
            var criteria = "";
            for (var i = 0; i <= fields.length - 1; i++) {
                if (i == 0)
                    criteria += " WHERE " + fields[i] + " LIKE '%" + sqlValue + "%'";
                else if (i > 0)
                    criteria += " OR " + fields[i] + " LIKE '%" + sqlValue + "%'";
            }

            return element.dataset.selectsql + criteria;
        }

        function ShowSearchBox(TextBoxID) {
            Global_ControlId = TextBoxID;
            $('#SearchBox').dialog({title: $('#' + Global_ControlId).data('searchtitle')})
            $('#SearchBox').dialog('open');
            $('#txtSearch').textbox({
                inputEvents: $.extend({}, $.fn.textbox.defaults.inputEvents, {
                    keyup: function (e) {

                        FillSearchGrid(1, 10, BuildSearchSql($(this).val()));
                    }
                })
            })

            FillSearchGrid(1, 10, BuildSearchSql(""));
            $('#txtSearch').textbox('textbox').focus();
        }

        function FillSearchGrid(PageNumber, PageSize, sql)
        {
            var data = { PageNumber: PageNumber, PageSize: PageSize, sql: sql }
            data = JSON.stringify(data);
            $.ajax({
                type: "POST",
                url: "AccountType.aspx/Search",
                data: data,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.indexOf("Error:") > -1 && response.d.substr(0, 6) == "Error:") {
                        alertify.error(response.d);
                    }
                    else {

                        $('#tblSearch').datagrid({
                            data: JSON.parse(response.d),
                            singleSelect: true,
                            resizable: true,
                            pageList: [5, 10, 20, 30, 40, 50],
                            scrollbarSize: 5,
                            onClickRow: function (i, r) {

                            },
                            onDblClickRow: function (i, r) {

                                var array = $.map(r, function (value, index) {
                                    return [value];
                                });

                                $('#' + Global_ControlId).textbox('setText', array[$('#' + Global_ControlId).data('fieldindex')]);
                                $('#SearchBox').dialog('close');
                                $('#tblSearch').datagrid({ data: [] });

                            },
                            onDblClickCell: function (index, field, value) {
                                
                            },
                            onLoadSuccess: function (data) {
                                $('#tblSearch').datagrid('getPager').pagination({
                                    showRefresh: false,
                                    onSelectPage: function (pageNumber, pageSize) {

                                        FillSearchGrid(pageNumber, pageSize, sql);
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

        window.onkeyup = function (event) {
           
            if (event.keyCode == 27) {
               
                $('#SearchBox').dialog('close');
            }
        }

        </script>