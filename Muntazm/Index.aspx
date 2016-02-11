<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Muntazm.Index" MasterPageFile="~/Main.Master" %>
<asp:Content ContentPlaceHolderID="cphCenter" runat="server">
    <form runat="server">
        <%--<div style="margin:20px 0;"></div>--%>
        <div id="tt" class="easyui-tabs" data-options="tools:'#tab-tools'" style="width:100%; height:auto;">
        </div>
        <div id="tab-tools">
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'" onclick="addPanel()"></a>
            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-remove'" onclick="removePanel()"></a>
        </div>
    </form>
</asp:Content>

