<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:extract="http://schemas.geo.admin.ch/V_D/OeREB/1.0/Extract" xmlns:data="http://schemas.geo.admin.ch/V_D/OeREB/1.0/ExtractData" exclude-result-prefixes="extract data" version="1.0">
  <xsl:output method="html" version="5" indent="yes"/>
  <xsl:decimal-format name="swiss" decimal-separator="." grouping-separator="'"/>
  <xsl:template match="extract:GetExtractByIdResponse">
    <html>
      <head>
        <title>
          <xsl:value-of select="data:Extract/data:RealEstate/data:EGRID"/>
          <xsl:text> at </xsl:text>
          <xsl:value-of select="format-dateTime(data:Extract/data:CreationDate,'[Y0001]-[M01]-[D01] [H01]:[m01]:[s01]')"/>
        </title>
        <link href="https://fonts.googleapis.com/css?family=Barlow:400,700" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css?family=Barlow+Semi+Condensed:400,500,700" rel="stylesheet"/>

        <style>
          body {
            background-color: white;
            font-family: 'Barlow Semi Condensed', sans-serif;
            font-size: 0.95em;
          }
          summary {
            font-size: 1.2em;
            margin-top: 10px;
            font-weight: 700;
          }  
          a {
            color: #4C8FBA;
            text-decoration: none;
          }
          .tableContainer {
            border-spacing: 4px;
            width: 100%;
          }  
          .tdDocKey {
            vertical-align: top;
            padding-left: 2em;
            font-weight: 500;
          }    
          .tdDocLast {
            padding-bottom: 15px;
          }
          .tdDocValue {
            vertical-align: top;
          }
        </style>

      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="data:Extract">
    <h2>Auszug Nutzungsplanung</h2>
    <xsl:apply-templates select="data:RealEstate"/>
  </xsl:template>
  <xsl:template match="data:RealEstate">
    <table border="0px" class="tableContainer">
    <col style="width:30%"/>
    <col style="width:70%"/>
      <tr>
        <td><strong>GB-Nr.:</strong></td>
        <td>
          <xsl:value-of select="data:Number"/>
        </td>
      </tr>
      <tr>
        <td><strong>EGRID:</strong></td>
        <td>
          <xsl:value-of select="data:EGRID"/>
        </td>
      </tr>
      <tr>
        <td><strong>NBIdent:</strong></td>
        <td>
          <xsl:value-of select="data:IdentDN"/>
        </td>
      </tr>
      <tr>
        <td><strong>Art:</strong></td>
        <xsl:choose>
          <xsl:when test="data:Type = 'RealEstate'">
            <td>Liegenschaft</td>
          </xsl:when>
          <xsl:otherwise>
            <td>Baurecht</td>
          </xsl:otherwise>
        </xsl:choose>
      </tr>
      <tr>
        <td><strong>Fläche:</strong></td>
        <td><xsl:value-of select="format-number(data:LandRegistryArea, &quot;#'###&quot;, &quot;swiss&quot;)"/>
           m<sup>2</sup> 
        </td>
      </tr>
      <tr>
        <td><strong>Gemeinde:</strong></td>
        <td>
          <xsl:value-of select="data:Municipality"/>
        </td>
      </tr>
      <tr>
        <td><strong>BFS-Nr.:</strong></td>
        <td>
          <xsl:value-of select="data:FosNr"/>
        </td>
      </tr>
      <tr>
        <td><strong>Grundbuch:</strong></td>
        <td>
          <xsl:value-of select="data:SubunitOfLandRegister"/>
        </td>
      </tr>
    </table>
    <xsl:for-each-group select="data:RestrictionOnLandownership" group-by="data:SubTheme">
      <xsl:sort data-type="number" order="ascending" select="((data:SubTheme='Grundnutzung') * 1) + ((data:SubTheme='Überlagernde Festlegung') * 2) + ((data:SubTheme='Lärmempfindlichkeitsstufen (in Nutzungszonen)') * 3) + ((data:SubTheme='Erschliessung (Linienobjekt)') * 4) + ((data:SubTheme='Orange') * 5)"/>
      <details>
      <summary>
        <xsl:value-of select="data:SubTheme"/>
      </summary>
      <p>
      <xsl:for-each select="current-group()">
        <table border="0px" class="tableContainer">
          <col width="30%"/>
          <col width="70%"/>
          <tr>
            <td><strong>Bezeichnung:</strong></td>
            <td>
              <xsl:value-of select="data:Information/data:LocalisedText/data:Text"/>
            </td>
          </tr>
          <tr>
            <td><strong>Kantonaler Code:</strong></td>
            <td>
              <xsl:value-of select="data:TypeCode"/>
            </td>
          </tr>
          <tr>
            <td><strong>Rechtsstatus:</strong></td>
            <td>
              <xsl:value-of select="data:Lawstatus/data:Text/data:Text"/>
            </td>
          </tr>

          <tr>
            <xsl:choose>
              <xsl:when test="data:AreaShare">
                <td><strong>Fläche:</strong></td>
              </xsl:when>
              <xsl:when test="data:LengthShare">
                <td><strong>Länge:</strong></td>
              </xsl:when>
              <xsl:otherwise>
                <td><strong>Objekte:</strong></td>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
              <xsl:when test="data:AreaShare">
                <td><xsl:value-of select="format-number(data:AreaShare, &quot;#'###&quot;, &quot;swiss&quot;)"/> m<sup>2</sup> (<xsl:value-of select="format-number(data:PartInPercent, &quot;#'###&quot;, &quot;swiss&quot;)"/> %)</td>
              </xsl:when>
              <xsl:when test="data:LengthShare">
                <td><xsl:value-of select="format-number(data:LengthShare, &quot;#'###&quot;, &quot;swiss&quot;)"/> m</td>
              </xsl:when>
              <xsl:otherwise>
                <td>
                  <xsl:value-of select="data:NrOfPoints"/>
                </td>
              </xsl:otherwise>
            </xsl:choose>
          </tr>

          <xsl:if test="data:LegalProvisions">
            <tr>
              <td><strong>Dokumente:</strong></td>
              <td></td>
            </tr>
            <xsl:for-each select="data:LegalProvisions">
              <tr>
                <td class="tdDocKey">Titel:</td>
                <td class="tdDocValue">
                  <xsl:value-of select="data:Title/data:LocalisedText/data:Text"/>
                </td>
              </tr>
              <tr>
                <td class="tdDocKey">Abkürzung:</td>
                <td class="tdDocValue">
                  <xsl:value-of select="data:Abbreviation/data:LocalisedText/data:Text"/>
                </td>
              </tr>
              <tr>
                <td class="tdDocKey">Offizieller Titel:</td>
                <td class="tdDocValue">
                  <xsl:value-of select="data:OfficialTitle/data:LocalisedText/data:Text"/>
                </td>
              </tr>
              <tr>
                <td class="tdDocKey">Nummer:</td>
                <td class="tdDocValue">
                  <xsl:value-of select="data:OfficialNumber"/>
                </td>
              </tr>
              <tr>
                <td class="tdDocKey tdDocLast">Link:</td>
                <td class="tdDocValue">
                  <a><xsl:attribute name="href">
                    <xsl:value-of select="data:TextAtWeb/data:LocalisedText/data:Text"/></xsl:attribute><xsl:attribute name="target">_blank</xsl:attribute> 
                    <xsl:value-of select="data:TextAtWeb/data:LocalisedText/data:Text"/> 
                  </a>                
                </td>
              </tr>
            </xsl:for-each>
          </xsl:if>
        </table>
      </xsl:for-each>
    </p>  
    </details>
    </xsl:for-each-group>
  </xsl:template>
</xsl:stylesheet>
