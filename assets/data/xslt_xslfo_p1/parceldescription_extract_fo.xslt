<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:extract="http://geo.so.ch/schema/AGI/LandRegisterParcelDescription/1.0/Extract" exclude-result-prefixes="extract" version="1.0">
  <xsl:output method="xml" indent="yes"/>
  <xsl:decimal-format name="swiss" decimal-separator="." grouping-separator="'"/>
  <xsl:template match="extract:GetExtractByIdResponse">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsd="https://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
      <fo:layout-master-set>
        <fo:simple-page-master master-name="mainPage" page-height="297mm" page-width="210mm" margin-top="12mm" margin-bottom="12mm" margin-left="15mm" margin-right="12mm">
          <fo:region-body margin-top="45mm" background-color="#FFFFFF"/>
          <fo:region-before extent="40mm" background-color="#FFFFFF"/>
          <fo:region-after extent="10mm" background-color="#FFFFFF"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <xsl:apply-templates/>
    </fo:root>
  </xsl:template>
  <xsl:template match="extract:Extract">
    <fo:page-sequence master-reference="mainPage" id="my-sequence-id">
      <fo:static-content flow-name="xsl-region-before">
        <fo:block>
          <fo:block-container absolute-position="absolute" top="6.7mm" left="0mm" line-height="1em" background-color="#FFFFFF">
            <fo:block font-size="10pt" font-style="italic" font-weight="700" font-family="Frutiger">
              <xsl:value-of select="extract:ResponsibleOffice/extract:Name"/>
            </fo:block>
            <fo:block font-size="10pt" font-style="italic" font-weight="400" font-family="Frutiger" margin-left="6mm" margin-top="1mm">
              <fo:block>
                <xsl:value-of select="extract:ResponsibleOffice/extract:Street"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="extract:ResponsibleOffice/extract:Number"/>
              </fo:block>
              <fo:block>
                <xsl:value-of select="extract:ResponsibleOffice/extract:PostalCode"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="extract:ResponsibleOffice/extract:City"/>
              </fo:block>
              <fo:block>
                <xsl:value-of select="extract:ResponsibleOffice/extract:Phone"/>
              </fo:block>
              <fo:block>
                <xsl:value-of select="extract:ResponsibleOffice/extract:Email"/>
              </fo:block>
              <fo:block>
                <xsl:value-of select="extract:ResponsibleOffice/extract:OfficeAtWeb"/>
              </fo:block>
            </fo:block>
          </fo:block-container>
          <fo:block-container absolute-position="absolute" top="0mm" left="123mm" background-color="#FFFFFF">
            <fo:block>
              <fo:external-graphic height="6.7mm" width="60mm" content-width="scale-to-fit" content-height="scale-to-fit">
                <xsl:attribute name="src">
                  <xsl:text>url('data:</xsl:text>
                  <xsl:text>image/png;base64,</xsl:text>
                  <xsl:value-of select="extract:CantonalLogo"/>
                  <xsl:text>')</xsl:text>
                </xsl:attribute>
              </fo:external-graphic>
            </fo:block>
          </fo:block-container>
        </fo:block>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-after">
        <fo:table table-layout="fixed" width="100%" margin-top="4mm" font-size="7pt" font-style="italic" font-weight="400" font-family="Frutiger">
          <fo:table-column column-width="50%"/>
          <fo:table-column column-width="50%"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell>
                <fo:block>
                  <xsl:value-of select="format-dateTime(extract:CreationDate,'[Y0001]-[M01]-[D01] [H01]:[m01]:[s01]')"/>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right">
                <fo:block>Seite <fo:page-number/>/<fo:page-number-citation-last ref-id="my-sequence-id"/></fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:static-content>
      <xsl:apply-templates select="extract:RealEstate"/>
    </fo:page-sequence>
  </xsl:template>
  <xsl:template match="extract:RealEstate">
    <fo:flow flow-name="xsl-region-body">
      <fo:block-container wrap-option="wrap" hyphenate="false" hyphenation-character="-" font-weight="700" font-size="14pt" font-family="Frutiger">
        <fo:table table-layout="fixed" width="100%">
          <fo:table-column column-width="90mm"/>
          <fo:table-column column-width="90mm"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell>
                <fo:block>Grundstücksbeschrieb</fo:block>
              </fo:table-cell>
              <fo:table-cell>
                <fo:block>GB-Nr. <xsl:value-of select="extract:Number"/></fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:block-container>
      <fo:block-container wrap-option="wrap" hyphenate="false" hyphenation-character="-" font-weight="400" font-size="10pt" font-family="Frutiger">
        <fo:table table-layout="fixed" width="100%" margin-top="8mm">
          <fo:table-column column-width="40mm"/>
          <fo:table-column column-width="30mm"/>
          <fo:table-column column-width="20mm"/>
          <fo:table-column column-width="40mm"/>
          <fo:table-column column-width="30mm"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell font-weight="700" padding-top="2mm">
                <fo:block>Gemeinde:</fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right" padding-top="2mm">
                <fo:block>
                  <xsl:value-of select="extract:Municipality"/>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right" padding-top="2mm">
                <fo:block/>
              </fo:table-cell>
              <fo:table-cell font-weight="700" padding-top="2mm">
                <fo:block>EGRID:</fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right" padding-top="2mm">
                <fo:block>
                  <xsl:value-of select="extract:EGRID"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell font-weight="700" padding-top="2mm">
                <fo:block>Grundbuch:</fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right" padding-top="2mm">
                <fo:block>
                  <xsl:value-of select="extract:SubunitOfLandRegister"/>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right" padding-top="2mm">
                <fo:block/>
              </fo:table-cell>
              <fo:table-cell font-weight="700" padding-top="2mm">
                <fo:block>NBIdent:</fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right" padding-top="2mm">
                <fo:block>
                  <xsl:value-of select="extract:IdentND"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:block-container>
      <fo:block-container wrap-option="wrap" hyphenate="false" hyphenation-character="-" font-weight="400" font-size="10pt" font-family="Frutiger">
        <fo:table table-layout="fixed" width="100%" margin-top="12mm">
          <fo:table-column column-width="40mm"/>
          <fo:table-column column-width="30mm"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell font-weight="700" padding-top="2mm">
                <fo:block>Grundstücksart:</fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right" padding-top="2mm">
                <fo:block>
                  <xsl:value-of select="extract:Type"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell font-weight="700" padding-top="2mm">
                <fo:block>Grundstücksfläche:</fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="right" padding-top="2mm">
                <fo:block line-height-shift-adjustment="disregard-shifts"><xsl:value-of select="format-number(extract:LandRegistryArea, &quot;#'###&quot;, &quot;swiss&quot;)"/> m<fo:inline baseline-shift="super" font-size="60%">2</fo:inline></fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:block-container>
      <fo:block-container wrap-option="wrap" hyphenate="false" hyphenation-character="-" font-weight="400" font-size="10pt" font-family="Frutiger">
        <fo:table table-layout="fixed" width="100%" margin-top="12mm">
          <fo:table-column column-width="90mm"/>
          <fo:table-column column-width="90mm"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell font-weight="700" padding-top="2mm">
                <fo:block>Bodenbedeckung:</fo:block>
              </fo:table-cell>
              <fo:table-cell font-weight="700" padding-top="2mm">
                <fo:block>Flurnamen:</fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell font-weight="400" padding-top="1mm">
                <fo:block>
                  <fo:table table-layout="fixed" width="100%" margin-top="0mm">
                    <fo:table-column column-width="50mm"/>
                    <fo:table-column column-width="20mm"/>
                    <fo:table-column column-width="10mm"/>
                    <fo:table-body border-width="0pt" border-style="solid">
                      <xsl:for-each select="extract:LandCoverShare">
                        <xsl:sort select="extract:Type"/>
                        <fo:table-row border-width="0pt" border-style="solid">
                          <fo:table-cell padding-top="1mm">
                            <fo:block>
                              <xsl:value-of select="extract:Type"/>
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell padding-top="1mm">
                            <fo:block text-align="right">
                              <xsl:value-of select="format-number(extract:Area, &quot;#'###&quot;, &quot;swiss&quot;)"/>
                            </fo:block>
                          </fo:table-cell>
                          <fo:table-cell padding-top="1mm">
                            <fo:block margin-left="1mm" line-height-shift-adjustment="disregard-shifts">m<fo:inline baseline-shift="super" font-size="60%">2</fo:inline></fo:block>
                          </fo:table-cell>
                        </fo:table-row>
                      </xsl:for-each>
                      <fo:table-row border-width="0pt" border-style="solid" font-weight="400" font-style="italic">
                        <fo:table-cell padding-top="1mm">
                          <fo:block>Total</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-top="1mm">
                          <fo:block text-align="right">
                            <xsl:value-of select="format-number(sum(extract:LandCoverShare/extract:Area), &quot;#'###&quot;, &quot;swiss&quot;)"/>
                          </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-top="1mm">
                          <fo:block margin-left="1mm" line-height-shift-adjustment="disregard-shifts">m<fo:inline baseline-shift="super" font-size="60%">2</fo:inline></fo:block>
                        </fo:table-cell>
                      </fo:table-row>
                    </fo:table-body>
                  </fo:table>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell font-weight="400" padding-top="2mm">
                <fo:block>
                  <xsl:value-of select="extract:LocalNames"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:block-container>
      <fo:block-container wrap-option="wrap" hyphenate="false" hyphenation-character="-" font-weight="400" font-size="10pt" font-family="Frutiger">
        <fo:table table-layout="fixed" width="100%" margin-top="12mm">
          <fo:table-column column-width="90mm"/>
          <fo:table-column column-width="90mm"/>
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell font-weight="700" padding-top="2mm">
                <fo:block>Grundbuchamt:</fo:block>
              </fo:table-cell>
              <fo:table-cell font-weight="700" padding-top="2mm">
                <fo:block>Nachführungsgeometer:</fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell font-weight="400" padding-top="2mm">
                <fo:block linefeed-treatment="preserve">
                  <xsl:value-of select="extract:LandRegisterOffice/extract:Name"/>
                  <xsl:text>
</xsl:text>
                  <xsl:value-of select="extract:LandRegisterOffice/extract:Line1"/>
                  <xsl:text>
</xsl:text>
                  <xsl:value-of select="extract:LandRegisterOffice/extract:Street"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="extract:LandRegisterOffice/extract:Number"/>
                  <xsl:text>
</xsl:text>
                  <xsl:value-of select="extract:LandRegisterOffice/extract:PostalCode"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="extract:LandRegisterOffice/extract:City"/>
                  <xsl:text>
</xsl:text>
                  <xsl:text>
</xsl:text>
                  <xsl:text>Telefon </xsl:text>
                  <xsl:value-of select="extract:LandRegisterOffice/extract:Phone"/>
                  <xsl:text>
</xsl:text>
                  <xsl:value-of select="extract:LandRegisterOffice/extract:Email"/>
                  <xsl:text>
</xsl:text>
                  <xsl:value-of select="extract:LandRegisterOffice/extract:OfficeAtWeb"/>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell font-weight="400" padding-top="2mm">
                <fo:block linefeed-treatment="preserve">
                  <xsl:value-of select="extract:SurveyorOffice/extract:Name"/>
                  <xsl:text>
</xsl:text>
                  <xsl:value-of select="extract:SurveyorOffice/extract:Line1"/>
                  <xsl:if test="extract:SurveyorOffice/extract:Line2">
                    <xsl:text>
</xsl:text>
                    <xsl:value-of select="extract:SurveyorOffice/extract:Line2"/>
                  </xsl:if>
                  <xsl:text>
</xsl:text>
                  <xsl:value-of select="extract:SurveyorOffice/extract:Street"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="extract:SurveyorOffice/extract:Number"/>
                  <xsl:text>
</xsl:text>
                  <xsl:value-of select="extract:SurveyorOffice/extract:PostalCode"/>
                  <xsl:text> </xsl:text>
                  <xsl:value-of select="extract:SurveyorOffice/extract:City"/>
                  <xsl:text>
</xsl:text>
                  <xsl:text>
</xsl:text>
                  <xsl:text>Telefon </xsl:text>
                  <xsl:value-of select="extract:SurveyorOffice/extract:Phone"/>
                  <xsl:text>
</xsl:text>
                  <xsl:value-of select="extract:SurveyorOffice/extract:Email"/>
                  <xsl:text>
</xsl:text>
                  <xsl:value-of select="extract:SurveyorOffice/extract:OfficeAtWeb"/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:block-container>
      <fo:block-container page-break-before="always" margin="0mm" padding="0mm" space-before="0mm">
        <fo:block margin="0mm" padding="0mm" space-before="0mm">
          <fo:external-graphic height="217mm" width="182mm" content-height="scale-to-fit" margin="0mm" padding="0mm" space-before="0mm" border="0.5pt solid black">
            <xsl:attribute name="src">
              <xsl:text>url('data:</xsl:text>
              <xsl:text>image/png;base64,</xsl:text>
              <xsl:value-of select="extract:Map"/>
              <xsl:text>')</xsl:text>
            </xsl:attribute>
          </fo:external-graphic>
        </fo:block>
      </fo:block-container>
    </fo:flow>
  </xsl:template>
</xsl:stylesheet>
