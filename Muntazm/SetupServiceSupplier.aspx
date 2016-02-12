<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SetupServiceSupplier.aspx.cs" Inherits="Muntazm.SetupServiceSupplier" %>

<form id="SetupLocation" runat="server">
        <div class="row">   
            <div class="column column-11">  
                <div class="easyui-panel" title="Service Supplier">
                    <!--Start Row-->
                    <div class="row">
                        <!--Left Panel-->
                        <div class="column column-6">
                            <!--Start of service supplier grid-->
                            <div class="row">
                                <div class="column column-12">
                                    <table id="CostMainheadSetup_tblSetupBanks" class="responsive-control" title="Service Supplier">
                                        <thead>
                                            <tr>
                                                <th data-options="field:'id',width: 80,align:'center'">ID</th>
                                                <th data-options="field:'description',width: 443,align:'center'">Description</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                            <!--End of Service Supplier grid row-->
                            <!--Start of Service Supplier grid row-->
                            <div class="row">
                                <div class="column column-2">
                                    <label class="lblCaption">Search:</label>
                                </div>
                                <div class="column column-8">
                                    <input type="text" id="CostMainheadSetup_txtSearch" autocomplete="off" class="easyui-textbox responsive-control" placeholder="Enter Search Text" data-options="iconCls:'icon-search',iconWidth:38" />
                                </div>
                            </div>
                            <!--End of Search box row-->
                            <!--Change to service supplier row-->
                            <div class="row">
                                <div class="column column-2">
                                    <div class="column column-3">
                                        <label class="lblCaption">ID:</label>
                                    </div>
                                    <div class="column column-6">
                                        <input type="text" id="SetupServiceSupllier_supplierCode" class="easyui-textbox responsive-control" data-options="disabled:true"/>
                                    </div>
                                </div>
                                <div class="column column-10">
                                    <div class="column column-3">
                                        <label class="lblCaption">Description:</label>
                                    </div>
                                    <div class="column column-9">
                                        <input type="text" id="SetupServiceSupllier_supplierDescription" autocomplete="off" class="easyui-textbox responsive-control" />
                                    </div>
                                </div>
                            </div>
                            <!--Change to service supplier row end-->
                            <!--Contact person grid row-->
                            <div class="row">
                                <div class="column column-12">
                                    <table id="SetupServiceSupplier_contactPerson" class="responsive-control" title="Service Supplier">
                                        <thead>
                                            <tr>
                                                <th data-options="field:'name',width: 80,align:'center'">Name</th>
                                                <th data-options="field:'designation',width: 443,align:'center'">Designation</th>
                                                <th data-options="field:'directline',width: 443,align:'center'">Direct Line</th>
                                                <th data-options="field:'email',width: 443,align:'center'">Email</th>
                                                <th data-options="field:'cellphone',width: 443,align:'center'">Cell Phone</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                            <!--Contact person grid row end-->
                            <!--Tax Exemption row-->
                            <div class="row">
                                <div class="column column-6">
                                    <label class="lblCaption"><input type="checkbox" id="SetupServiceSupplier_chkSalesTax" /> Sales Tax Exemption</label>
                                </div>
                                <div class="column column-6">
                                    <label class="lblCaption"><input type="checkbox" id="SetupServiceSupplier_chkIncomeTax" /> Income Tax Exemption</label>
                                </div>
                            </div>
                            <!--Tax Exemption row end-->
                            <!--Start Date row-->
                            <div class="row">
                                <div class="column column-6">
                                    <label class="lblCaption"> Start Date </label><input type="date" id="SetupServiceSupplier_dpSTStartDate" />
                                </div>
                                <div class="column column-6">
                                    <label class="lblCaption"> Start Date </label><input type="date" id="SetupServiceSupplier_dpITStartDate" />
                                </div>
                            </div>
                            <!--Start Date row end-->
                            <!--End Date row-->
                            <div class="row">
                                <div class="column column-6">
                                    <label class="lblCaption"> End Date </label><input type="date" id="SetupServiceSupplier_dpSTEndDate" />
                                </div>
                                <div class="column column-6">
                                    <label class="lblCaption"> End Date </label><input type="date" id="SetupServiceSupplier_dpITEndDate" />
                                </div>
                            </div>
                            <!--End Date row end-->
                        </div>
                        <!--End of Left Panel-->
                        <!--Right panel-->
                        <div class="column column-6">
                        </div>
                        <!--End of Right panel-->
                    </div>
                    <!--End Row-->
                </div>
            </div>
            <!--Panel End-->
        </div>
        <!--Row End-->
</form>
