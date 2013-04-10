<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes" />
    <xsl:template match="/">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>

        <html lang="fr">
            <head>
                <meta charset="utf-8" />
                <meta name="author" content="Bertrand 'Kamek' BOUSQUET" />
                <link rel="stylesheet" type="text/css" href="style.css" />
                <title>XML to HTML | Randonnée</title>
                <meta name="description" content="Fiche de randonnée" />
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>

    </xsl:template>


    <!-- Variables CSS a passer en parametre aux templates -->
    <xsl:variable name="class_bandeau">bandeau</xsl:variable>
    <xsl:variable name="class_step">block width550 fleft</xsl:variable>

    
    <!-- 
        Appel des templates definis en fin de documents dans le bon ordre     
    -->
    <xsl:template match="randonnee/bandeau">
        <xsl:call-template name="image">
            <xsl:with-param name="classes" select="$class_step" />
        </xsl:call-template>
    </xsl:template>


    <!-- Definition des templates -->
    <xsl:template name="image">
        <xsl:param name="classes" /> 
        <img>
            <xsl:attribute name="src">
                <xsl:value-of select="image/@src" />
            </xsl:attribute>
            <xsl:attribute name="class"><xsl:value-of select="$classes" /></xsl:attribute>
        </img>
    </xsl:template>

</xsl:stylesheet>
