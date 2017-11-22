<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChartSpecificationsByDisciplines.ascx.cs" Inherits="VD.Modules.Materials.ChartSpecificationsByDisciplines" %>
<%@ Register Assembly="DevExpress.XtraCharts.v17.1.Web, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>





<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dxwgv" %>
<%@ Register assembly="DevExpress.XtraCharts.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="cc1" %>
<dxchartsui:WebChartControl ID="chartSpecByDisciplines" runat="server" Theme="Glass" DataSourceID="SpecificationsByDisciplinesDS" Height="170px" Width="280px">
                <borderoptions color="#4986A2" />
                 <Titles>
<cc1:ChartTitle Alignment="Near"  Text="Specifications par disciplines" Font="Tahoma, 10pt"></cc1:ChartTitle>
</Titles>
<BorderOptions Color="163, 192, 232"></BorderOptions>
                <diagramserializable>
                    <cc1:SimpleDiagram EqualPieSize="False">
                    </cc1:SimpleDiagram>
                </diagramserializable>
<FillStyle><OptionsSerializable>
<cc1:SolidFillOptions></cc1:SolidFillOptions>
</OptionsSerializable>
</FillStyle>
                     

                <legend Visibility="False"></legend>
                     

                <seriesserializable>
                    <cc1:Series LegendText="Specifications" Name="Series 1" ArgumentDataMember="Discipline" ValueDataMembersSerializable="NB" SynchronizePointOptions="False">
                        <viewserializable>
                            <cc1:PieSeriesView RuntimeExploding="False" Rotation="90">
                            </cc1:PieSeriesView>
                        </viewserializable>
                        <labelserializable>
                            <cc1:PieSeriesLabel LineVisible="True">
                                <fillstyle>
                                    <optionsserializable>
                                        <cc1:SolidFillOptions />
                                    </optionsserializable>
                                </fillstyle>
                                <pointoptionsserializable>
                                    <cc1:PiePointOptions PointView="ArgumentAndValues">
                                        <argumentnumericoptions format="General" />
                                        <valuenumericoptions format="Percent" Precision="0" />
                                    </cc1:PiePointOptions>
                                </pointoptionsserializable>
                            </cc1:PieSeriesLabel>
                        </labelserializable>
                        <legendpointoptionsserializable>
                            <cc1:PiePointOptions PointView="ArgumentAndValues">
                                <argumentnumericoptions format="General" />
                                <valuenumericoptions format="Percent" Precision="0" />
                            </cc1:PiePointOptions>
                        </legendpointoptionsserializable>
                    </cc1:Series>
                </seriesserializable>

<SeriesTemplate><ViewSerializable>
    <cc1:PieSeriesView RuntimeExploding="False">
    </cc1:PieSeriesView>
</ViewSerializable>
<LabelSerializable>
    <cc1:PieSeriesLabel LineVisible="True">
        <fillstyle>
            <optionsserializable>
                <cc1:SolidFillOptions />
            </optionsserializable>
        </fillstyle>
        <pointoptionsserializable>
            <cc1:PiePointOptions>
                <argumentnumericoptions format="General" />
                <valuenumericoptions format="General" />
            </cc1:PiePointOptions>
        </pointoptionsserializable>
    </cc1:PieSeriesLabel>
</LabelSerializable>
<LegendPointOptionsSerializable>
    <cc1:PiePointOptions>
        <argumentnumericoptions format="General" />
        <valuenumericoptions format="General" />
    </cc1:PiePointOptions>
</LegendPointOptionsSerializable>
</SeriesTemplate>

<CrosshairOptions ArgumentLineColor="222, 57, 205" ValueLineColor="222, 57, 205"><CommonLabelPositionSerializable>
<cc1:CrosshairMousePosition></cc1:CrosshairMousePosition>
</CommonLabelPositionSerializable>
</CrosshairOptions>

<ToolTipOptions><ToolTipPositionSerializable>
<cc1:ToolTipMousePosition></cc1:ToolTipMousePosition>
</ToolTipPositionSerializable>
</ToolTipOptions>
            </dxchartsui:WebChartControl>
<asp:SqlDataSource ID="SpecificationsByDisciplinesDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>" 
    SelectCommand="Materials_GetSpecificationsByDisciplines" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

