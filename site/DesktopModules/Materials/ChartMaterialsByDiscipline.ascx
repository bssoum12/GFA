<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChartMaterialsByDiscipline.ascx.cs" Inherits="VD.Modules.Materials.ChartMaterialsByDiscipline" %>
<%@ Register Assembly="DevExpress.XtraCharts.v17.1.Web, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>





<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.XtraCharts.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts" TagPrefix="cc1" %>
<dxchartsui:WebChartControl ID="chartMaterialByDiscipline" runat="server" Theme="Glass" DataSourceID="MaterialsByDisciplinesDS" Height="170px" Width="720px" SmallChartText-Text="">
    <borderoptions color="#4986A2" />
    <diagramserializable>
                    <cc1:XYDiagram>
                        <axisx visibleinpanesserializable="-1">
                            <range sidemarginsenabled="True" />
                            <numericoptions format="General" />
                        </axisx>
                        <axisy visibleinpanesserializable="-1">
                            <range sidemarginsenabled="True" />
                            <numericoptions format="General" />
                        </axisy>
                    </cc1:XYDiagram>
                </diagramserializable>
    <titles>
<cc1:ChartTitle Alignment="Near"  Text="Articles par disciplines" Font="Tahoma, 10pt"></cc1:ChartTitle>
</titles>
    <fillstyle><OptionsSerializable>
<cc1:SolidFillOptions></cc1:SolidFillOptions>
</OptionsSerializable>
</fillstyle>


    <seriesserializable>
                    <cc1:Series LegendText="Disciplines" Name="Series 1" ArgumentDataMember="Discipline" ValueDataMembersSerializable="NB">
                        <viewserializable>
                            <cc1:SideBySideBarSeriesView>
                            </cc1:SideBySideBarSeriesView>
                        </viewserializable>
                        <labelserializable>
                            <cc1:SideBySideBarSeriesLabel LineVisible="True">
                                <fillstyle>
                                    <optionsserializable>
                                        <cc1:SolidFillOptions />
                                    </optionsserializable>
                                </fillstyle>
                                <pointoptionsserializable>
                                    <cc1:PointOptions>
                                        <argumentnumericoptions format="General" />
                                        <valuenumericoptions format="General" />
                                    </cc1:PointOptions>
                                </pointoptionsserializable>
                            </cc1:SideBySideBarSeriesLabel>
                        </labelserializable>
                        <legendpointoptionsserializable>
                            <cc1:PointOptions>
                                <argumentnumericoptions format="General" />
                                <valuenumericoptions format="General" />
                            </cc1:PointOptions>
                        </legendpointoptionsserializable>
                    </cc1:Series>
                </seriesserializable>

    <seriestemplate><ViewSerializable>
<cc1:SideBySideBarSeriesView></cc1:SideBySideBarSeriesView>
</ViewSerializable>
<LabelSerializable>
<cc1:SideBySideBarSeriesLabel LineVisible="True">
<FillStyle><OptionsSerializable>
<cc1:SolidFillOptions></cc1:SolidFillOptions>
</OptionsSerializable>
</FillStyle>
<PointOptionsSerializable>
<cc1:PointOptions>
<ArgumentNumericOptions Format="General"></ArgumentNumericOptions>

<ValueNumericOptions Format="General"></ValueNumericOptions>
</cc1:PointOptions>
</PointOptionsSerializable>
</cc1:SideBySideBarSeriesLabel>
</LabelSerializable>
<LegendPointOptionsSerializable>
<cc1:PointOptions>
<ArgumentNumericOptions Format="General"></ArgumentNumericOptions>

<ValueNumericOptions Format="General"></ValueNumericOptions>
</cc1:PointOptions>
</LegendPointOptionsSerializable>
</seriestemplate>

    <crosshairoptions argumentlinecolor="222, 57, 205" valuelinecolor="222, 57, 205"><CommonLabelPositionSerializable>
<cc1:CrosshairMousePosition></cc1:CrosshairMousePosition>
</CommonLabelPositionSerializable>
</crosshairoptions>

    <tooltipoptions><ToolTipPositionSerializable>
<cc1:ToolTipMousePosition></cc1:ToolTipMousePosition>
</ToolTipPositionSerializable>
</tooltipoptions>
</dxchartsui:WebChartControl>
<asp:SqlDataSource ID="MaterialsByDisciplinesDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetMaterialsByDisciplines" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
