<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RptViewer.aspx.cs" Inherits="Muntazm.RptViewer" %>
    <%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
    <form id="form1" runat="server">
    <div style="height: 931px; width:100%; background-color: #FFFFFF;">
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" HasToggleGroupTreeButton="False" ToolPanelView="None" HasCrystalLogo="False" Width="100%" ProcessingMode="Remote" SizeToReportContent="True" AsyncRendering="False" EnableParameterPrompt="False" OnInit="CrystalReportViewer1_Init" />
    </div>
    </form>

