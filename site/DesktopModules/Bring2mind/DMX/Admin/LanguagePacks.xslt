<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
 <xsl:template match="LanguagePacks">
 <table cellspacing="4" cellpadding="4">
  <tbody>
   <tr>
    <th>Package</th>
    <th>Version</th>
    <th colspan="4">Available Packs</th>
   </tr>
   <tr>
    <td></td>
    <td></td>
    <td>Supplier</td>
    <td>% Complete</td>
    <td>Select</td>
    <td>Link</td>
   </tr>
   <xsl:for-each select="./Object[count(Pack) &gt; 0]">
   <xsl:sort case-order="upper-first" order="ascending" select="@friendlyName" />
   <tr>
    <td><xsl:value-of select="@friendlyName" /></td>
    <td><xsl:value-of select="@version" /></td>
     <xsl:call-template name="pack">
      <xsl:with-param name="packnode" select="Pack[position()=1]"></xsl:with-param>
     </xsl:call-template>
   </tr>
    <xsl:for-each select="Pack[position() &gt; 1]">
     <td colspan="2" />
     <xsl:call-template name="pack">
      <xsl:with-param name="packnode" select="."></xsl:with-param>
     </xsl:call-template>
    </xsl:for-each>
  </xsl:for-each>
  </tbody>
 </table>
 </xsl:template>
 <xsl:template name="pack">
  <xsl:param name="packnode" />
  <td>
   <a>
    <xsl:attribute name="href">
     <xsl:value-of select="$packnode/@orgUrl" />
    </xsl:attribute>
    <xsl:value-of select="$packnode/@orgName" />
   </a>
  </td>
  <td>
    <xsl:value-of select="$packnode/@perc" /> %
  </td>
  <td>
   <input type="checkbox" name="SelectedDownloads">
    <xsl:attribute name="value">
     <xsl:value-of select="$packnode/@url" />|<xsl:value-of select="/LanguagePacks/@locale" />|<xsl:value-of select="$packnode/../@name" />|<xsl:value-of select="$packnode/../@version" />
    </xsl:attribute>
   </input>
  </td>
  <td>
   <a>
    <xsl:attribute name="href">
     <xsl:value-of select="$packnode/@url" />
    </xsl:attribute>link
   </a>
  </td>
 </xsl:template>
</xsl:stylesheet>
