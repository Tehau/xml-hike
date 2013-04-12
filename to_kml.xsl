<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" encoding="utf-8" indent="yes" />
    <xsl:template match="/">

        <kml xmlns="http://www.opengis.net/kml/2.2">
            <Document>
                <Placemark>
                    <name><xsl:value-of select="randonnee/nom" /></name>
                    <description>
                        <xsl:value-of select="randonnee/introduction" />
                    </description>
                    <LineString>
                        <coordinates>
                            <xsl:apply-templates select="randonnee/etapes/etape/loc" />
                        </coordinates>
                    </LineString>
                </Placemark>
                <xsl:apply-templates select="randonnee/etapes/etape" />
            </Document>
        </kml>

    </xsl:template>

    <!-- 
         Appel des templates 
    -->
    <xsl:template match="loc">
        <xsl:call-template name="path" />
    </xsl:template>

    <xsl:template match="etape">
        <xsl:call-template name="steps" />
    </xsl:template>


    <!-- 
         Definition des templates 
    -->
    <xsl:template name="path">
        <xsl:value-of select="longitude" />,<xsl:value-of select="latitude" />
    </xsl:template>

    <xsl:template name="steps">
        <Placemark>
            <name><xsl:value-of select="titre" /></name>
            <description>
                <xsl:value-of select="description" />
            </description>
            <Point>
                <coordinates>
                    <xsl:value-of select="loc/longitude" />,<xsl:value-of select="loc/latitude" />
                </coordinates>
            </Point>
        </Placemark>
    </xsl:template>

</xsl:stylesheet>
